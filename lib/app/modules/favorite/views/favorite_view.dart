import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart';
import 'package:yatrim/app/modules/favorite/controllers/favorite_controller.dart';
//import 'package:yatrim/app/modules/language/controllers/Language_controller.dart';
import 'package:yatrim/app/modules/events/views/events_view.dart';
import 'package:yatrim/app/routes/app_pages.dart'; // for EventCard

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.green),
          onPressed: () => Get.toNamed(Routes.SETTINGS),
        ),
        title: Center(
          child: Text(
            languageController.translate('favorite_events'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.favorites.isEmpty) {
          return Center(
            child: Text(
              languageController.translate('no_favorites'),
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final event = controller.favorites[index];
            return EventCard(event: event);
          },
        );
      }),
    );
  }
}
