import 'package:get/get_connect/connect.dart';

class LoginService extends GetConnect {
  final String baseUrl = "https://yatrim.pythonanywhere.com/api/v1/accounts/";

  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
  }

  Future<Response> login(String usernameOrEmail, String password) {
    return post(
      'login/',
      {
        'username_or_email': usernameOrEmail,
        'password': password,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
