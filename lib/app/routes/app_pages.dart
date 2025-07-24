import 'package:get/get.dart';
import 'package:yatrim/app/modules/home/bindings/home_binding.dart';
import 'package:yatrim/app/modules/home/views/home_view.dart';

import '../core/auth_middleware.dart';
import '../modules/EditProfile/bindings/edit_profile_binding.dart';
import '../modules/EditProfile/views/edit_profile_view.dart';
import '../modules/EventDetail/bindings/event_detail_binding.dart';
import '../modules/EventDetail/views/event_detail_view.dart';
import '../modules/FontSize/bindings/font_size_binding.dart';
import '../modules/FontSize/views/font_size_view.dart';
import '../modules/Language/bindings/language_binding.dart';
import '../modules/Language/views/language_view.dart';
import '../modules/Mosques/bindings/mosques_binding.dart';
import '../modules/Mosques/views/mosques_view.dart';
import '../modules/PrayerTimes/bindings/prayer_times_binding.dart';
import '../modules/PrayerTimes/views/prayer_times_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/Settings/bindings/settings_binding.dart';
import '../modules/Settings/views/settings_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PRAYER_TIMES,
      page: () => const PrayerTimesView(),
      binding: PrayerTimesBinding(),
    ),
    GetPage(
      name: _Paths.MOSQUES,
      page: () => const MosquesView(),
      binding: MosquesBinding(),
    ),
    GetPage(
      name: _Paths.EVENT_DETAIL,
      page: () => const EventDetailView(),
      binding: EventDetailBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.FONT_SIZE,
      page: () => const FontSizeScreen(),
      binding: FontSizeBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
