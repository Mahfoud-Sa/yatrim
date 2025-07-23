import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/modules/Settings/controllers/settings_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatrim/app/routes/app_pages.dart';

class SettingsScreen extends GetView<SettingsController> {
  final LanguageController languageController = Get.put(LanguageController());
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Color(0xFF00BB6E)),
        ),
        title: Text(
          languageController.translate('settings'),
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // رأس الصفحة (Profile Header)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              languageController.translate('live_stream'),
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "hamealkaf@gmail.com",
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 14,
                color: Color(0xFF707070),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fiber_manual_record, color: Colors.red, size: 14),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Color(0xFF00BB6E)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: Color(0xFFE0E0E0)),
          const SizedBox(height: 16),

          // خيارات الإعدادات
          _buildSettingTile(
            title: languageController.translate('edit_personal_info'),
            icon: Icons.person,
            onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
          ),
          _buildSettingTile(
            title: languageController.translate('app_language'),
            icon: Icons.language,
            onTap: () => Get.toNamed(Routes.LANGUAGE),
          ),
          _buildSettingTile(
            title: languageController.translate('font_size'),
            icon: Icons.text_fields,
            onTap: () => Get.toNamed(Routes.FONT_SIZE),
          ),
          // Dark Mode مع تغليف بـ Obx
          // Obx(
          //   () => _buildSwitchTile(
          //     title: languageController.translate('dark_mode'),
          //     value: controller.isDarkMode.value,
          //     onChanged: (value) => controller.toggleDarkMode(),
          //   ),
          //  ),
          // Daily Notifications مع تغليف بـ Obx
          Obx(
            () => _buildSwitchTile(
              title: languageController.translate('daily_notifications'),
              value: controller.dailyNotifications.value,
              onChanged: (value) => controller.toggleDailyNotifications(),
            ),
          ),
          // Event Notifications مع تغليف بـ Obx
          Obx(
            () => _buildSwitchTile(
              title: languageController.translate('event_notifications'),
              value: controller.eventNotifications.value,
              onChanged: (value) => controller.toggleEventNotifications(),
            ),
          ),
          _buildSettingTile(
            title: 'مناسباتي المفضلة',
            icon: Icons.favorite_border,
            onTap: () {
              Get.toNamed(Routes.FAVORITE);
            },
          ),
          _buildSettingTile(
            title: languageController.translate('notification_time'),
            icon: Icons.timer,
            onTap: controller.setDailyNotificationTime,
          ),
          _buildSettingTile(
            title: languageController.translate('share_app'),
            icon: Icons.share,
            onTap: controller.shareApp,
          ),
          _buildSettingTile(
            title: languageController.translate('rate_app'),
            icon: Icons.star,
            onTap: controller.rateApp,
          ),
          _buildSettingTile(
            title: languageController.translate('contact_us'),
            icon: Icons.contact_mail,
            onTap: controller.contactUs,
          ),
          _buildSettingTile(
            title: languageController.translate("check_updates"),
            icon: Icons.update,
            onTap: controller.updateApplication,
          ),
          _buildSettingTile(
            title: languageController.translate("appversion"),
            icon: Icons.info,
            onTap: () async {
              String version = await controller.appVersion();
              Get.defaultDialog(
                title: languageController.translate("appversion"),
                content: Text(
                  "إصدار التطبيق الحالي هو $version",
                  style: GoogleFonts.ibmPlexSansArabic(fontSize: 16),
                ),
                confirm: ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text("حسناً"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لبناء عناصر القائمة
  Widget _buildSettingTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Text(
          title,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Container(
          width: 40,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
              right: BorderSide(width: 1, color: const Color(0xffbfbfbf)),
            ),
          ),
          child: Icon(
            icon,
            color: Color(0xFF00BB6E),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SwitchListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Text(
          title,
          style: GoogleFonts.ibmPlexSansArabic(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Color(0xFF00BB6E),
        inactiveThumbColor: Color(0xFF707070),
        inactiveTrackColor: Color(0xFFEEEEEE),
      ),
    );
  }
}
