import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yatrim/app/modules/MyEvents/model/my_event_model.dart';
import 'package:yatrim/app/modules/MyEvents/service/my_event_service.dart';

class MyEventsController extends GetxController {
  final _service = PersonalEventService();
  var personalEvents = <PersonalEvent>[].obs;
  final box = GetStorage();

  Future<void> fetchPersonalEvents(String token) async {
    final events = await _service.getPersonalEvents(token);
    print(events);
    personalEvents.assignAll(events);
  }

  @override
  void onInit() {
    super.onInit();
    final token = box.read('token');
    print(token);
    if (token != null) {
      fetchPersonalEvents("token $token");
    }
  }
}
