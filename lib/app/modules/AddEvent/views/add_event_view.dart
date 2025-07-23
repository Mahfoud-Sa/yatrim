import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatrim/app/modules/AddEvent/controllers/add_event_controller.dart';
import 'package:yatrim/app/modules/AddEvent/views/more_options_screen.dart';

class AddEventScreen extends GetView<AddEventController> {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'أضف مناسبة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp, // Responsive font size
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Event Name Input
            TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'عنوان المناسبة',
                hintStyle: TextStyle(
                  color: const Color(0xFFB8B8B8),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp, // Responsive font size
                ),
                filled: true,
                fillColor: const Color(0xFFffffff),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14.r), // Responsive radius
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => controller.eventName.value = value,
            ),
            SizedBox(height: 20.h), // Responsive spacing

            // Date and Time Containers
            Container(
              height: 50.h, // Responsive height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r), // Responsive radius
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: 12.w), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date Picker Button
                  Row(
                    children: [
                      Obx(() => GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: controller.eventDate.value,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: const Color(0xFF00BB6E),
                                      buttonTheme: const ButtonThemeData(
                                          textTheme: ButtonTextTheme.primary),
                                    ),
                                    child: child!,
                                  );
                                },
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
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                '${controller.eventDate.value.toLocal()}'
                                    .split(' ')[0],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(width: 8.w), // Responsive spacing
                      Obx(() => GestureDetector(
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: controller.eventTime.value,
                              );
                              if (pickedTime != null) {
                                controller.eventTime.value = pickedTime;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                controller.eventTime.value.format(context),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),

                  // Label (التاريخ)
                  Text(
                    'التاريخ',
                    style: TextStyle(
                      color: const Color(0xFFB8B8B8),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h), // Responsive spacing

            // Action Buttons
            Row(
              children: [
                // Add Button
                SizedBox(
                  width: 100.w, // Responsive width
                  child: ElevatedButton(
                    onPressed: () {
                      print('Event Added: ${controller.eventName.value}');
                      controller.addEvent();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BB6E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'أضف',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w), // Responsive spacing

                // More Options Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => MoreOptionsScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'خيارات متقدمة',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: const Color(0xff8d9098),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
