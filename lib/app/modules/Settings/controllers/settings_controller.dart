import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatrim/github_releses_services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController extends GetxController {
  final storage = GetStorage(); // التخزين الدائم
  var isDarkMode = false.obs;
  var dailyNotifications = false.obs;
  var eventNotifications = false.obs;
  var notificationTime = "08:00 AM".obs;
  var selectedLanguage = 'ar'.obs;
  var fontSize = 16.0.obs;

  @override
  void onInit() {
    super.onInit();
    // تحميل الإعدادات المحفوظة من GetStorage
    isDarkMode.value = storage.read('isDarkMode') ?? false;
    dailyNotifications.value = storage.read('dailyNotifications') ?? false;
    eventNotifications.value = storage.read('eventNotifications') ?? false;
    notificationTime.value = storage.read('notificationTime') ?? "08:00 AM";
    // selectedLanguage.value = storage.read('selectedLanguage') ?? 'ar';
    // Get.updateLocale(Locale(selectedLanguage.value));
    fontSize.value = storage.read('fontSize') ?? 16.0;
  }

  void editProfile() {
    // الانتقال إلى شاشة تعديل معلومات المستخدم
    Get.toNamed('/editProfile');
  }

  void changeLanguage(String langCode) {
    selectedLanguage.value = langCode;
    storage.write('selectedLanguage', langCode);
    Get.updateLocale(Locale(langCode));
    Get.snackbar(
      "Language",
      langCode == 'ar'
          ? "تم تغيير اللغة إلى العربية"
          : "Language changed to English",
    );
  }

  void changeFontSize(double newFontSize) {
    fontSize.value = newFontSize;
    storage.write('fontSize', newFontSize);
    Get.snackbar("Font Size", "Font size changed to ${newFontSize.toInt()}");
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    storage.write('isDarkMode', isDarkMode.value);
    Get.snackbar("Theme",
        isDarkMode.value ? "Dark Mode Activated" : "Light Mode Activated");
  }

  void toggleDailyNotifications() {
    dailyNotifications.value = !dailyNotifications.value;
    storage.write('dailyNotifications', dailyNotifications.value);
    Get.snackbar(
        "Notifications",
        dailyNotifications.value
            ? "Daily Notifications Enabled"
            : "Daily Notifications Disabled");
  }

  void toggleEventNotifications() {
    eventNotifications.value = !eventNotifications.value;
    storage.write('eventNotifications', eventNotifications.value);
    Get.snackbar(
        "Notifications",
        eventNotifications.value
            ? "Event Notifications Enabled"
            : "Event Notifications Disabled");
  }

  void setDailyNotificationTime() async {
    // عرض مكون اختيار الوقت
    TimeOfDay? selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      notificationTime.value = selectedTime.format(Get.context!);
      storage.write('notificationTime', notificationTime.value);
      Get.snackbar("Daily Notification",
          "Notification time set to ${notificationTime.value}");
    }
  }

  void shareApp() {
    Share.share(
        "Check out the Yatirim app! Download it here: https://example.com");
  }

  void rateApp() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.example.yatirim';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar("Error", "Could not open the app store.");
    }
  }

  void contactUs() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@yatirim.com',
      query: 'subject=Support Request&body=Write your message here',
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      Get.snackbar("Error", "Could not open email client.");
    }
  }

  void updateApplication() async {
    GitHubApiService githubApiService = GitHubApiService();
    githubApiService.getLatestReleaseWithApk().then((apkUrl) async {
      if (await canLaunch(apkUrl)) {
        await launch(apkUrl);
      } else {
        Get.snackbar("Error", "Could not open the APK download link.");
      }
    }).catchError((error) {
      Get.snackbar("Error", "Failed to check for updates: $error");
    });
  }

  Future<String> appVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return info.version;
    } catch (e) {
      return 'Unknown';
    }
  }
}
//         Get.snackbar("Error", "Could get application version.");
//       }
//     }).catchError((error) {
//       Get.snackbar("Error", "Failed to get application version on iOS: $error");
//     });
//   }
// }
