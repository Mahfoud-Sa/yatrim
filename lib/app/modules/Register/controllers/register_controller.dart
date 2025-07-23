import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yatrim/app/core/widget/bottom_nav_wrapper.dart';
import 'package:yatrim/app/modules/register/service/register_service.dart';
import 'package:yatrim/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var countryCode = '+967'.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  // Validation error messages
  var usernameError = ''.obs;
  var emailError = ''.obs;
  var phoneError = ''.obs;

  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  final RegisterService _registerService = RegisterService();

  // GoogleSignIn instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void validateFields() {
    usernameError.value = username.value.isEmpty ? 'اسم المستخدم مطلوب' : '';
    emailError.value = email.value.isEmpty ? 'حساب Gmail مطلوب' : '';
    passwordError.value = password.value.isEmpty ? 'كلمة المرور مطلوبة' : '';
    confirmPasswordError.value =
        confirmPassword.value.isEmpty ? 'تأكيد كلمة المرور مطلوب' : '';

    if (password.value != confirmPassword.value) {
      confirmPasswordError.value = 'كلمات المرور غير متطابقة';
    }
  }

  Future<void> register() async {
    validateFields();
    if (usernameError.isEmpty &&
        emailError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty) {
      try {
        final response = await _registerService.registerUser(
          username: username.value,
          email: email.value,
          password: password.value,
          confirmPassword: confirmPassword.value,
          phone: countryCode.value + phone.value,
        );
        print(
          countryCode.value + phone.value,
        );
        print("Raw Response: ${response.body}"); // Log raw response

        if (response.statusCode == 200) {
          if (response.body is Map) {
            final data = response.body as Map;
            print("Registration Successful: $data");
            Get.to(BottomNavWrapper());
          } else {
            print("Unexpected response type: ${response.body.runtimeType}");
            Get.snackbar('Error', 'Unexpected response format.');
          }
        } else {
          final error = response.body is Map
              ? response.body['message']
              : response.body.toString();
          print(error);
          // Get.snackbar('Error', error ?? 'Registration failed.');
        }
      } catch (e) {
        print("Registration Error: $e");
        Get.snackbar('Error', 'Something went wrong. Please try again.');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        email.value = googleUser.email;
        username.value = googleUser.displayName ?? '';
        Get.snackbar('Success', 'Signed in as ${googleUser.displayName}');
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
      Get.snackbar('Error', 'Google Sign-In failed. Try again.');
    }
  }
}
