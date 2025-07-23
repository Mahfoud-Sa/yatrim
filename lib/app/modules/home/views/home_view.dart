import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/core/widget/calender.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.EDIT_PROFILE);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.green,
          ),
          onPressed: () {
            Get.toNamed(Routes.SETTINGS);
          },
        ),
        title: Center(
          child: Text(
            languageController.translate('yatirim_calendar'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header Image Section
            Container(
              height: 152,
              width: 360,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/image/home.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // const SizedBox(height: 18),

            // Prayer Time Section
            // Container(
            //   height: 90,
            //   width: 370,
            //   padding: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     color: Colors.green.shade50,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // Prayer Time Column
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             languageController.translate('fajr'),
            //             style: TextStyle(
            //               color: Colors.green,
            //               fontSize: 22,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           Obx(() => Text(
            //                 controller.prayerTime.value,
            //                 style: TextStyle(
            //                   color: Colors.grey,
            //                   fontSize: 18,
            //                 ),
            //               )),
            //         ],
            //       ),

            //       // Countdown Timer and Location
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: [
            //           // Timer Row
            //           Row(
            //             children: [
            //               const Icon(
            //                 Icons.timer,
            //                 color: Colors.grey,
            //                 size: 12,
            //               ),
            //               const SizedBox(width: 5),
            //               Obx(() => Text(
            //                     controller.remainingTime.value,
            //                     style: TextStyle(
            //                       color: Colors.grey,
            //                       fontSize: 10,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   )),
            //             ],
            //           ),
            //           const SizedBox(height: 8),

            //           // Button Row
            //           Row(
            //             children: [
            //               Obx(() => Row(
            //                     children: [
            //                       const Icon(
            //                         Icons.location_on,
            //                         color: Colors.green,
            //                         size: 18,
            //                       ),
            //                       Text(
            //                         controller.location.value,
            //                         style: TextStyle(
            //                           color: Colors.grey.shade700,
            //                           fontSize: 14,
            //                         ),
            //                       ),
            //                     ],
            //                   )),
            //               const SizedBox(width: 15),
            //               TextButton(
            //                 style: TextButton.styleFrom(
            //                   backgroundColor: Colors.green,
            //                   padding: const EdgeInsets.symmetric(
            //                       horizontal: 12, vertical: 5),
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(10),
            //                   ),
            //                 ),
            //                 onPressed: () {
            //                   Get.toNamed(Routes.MOSQUES);
            //                 },
            //                 child: Text(
            //                   languageController.translate('mosque_prayers'),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //               const SizedBox(width: 8),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 20),

            // Calendar Section
            Expanded(child: DualCalendarWidget()),
            // استبدل القسم الثابت للقائمة أسفل التقويم بـ:

            // Events List Section
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final dateKey = controller.selectedDate.value;
                      final dayEvents = controller.eventsFor(dateKey);

                      if (dayEvents.isEmpty) {
                        return Center(
                            child: Text('لا توجد مناسبات لهذا اليوم'));
                      }

                      return Column(
                        children: dayEvents
                            .map((e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: colorFromHex(e.typeEvent.color),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ListTile(
                                    trailing: Icon(Icons.event,
                                        color: colorFromHex(e.typeEvent.color)),
                                    title: Text(
                                      e.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${e.timeOnly} — انتهاء ${e.dateEnd}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
