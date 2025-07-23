import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/routes/app_pages.dart';
import 'auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // إذا لم يكن المستخدم مسجلاً، أعد توجيهه لصفحة تسجيل الدخول
    if (!AuthService.to.isLoggedIn.value) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null; // استمر بشكل طبيعي إذا مسجل دخول
  }
}
