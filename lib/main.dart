import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatrim/app/core/auth_service.dart';
import 'package:yatrim/app/core/theme/dark_mode.dart';
import 'package:yatrim/app/modules/FontSize/controllers/font_size_controller.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/modules/Settings/controllers/settings_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // Ensure widget binding for Flutter plugins
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // تهيئة GetStorage
  final authService = await AuthService().init();
  Get.put<AuthService>(authService);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  final LanguageController languageController = Get.put(LanguageController());
  final FontSizeController fontSizeController = Get.put(FontSizeController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Reference screen size (width, height)
      minTextAdapt: true, // Automatically adapt text sizes
      splitScreenMode: true, // Handle split screen scenarios
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            title: "ياتريم",
            debugShowCheckedModeBanner: false,
            locale: Locale(languageController.selectedLanguage.value),

            // Routing
            initialRoute: Routes.SPLASH,
            getPages: AppPages.routes,
            // Apply the light and dark themes
            theme: ThemeData.light().copyWith(
              textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
            ),
            darkTheme: darkTheme.copyWith(
              textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
            ),
            themeMode: controller.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light, // Dynamically toggle theme mode

            // Dynamically scale text using textScaler
            builder: (context, child) {
              final textScaler =
                  TextScaler.linear(fontSizeController.currentScale);

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: textScaler,
                ),
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
