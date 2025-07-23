// File: lib/app/modules/favorites/controllers/favorite_controller.dart
import 'package:get/get.dart';
import 'package:yatrim/app/modules/events/model/events_model.dart';
import 'package:yatrim/app/modules/favorite/service/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService _service = FavoriteService();

  var favorites = <Event>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    isLoading.value = true;
    try {
      final raw = await _service.fetchFavorites();
      favorites.assignAll(raw);
    } catch (e) {
      errorMessage.value = 'فشل في تحميل المفضلات.';
      print('Error fetching favorites: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
