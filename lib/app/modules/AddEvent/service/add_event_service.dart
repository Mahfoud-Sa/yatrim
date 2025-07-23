import 'package:get/get.dart';
import 'package:yatrim/app/modules/AddEvent/model/event_type_model.dart';

class PersonalEventService extends GetConnect {
  Future<Response> createPersonalEvent(
      PersonalEvent event, String token) async {
    final response = await post(
      "https://yatrim.pythonanywhere.com/api/v1/accounts/personal_event/",
      event.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'token $token',
      },
    );
    return response;
  }
}
