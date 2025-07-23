import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/modules/MyEvents/views/personal_event_detail.dart';
import 'package:yatrim/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/my_events_controller.dart';

class MyEventsView extends GetView<MyEventsController> {
  const MyEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    final languageController = Get.put(LanguageController());
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

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
            languageController
                .translate('my_events'), // Translated key for "مناسباتي"
            style: TextStyle(
              fontSize: 20.sp, // Responsive font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(8.w), // Adjust padding with screen width
          child: Column(
            children: [
              Container(
                height: 160.h, // Adjust height with screen height
                margin: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Color(0xFF00bb6e),
                  borderRadius:
                      BorderRadius.circular(17.r), // Responsive border radius
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.personalEvents.length,
                    itemBuilder: (context, index) {
                      var event = controller.personalEvents[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h), // Responsive padding
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                12.r), // Responsive border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(
                              0, 16.h, 16.w, 16.h), // Responsive padding
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16.0),
                              // Event Details
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => PersonalEventDetailView(),
                                      arguments: event,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Title
                                          Text(
                                            event.name,
                                            style: TextStyle(
                                              fontSize:
                                                  16.sp, // Responsive font size
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF111727),
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          // Date and Time
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today_outlined,
                                                size: 12
                                                    .sp, // Responsive icon size
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                event.dateOnly,
                                                style: TextStyle(
                                                  fontSize: 12
                                                      .sp, // Responsive font size
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time_outlined,
                                                size: 12
                                                    .sp, // Responsive icon size
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                event.timeOnly,
                                                style: TextStyle(
                                                  fontSize: 12
                                                      .sp, // Responsive font size
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 45.w, // Responsive width
                                            height: 45.h, // Responsive height
                                            decoration: BoxDecoration(
                                              color: Color(0xfffcfcff),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8.r), // Responsive radius
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    event.daysToEnd.toString(),
                                                    style: TextStyle(
                                                      fontSize: 12
                                                          .sp, // Responsive font size
                                                      color: Color(0xffb8b8b8),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    languageController
                                                        .translate(
                                                            'day'), // "يوم"
                                                    style: TextStyle(
                                                      fontSize: 12
                                                          .sp, // Responsive font size
                                                      color: Color(0xffb8b8b8),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 40.w),
                                          Container(
                                            width: 7.w, // Responsive width
                                            height: 65.h, // Responsive height
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(event
                                                  .typeEvent.color
                                                  .replaceFirst('#', '0xFF'))),
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.zero,
                                                right: Radius.circular(
                                                    10.r), // Responsive radius
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
