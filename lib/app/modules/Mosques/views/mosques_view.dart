import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/modules/Mosques/controllers/mosques_controller.dart';
import 'package:yatrim/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MosquesView extends GetView<MosquesController> {
  const MosquesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    final languageController = Get.put(LanguageController());
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          languageController
              .translate('prayer_times_for_mosques_in_tarim'), // Translated key
          style: GoogleFonts.ibmPlexSansArabic(
            color: const Color(0xFF111727),
            fontSize: 20.sp, // Adjusted for screen size
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.w), // Adjust padding based on screen width
        child: Obx(() {
          return ListView.builder(
            itemCount: controller.mosques.length,
            itemBuilder: (context, index) {
              final mosque = controller.mosques[index];
              return MosqueTile(name: mosque);
            },
          );
        }),
      ),
    );
  }
}

class MosqueTile extends StatelessWidget {
  final String name;

  const MosqueTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8.h), // Adjust vertical padding based on screen height
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              14.r), // Adjust radius for better responsiveness
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: Icon(
              Icons.mosque,
              color: const Color(0xFF00BB6E), // Green icon
              size: 24.sp, // Adjust icon size based on screen size
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: const Color(0xFF00BB6E), // Green color for the arrow
              size: 24.sp, // Adjust icon size
            ),
            title: Text(
              name,
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 18.sp, // Adjust font size for responsiveness
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111727),
              ),
            ),
            onTap: () {
              Get.toNamed(Routes.PRAYER_TIMES);
            },
          ),
        ),
      ),
    );
  }
}
