import 'package:get/get.dart';

import '../controllers/mosques_controller.dart';

class MosquesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MosquesController>(
      () => MosquesController(),
    );
  }
}
