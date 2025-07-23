import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yatrim/app/core/widget/bottom_nav_wrapper.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/routes/app_pages.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  final LanguageController languageController = Get.put(LanguageController());
  SplashView({Key? key}) : super(key: key);
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (box.read("token") != null) {
        Get.off(() => BottomNavWrapper());
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF1c4a82),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Distribute space between top and bottom
          children: [
            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Center(
                  child: Image.asset(
                    'assets/image/splash_icon.png',
                    height: 60,
                    width: 200,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 90),
              child: Column(
                children: [
                  Text(
                    languageController.translate('loading'),
                    style: TextStyle(
                      color: Color.fromARGB(206, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Linear Progress Indicator with custom color
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      backgroundColor: const Color(0xFFf1f1f1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF00BB6E)),
                    ),
                  ),
                ],
              ),
            ),
            //  const SizedBox(height: 80),
            // Terms & Conditions text at the bottom
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 70.0, vertical: 40.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: Color.fromARGB(127, 255, 255, 255),
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: languageController.translate("usage_agreement"),
                    ),
                    TextSpan(
                      text: languageController.translate('terms'),
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(125, 255, 255,
                            255), // Change the link color as needed
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the tap event for the Terms & Conditions link.
                        },
                    ),
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
