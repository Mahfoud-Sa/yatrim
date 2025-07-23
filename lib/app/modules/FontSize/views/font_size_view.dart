import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/modules/FontSize/controllers/font_size_controller.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';

class FontSizeScreen extends GetView<FontSizeController> {
  const FontSizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageController.translate('font_size'), // Translated title
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Obx(
              () => Column(
                children: [
                  buildFontSizeOption(
                    label: languageController
                        .translate('default'), // Translated option
                    isSelected: controller.selectedFontSize.value ==
                        languageController.translate('default'),
                    onTap: () => controller.updateFontSize('الأساسي'),
                  ),
                  buildFontSizeOption(
                    label: languageController
                        .translate('large'), // Translated option
                    isSelected: controller.selectedFontSize.value ==
                        languageController.translate('large'),
                    onTap: () => controller.updateFontSize('الكبير'),
                  ),
                  buildFontSizeOption(
                    label: languageController
                        .translate('small'), // Translated option
                    isSelected: controller.selectedFontSize.value ==
                        languageController.translate('small'),
                    onTap: () => controller.updateFontSize('الصغير'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFontSizeOption({
    required String label,
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
