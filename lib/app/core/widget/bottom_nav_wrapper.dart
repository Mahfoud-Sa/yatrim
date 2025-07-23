import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/core/widget/bottom_navigation_bar.dart';
import 'package:yatrim/app/modules/AddEvent/bindings/add_event_binding.dart';
import 'package:yatrim/app/modules/AddEvent/views/add_event_view.dart';
import 'package:yatrim/app/modules/MyEvents/bindings/my_events_binding.dart';
import 'package:yatrim/app/modules/MyEvents/views/my_events_view.dart';
import 'package:yatrim/app/modules/events/bindings/events_binding.dart';
import 'package:yatrim/app/modules/events/views/events_view.dart';
import 'package:yatrim/app/modules/home/bindings/home_binding.dart';
import 'package:yatrim/app/modules/home/views/home_view.dart';
import 'package:yatrim/app/modules/search/bindings/search_binding.dart';
import 'package:yatrim/app/modules/search/views/search_view.dart';
import 'package:yatrim/app/routes/app_pages.dart';

class BottomNavWrapper extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BottomNavWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Routes.HOME,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.HOME:
              return GetPageRoute(
                page: () => const HomeView(),
                binding: HomeBinding(),
              );
            case Routes.MY_EVENTS:
              return GetPageRoute(
                page: () => const MyEventsView(),
                binding: MyEventsBinding(),
              );
            case Routes.EVENTS:
              return GetPageRoute(
                page: () => const EventsView(),
                binding: EventsBinding(),
              );
            case Routes.SEARCH:
              return GetPageRoute(
                page: () => const SearchView(),
                binding: SearchBinding(),
              );
            case Routes.ADD_EVENT:
              return GetPageRoute(
                page: () => const AddEventScreen(),
                binding: AddEventBinding(),
              );
            default:
              return null;
          }
        },
      ),
      bottomNavigationBar: BottomNavWithFab(), // Your BottomNavWithFab
    );
  }
}
