import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final box = GetStorage();

  var isLoggedIn = false.obs;

  Future<AuthService> init() async {
    // استرجاع حالة تسجيل الدخول من التخزين
    isLoggedIn.value = box.read('isLoggedIn') ?? false;
    return this;
  }

  void login() {
    isLoggedIn.value = true;
    box.write('isLoggedIn', true);
  }

  void logout() {
    isLoggedIn.value = false;
    box.write('isLoggedIn', false);
  }
}
