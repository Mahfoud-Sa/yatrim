import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatrim/app/data/event_type.dart';
import 'package:yatrim/app/modules/AddEvent/controllers/add_event_controller.dart';
import 'package:yatrim/app/modules/AddEvent/views/department_screen.dart';
import 'package:yatrim/app/modules/AddEvent/views/event_type_screen.dart';

class MoreOptionsScreen extends StatelessWidget {
  MoreOptionsScreen({super.key});
  // من الأفضل استخدام نفس المثيل الخاص بـ AddEventController لتجميع البيانات
  final controller = Get.find<AddEventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ختم مسجد الحضار',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // استخدام ScreenUtil للهوامش
        child: ListView(
          children: [
            _buildHeaderDate(context),
            SizedBox(height: 16.h),
            _buildDatePicker(),
            SizedBox(height: 16.h),
            _buildTimePicker(),
            SizedBox(height: 16.h),
            _buildRepeatOption(),
            SizedBox(height: 16.h),
            _buildEventTypeDropdown(),
            SizedBox(height: 16.h),
            _buildDetailsField(),
            SizedBox(height: 24.h),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderDate(BuildContext context) {
    return Column(
      children: [
        const Text(
          '14 شعبان (8) 1445 هـ',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const Text(
          '12:00 ص',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xffbfbfbf),
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: const Text(
            '24 يوم 23 ساعة 33 دقيقة',
            style: TextStyle(color: Color(0xFF000000), fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(() => GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: Get.context!,
                        initialDate: controller.eventDate.value,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        controller.eventDate.value = pickedDate;
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      child: Text(
                        '${controller.eventDate.value.toLocal()}'.split(' ')[0],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          const Text(
            'التاريخ',
            style: TextStyle(
              color: Color(0xFFB8B8B8),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker() {
    return Obx(() => GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: Get.context!,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              controller.notificationTime.value =
                  pickedTime.format(Get.context!);
            }
          },
          child: _buildCustomField(
            hint: 'في الوقت',
            content: controller.notificationTime.value.isEmpty
                ? 'في الوقت'
                : controller.notificationTime.value,
          ),
        ));
  }

  Widget _buildCustomField({
    required String hint,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content.isEmpty ? hint : content,
            style: const TextStyle(color: Color(0xFFB8B8B8)),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildRepeatOption() {
    return GestureDetector(
      onTap: () async {
        // الانتقال إلى صفحة التكرار مع تمرير القيمة الحالية كقيمة ابتدائية
        final selectedRepeat = await Get.to(() => RepetitionScreen(
              initialRepeat: controller.repeatType.value,
            ));
        if (selectedRepeat != null) {
          controller.repeatType.value = selectedRepeat;
        }
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.repeatType.value.isEmpty
                    ? 'بدون تكرار'
                    : controller.repeatType.value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventTypeDropdown() {
    return GestureDetector(
      onTap: () async {
        // ننتقل لصفحة الاختيار ونعيد الـ id فقط (int) أو null
        final selectedId = await Get.to<int?>(() => EventTypeScreen(
              initialSelected: controller.eventType.value.isEmpty
                  ? null
                  : int.tryParse(controller.eventType.value),
            ));

        // إذا عاد لنا id صالح، نخزّنه كسلسلة
        if (selectedId != null) {
          controller.eventType.value = selectedId.toString();
        }
      },
      child: Obx(() {
        final eventTypeIdStr = controller.eventType.value;
        int? eventTypeId = int.tryParse(eventTypeIdStr);
        EventType? selectedEvent;
        Color dotColor = Colors.transparent;
        String label = 'اختر نوع الحدث';

        // لو عندنا id صالح ونوع موجود في الـ enum
        if (eventTypeId != null) {
          selectedEvent = EventType.values.cast<EventType?>().firstWhere(
                (e) => e?.id == eventTypeId,
                orElse: () => null,
              );

          if (selectedEvent != null) {
            dotColor = Color(selectedEvent.color);
            label = selectedEvent.name;
          }
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // الدائرة الصغيرة فقط إذا اخترنا نوعًا
                  if (selectedEvent != null)
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (selectedEvent != null) const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCustomDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
          hint: Text(hint, style: const TextStyle(color: Color(0xFFB8B8B8))),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDetailsField() {
    return TextField(
      maxLines: 3,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: ' التفاصيل',
        hintStyle: TextStyle(
          color: const Color(0xFFB8B8B8),
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
        filled: true,
        fillColor: const Color(0xFFffffff),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.w),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) => controller.details.value = value,
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.snackbar('نجاح', 'تم حفظ المزيد من الخيارات بنجاح');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00BB6E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.w),
          ),
        ),
        child: Text(
          'حفظ',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
