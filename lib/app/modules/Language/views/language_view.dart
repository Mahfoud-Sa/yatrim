import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.translate('app_language')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Obx(() {
              return Column(
                children: [
                  buildLanguageOption(
                    label: 'العربية',
                    languageCode: 'ar',
                    isSelected: controller.selectedLanguage.value == 'ar',
                    onTap: () => controller.changeLanguage('ar'),
                  ),
                  buildLanguageOption(
                    label: 'English',
                    languageCode: 'en',
                    isSelected: controller.selectedLanguage.value == 'en',
                    onTap: () => controller.changeLanguage('en'),
                  ),
                  buildLanguageOption(
                    label: 'Bahasa Melayu',
                    languageCode: 'ms',
                    isSelected: controller.selectedLanguage.value == 'ms',
                    onTap: () => controller.changeLanguage('ms'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageOption({
    required String label,
    required String languageCode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.radio_button_checked,
                color: Colors.green,
              )
            else
              const Icon(
                Icons.radio_button_off,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
