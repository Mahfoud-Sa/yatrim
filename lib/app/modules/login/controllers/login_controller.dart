import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yatrim/app/core/auth_service.dart';
import 'package:yatrim/app/core/widget/bottom_nav_wrapper.dart';
import 'package:yatrim/app/modules/login/service/login_service.dart';
import 'package:yatrim/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  final box = GetStorage();

  // Validation error messages
  var usernameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;

  final LoginService _loginService = LoginService();

  void validateFields() {
    usernameError.value = username.value.isEmpty ? 'اسم المستخدم مطلوب' : '';
    passwordError.value = password.value.isEmpty ? 'كلمة المرور  مطلوب' : '';
  }

  Future<void> login() async {
    validateFields();
    if (usernameError.isEmpty && passwordError.isEmpty) {
      try {
        final response =
            await _loginService.login(username.value, password.value);

        if (response.statusCode == 200) {
          final body = response.body as Map;
          final success = body['success'] ?? false;
          final message = body['message'] ?? 'Login successful';
          final data = body['data'] ?? {};

          if (success && data.isNotEmpty) {
            final token = data['authtoken'];
            if (token != null) {
              box.write("token", token);
              AuthService.to.login();
              Get.to(BottomNavWrapper());
              print("Login Successful: $data");
              // Navigate to Home
            } else {
              Get.snackbar('Error', 'Authentication token is missing.');
            }
          } else {
            Get.snackbar('Error', message);
          }
        } else {
          final error =
              response.body is Map ? response.body['message'] : response.body;
          Get.snackbar('Error', error ?? 'Login failed.');
        }
      } catch (e) {
        print("Login Error: $e");
        Get.snackbar('Error', 'Something went wrong. Please try again.');
      }
    }
  }

  Future<void> continueAsGuest() async {
    try {
      Get.offNamed(Routes.HOME);
    } catch (error) {
      Get.snackbar('Error', 'Failed to continue as guest: $error');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        email.value = googleUser.email;
        username.value = googleUser.displayName ?? '';
        Get.snackbar('Success', 'Signed in as ${googleUser.displayName}');
      }
    } catch (error) {
      Get.snackbar('Error', 'Google Sign-In failed. Try again.');
    }
  }
}
