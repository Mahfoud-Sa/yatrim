// dual_calendar_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:yatrim/app/modules/home/controllers/home_controller.dart';

class DualCalendarWidget extends GetView<HomeController> {
  const DualCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Arabic weekday names, starting from Saturday
    final weekdays = [
      'السبت',
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة'
    ];

    return Obx(() {
      // حساب كل التواريخ التي نرسمها (بما فيها الأيام السابقة)
      final dates = controller.calendarDates;
      final selectedKey = controller.selectedDate.value;

      return Column(
        children: [
          // Header: تصفح الشهر والهجري/ميلادي
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () => controller.updateMonth(-1),
                ),
                Text(
                  controller.isHijri.value
                      ? '${controller.hijriDate.value.longMonthName} ${controller.hijriDate.value.hYear}'
                      : '${controller.currentDate.value.month} / ${controller.currentDate.value.year}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 20),
                  onPressed: () => controller.updateMonth(1),
                ),
                TextButton.icon(
                  onPressed: controller.toggleCalendarType,
                  icon: const Icon(Icons.sync, size: 18),
                  label: Text(controller.isHijri.value ? 'ميلادي' : 'هجري'),
                ),
              ],
            ),
          ),

          // Weekday headers
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weekdays.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (_, idx) {
              return Center(
                child: Text(
                  weekdays[idx],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),

          // Calendar days grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: dates.length,
              itemBuilder: (_, idx) {
                final date = dates[idx];
                final dayStr = controller.isHijri.value
                    ? HijriCalendar.fromDate(date).hDay.toString()
                    : date.day.toString();
                final dateKey = date.toIso8601String().split('T').first;
                final dayEvents = controller.eventsFor(dateKey);

                // تمييز اليوم الحالي إذا كان
                final isToday = dateKey ==
                    DateTime.now().toIso8601String().split('T').first;

                return GestureDetector(
                  onTap: () => controller.onDateSelected(date),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedKey == dateKey
                          ? Colors.green.withOpacity(0.3)
                          : Colors.transparent,
                      border: Border.all(color: const Color(0xffbfbfbf)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Stack(
                      children: [
                        // رقم اليوم
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Text(
                            dayStr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (date.month ==
                                          controller.currentDate.value.month ||
                                      controller.isHijri.value)
                                  ? (isToday ? Colors.green : Colors.black)
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                        // نقاط الأحداث
                        if (dayEvents.isNotEmpty)
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: dayEvents.map((e) {
                                return Container(
                                  width: 6,
                                  height: 6,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  decoration: BoxDecoration(
                                    color: colorFromHex(e.typeEvent.color),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

// يمكن أن تضعها في ملف utils.dart أو أعلى الـ Widget
Color colorFromHex(String hexColor) {
  final buffer = StringBuffer();
  if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
  buffer.write(hexColor.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
