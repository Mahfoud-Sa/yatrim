import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yatrim/app/core/theme/translation.dart';

class LanguageController extends GetxController {
  final box = GetStorage();
  var selectedLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();

    // قراءة اللغة المخزنة، وإذا لم تكن موجودة، استخدام لغة الجهاز إذا كانت مدعومة (العربية أو الإنجليزية أو الملايوية)
    String? storedLanguage = box.read('language');
    if (storedLanguage != null) {
      selectedLanguage.value = storedLanguage;
    } else {
      String? deviceLanguage = Get.deviceLocale?.languageCode;
      if (deviceLanguage == 'ar' ||
          deviceLanguage == 'ms' ||
          deviceLanguage == 'en') {
        selectedLanguage.value = deviceLanguage!;
      } else {
        selectedLanguage.value = 'en'; // إذا كانت لغة الجهاز غير مدعومة
      }
    }

    // تحديث لغة التطبيق بناءً على القيمة المختارة
    Get.updateLocale(Locale(selectedLanguage.value));
  }

  // استرجاع الترجمة من الخريطة بناءً على اللغة المختارة والمفتاح
  String translate(String key) {
    return translations[selectedLanguage.value]?[key] ?? key;
  }

  void changeLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    // حفظ اللغة في التخزين المحلي
    box.write('language', languageCode);
    Get.updateLocale(Locale(languageCode));
  }

  // تغيير اللغة وتخزينها بشكل دائم
  // void changeLanguage(String languageCode) {
  //   selectedLanguage.value = languageCode;
  //   // حفظ اللغة في التخزين المحلي
  //   box.write('language', languageCode);

  //   if (languageCode == 'ar') {
  //     Get.updateLocale(const Locale('ar'));
  //   } else if (languageCode == 'en') {
  //     Get.updateLocale(const Locale('en'));
  //   } else if (languageCode == 'ms') {
  //     Get.updateLocale(const Locale('ms'));
  //   }
  // }
}
