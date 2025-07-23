import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/routes/app_pages.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final routes = [
    Routes.HOME,
    Routes.SEARCH,
    '', // Center FAB has a custom action
    Routes.EVENTS,
    Routes.MY_EVENTS,
  ];

  void changeTab(int index) {
    if (index != 2) {
      // Skip FAB tab
      selectedIndex.value = index;
      Get.offNamed(routes[index],
          id: 1); // Use a nested navigation for the tab pages
    }
  }

  void onFabPressed() {
    selectedIndex.value = 2;
    Get.offNamed(Routes.ADD_EVENT, id: 1);
  }
}

class BottomNavBar extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());

  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          type:
              BottomNavigationBarType.fixed, // Ensure labels are always visible
          selectedItemColor: const Color(0xFF00BB6E),
          unselectedItemColor: const Color(0xFF707070),
          currentIndex: navController.selectedIndex.value,
          onTap: (index) => navController.changeTab(index),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/small_calender.svg',
                color: navController.selectedIndex.value == 0
                    ? const Color(0xFF00BB6E)
                    : const Color(0xFF707070),
              ),
              label: 'التاريخ',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                color: navController.selectedIndex.value == 1
                    ? const Color(0xFF00BB6E)
                    : const Color(0xFF707070),
              ),
              label: 'بحث',
            ),
            BottomNavigationBarItem(
              icon: const SizedBox.shrink(), // Empty space for FAB
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/events.svg',
                color: navController.selectedIndex.value == 3
                    ? const Color(0xFF00BB6E)
                    : const Color(0xFF707070),
              ),
              label: 'مناسبات',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/my_events.svg',
                color: navController.selectedIndex.value == 4
                    ? const Color(0xFF00BB6E)
                    : const Color(0xFF707070),
              ),
              label: 'مناسباتي',
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavWithFab extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());

  BottomNavWithFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        BottomNavBar(),
        Positioned(
          bottom: 20, // Adjust FAB to sit above the navigation bar
          child: FloatingActionButton(
            onPressed: navController.onFabPressed,
            backgroundColor: const Color(0xFF00BB6E),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
