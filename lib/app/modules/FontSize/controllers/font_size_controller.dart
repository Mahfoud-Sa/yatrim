import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FontSizeController extends GetxController {
  // Reactive variable to track selected font size
  var selectedFontSize = 'الأساسي'.obs;

  // Base scale for text
  final double baseScale = 1.0;

  // Dynamic text scale factor
  double get currentScale {
    if (selectedFontSize.value == 'الصغير') {
      return baseScale - 0.2; // Scale down
    } else if (selectedFontSize.value == 'الكبير') {
      return baseScale + 0.2; // Scale up
    } else {
      return baseScale; // Default scale
    }
  }

  // Update selected font size and refresh theme
  void updateFontSize(String fontSize) {
    selectedFontSize.value = fontSize;

    // Update theme for the entire app
    Get.changeTheme(
      ThemeData(
        textTheme: buildTextTheme(currentScale), // Pass scale factor
        fontFamily: 'IBMPlexSansArabic', // Replace with your app's font
      ),
    );
  }

  // Build global text theme based on the scale factor
  TextTheme buildTextTheme(double scale) {
    return TextTheme(
      bodyLarge: TextStyle(fontSize: 16 * scale),
      bodyMedium: TextStyle(fontSize: 14 * scale),
      bodySmall: TextStyle(fontSize: 12 * scale),
      titleLarge: TextStyle(fontSize: 18 * scale),
      headlineSmall: TextStyle(fontSize: 20 * scale),
      headlineMedium: TextStyle(fontSize: 22 * scale),
      headlineLarge: TextStyle(fontSize: 24 * scale),
    );
  }
}
