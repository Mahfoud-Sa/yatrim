import 'package:get/get.dart';

import '../controllers/font_size_controller.dart';

class FontSizeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FontSizeController>(
      () => FontSizeController(),
    );
  }
}
