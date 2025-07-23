import 'package:get/get.dart';

import '../controllers/my_events_controller.dart';

class MyEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEventsController>(
      () => MyEventsController(),
    );
  }
}
