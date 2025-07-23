import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/core/widget/bottom_nav_wrapper.dart';
import 'package:yatrim/app/core/widget/textfield.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/modules/Register/controllers/register_controller.dart';
import 'package:yatrim/app/routes/app_pages.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      backgroundColor: const Color(0xFFfcfcff),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'انشاء حساب جديد',
                style: const TextStyle(
                  color: Color(0xFF111727),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            languageController.translate('welcome'),
                            style: const TextStyle(
                              color: Color(0xFF00BB6E),
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            languageController.translate('in_tarim_calendar'),
                            style: const TextStyle(
                              color: Color(0xFF13151d),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/image/calender.png',
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
              ),
              buildInputField(
                hint: languageController.translate('username'),
                onChanged: (value) => controller.username.value = value,
                error: controller.usernameError,
                type: TextInputType.name,
              ),
              const SizedBox(height: 20),
              buildInputField(
                hint: languageController.translate('gmail_account'),
                onChanged: (value) => controller.email.value = value,
                error: controller.emailError,
                type: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              buildPhoneNumberInputField(
                phoneNumber: controller.phone,
                onChanged: (value) => controller.phone.value = value,
                onChangedCode: (country) =>
                    controller.countryCode.value = '${country.dialCode}',
                error: controller.phoneError,
              ),
              const SizedBox(height: 20),
              buildInputField(
                hint: languageController.translate('password'),
                onChanged: (value) => controller.password.value = value,
                error: controller.passwordError,
              ),
              const SizedBox(height: 20),
              buildInputField(
                hint: languageController.translate('password'),
                onChanged: (value) => controller.confirmPassword.value = value,
                error: controller.confirmPasswordError,
              ),
              const SizedBox(height: 24),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BB6E),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: controller.register,
                      child: Text(
                        languageController.translate('register'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: OutlinedButton(
                      onPressed: controller.signInWithGoogle,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xff484847),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            languageController.translate('log_in_with_google'),
                            style: TextStyle(color: Color(0xFFffffff)),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Image.asset(
                            'assets/image/google_icon.png',
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => BottomNavWrapper());
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Color(0xFFEEEEEE)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'المتابعة كزائر',
                        style: TextStyle(color: Color(0xFF707070)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'إذا كنت تملك حساب قم ',
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(
                      " بتسجيل الدخول ",
                      style: const TextStyle(
                        color: Color(0xFF00BB6E),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  SizedBox(
                    width: 230,
                    child: Text(
                      'باستخدامك لتطبيق "تقويم تريم الهجري والميلادي"، فأنت توافق على الشروط والأحكام',
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
