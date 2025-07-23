import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/modules/PrayerTimes/controllers/prayer_times_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class PrayerTimesView extends GetView<PrayerTimesController> {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Obx(() => Text(
              controller.mosqueName.value,
              style: GoogleFonts.ibmPlexSansArabic(
                color: const Color(0xff111727),
                fontSize: 20.sp, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )),
        centerTitle: true,
        actions: [
          SizedBox(width: 10.w), // Responsive width
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16.w, vertical: 8.h), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSection(),
            SizedBox(height: 40.h), // Responsive height
            _buildPrayerTimesList(),
            SizedBox(height: 10.h), // Responsive height
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    final languageController = Get.put(LanguageController());
    return Obx(() => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                languageController.translate("today"), // Translated key
                style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 20.sp, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff111727),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                controller.currentDate.value,
                style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 16.sp, // Responsive font size
                  color: const Color(0xff707070),
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                controller.hijriDate.value,
                style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 16.sp, // Responsive font size
                  color: const Color(0xff707070),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }

  Widget _buildPrayerTimesList() {
    return Obx(() => Expanded(
          child: ListView.builder(
            itemCount: controller.prayerTimes.length,
            itemBuilder: (context, index) {
              final prayer = controller.prayerTimes[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(width: 1, color: const Color(0xffe9e9e9)),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 16.h), // Responsive padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.volume_up,
                              color: const Color(0xff00bb6e)), // Green
                          SizedBox(width: 16.w), // Responsive width
                          Text(
                            prayer['time']!,
                            style: GoogleFonts.ibmPlexSansArabic(
                              fontSize: 16.sp, // Responsive font size
                              color: const Color(0xff111727),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        prayer['name']!,
                        style: GoogleFonts.ibmPlexSansArabic(
                          fontSize: 16.sp, // Responsive font size
                          color: const Color(0xff111727),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget _buildFooter() {
    final languageController = Get.put(LanguageController());
    return Obx(() => Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: const Color(0xffbfbfbf)),
            ),
          ),
          padding: EdgeInsets.all(16.w), // Responsive padding
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageController.translate(
                      "method_of_adhan_calculation"), // Translated key
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 12.sp, // Responsive font size
                    color: const Color(0xff8d9098),
                  ),
                ),
                Text(
                  controller.calculationMethod.value,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 16.sp, // Responsive font size
                    color: const Color(0xff8d9098),
                  ),
                ),
                SizedBox(
                  height: 14.h, // Responsive height
                ),
                Text(
                  languageController.translate("location"), // Translated key
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 12.sp, // Responsive font size
                    color: const Color(0xff8d9098),
                  ),
                ),
                Text(
                  controller.location.value,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 16.sp, // Responsive font size
                    color: const Color(0xff8d9098),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
