import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF00bb6e),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF00bb6e),
      secondary: const Color(0xFF7624F2),
    ),
    //scaffoldBackgroundColor: const Color(0xFF111727),
    appBarTheme: const AppBarTheme(
      //color: Color(0xFF00bb6e),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      // Display styles
      displayLarge: TextStyle(color: Color(0xFFEEEEEE)),
      displayMedium: TextStyle(color: Color(0xFFEEEEEE)),
      displaySmall:
          TextStyle(color: Color(0xFF707070)), // Small uses different color

      // Headline styles
      headlineLarge: TextStyle(color: Color(0xFFEEEEEE)),
      headlineMedium: TextStyle(color: Color(0xFFEEEEEE)),
      headlineSmall:
          TextStyle(color: Color(0xFF707070)), // Small uses different color

      // Title styles
      titleLarge: TextStyle(color: Color(0xFFEEEEEE)),
      titleMedium: TextStyle(color: Color(0xFFEEEEEE)),
      titleSmall:
          TextStyle(color: Color(0xFF707070)), // Small uses different color

      // Body styles
      bodyLarge: TextStyle(color: Color(0xFFEEEEEE)),
      bodyMedium: TextStyle(color: Color(0xFFEEEEEE)),
      bodySmall:
          TextStyle(color: Color(0xFF707070)), // Small uses different color

      // Label styles
      labelLarge: TextStyle(color: Color(0xFFEEEEEE)),
      labelMedium: TextStyle(color: Color(0xFFEEEEEE)),
      labelSmall:
          TextStyle(color: Color(0xFF707070)), // Small uses different color
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFF00bb6e),
      textTheme: ButtonTextTheme.primary,
    ),
    listTileTheme:
        ListTileThemeData(titleTextStyle: TextStyle(color: Color(0xFFEEEEEE))));
