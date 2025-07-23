import 'package:get/get.dart';

class RegisterService extends GetConnect {
  final String baseUrl = "https://yatrim.pythonanywhere.com/api/v1/accounts/";

  @override
  void onInit() {
    // Set the base URL for GetConnect
    httpClient.baseUrl = baseUrl;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
  }

  Future<Response> registerUser({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    String? phone,
  }) {
    return post(
      'register/', // Only the relative path
      {
        'username': username,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'phone': phone ?? '',
      },
    );
  }
}
