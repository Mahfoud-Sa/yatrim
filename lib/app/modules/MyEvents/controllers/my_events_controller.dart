import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yatrim/app/modules/MyEvents/model/my_event_model.dart';
import 'package:yatrim/app/modules/MyEvents/service/my_event_service.dart';
import 'package:yatrim/app/modules/events/model/events_model.dart';
import 'package:yatrim/app/routes/app_pages.dart';

class MyEventsController extends GetxController {
  final _service = PersonalEventService();
  var personalEvents = <PersonalEvent>[].obs;
  final box = GetStorage();

  Future<void> fetchPersonalEvents(String token) async {
    //final events = await _service.getPersonalEvents(token);
    // print(events);
    List<PersonalEvent> sortedEvents = [
      PersonalEvent(
          id: 1,
          dateTime: '2023-05-15T09:30:00',
          name: 'Team Meeting',
          description: 'Weekly project sync',
          dateEnd: '2023-05-15T10:30:00',
          typeEvent: EventType(id: 1, name: 'Work', color: '#4285F4'),
          typeLoop: 0,
          createdAt: '2023-05-10T14:22:00',
          updatedAt: '2023-05-10T14:22:00'),
      PersonalEvent(
          id: 2,
          dateTime: '2023-06-20T18:00:00',
          name: 'Dinner with Friends',
          description: 'At the new Italian restaurant',
          dateEnd: '2023-06-20T20:00:00',
          typeEvent: EventType(id: 2, name: 'Social', color: '#EA4335'),
          typeLoop: 1,
          createdAt: '2023-06-15T09:45:00',
          updatedAt: '2023-06-15T09:45:00'),
      PersonalEvent(
          id: 3,
          dateTime: '2023-07-04T00:00:00',
          name: 'Independence Day',
          description: 'National holiday',
          dateEnd: '2023-07-04T23:59:59',
          typeEvent: EventType(id: 3, name: 'Holiday', color: '#FBBC05'),
          typeLoop: 2,
          createdAt: '2023-01-01T00:00:00',
          updatedAt: '2023-01-01T00:00:00'),
      PersonalEvent(
          id: 4,
          dateTime: '2023-08-12T08:00:00',
          name: 'Doctor Appointment',
          description: 'Annual checkup',
          dateEnd: '2023-08-12T09:00:00',
          typeEvent: EventType(id: 4, name: 'Health', color: '#34A853'),
          typeLoop: 0,
          createdAt: '2023-07-28T16:30:00',
          updatedAt: '2023-07-28T16:30:00'),
      PersonalEvent(
          id: 5,
          dateTime: '2023-09-01T10:00:00',
          name: 'Project Deadline',
          description: 'Submit final deliverables',
          dateEnd: '2023-09-01T17:00:00',
          typeEvent: EventType(id: 1, name: 'Work', color: '#4285F4'),
          typeLoop: 0,
          createdAt: '2023-08-15T11:20:00',
          updatedAt: '2023-08-30T09:15:00'),
      PersonalEvent(
          id: 6,
          dateTime: '2023-10-31T19:00:00',
          name: 'Halloween Party',
          description: 'Costume party at Sarah\'s place',
          dateEnd: '2023-10-31T23:00:00',
          typeEvent: EventType(id: 2, name: 'Social', color: '#EA4335'),
          typeLoop: 1,
          createdAt: '2023-10-01T12:00:00',
          updatedAt: '2023-10-25T15:30:00'),
      PersonalEvent(
          id: 7,
          dateTime: '2023-11-24T12:00:00',
          name: 'Thanksgiving',
          description: 'Family gathering',
          dateEnd: '2023-11-24T18:00:00',
          typeEvent: EventType(id: 5, name: 'Family', color: '#673AB7'),
          typeLoop: 2,
          createdAt: '2023-11-01T10:00:00',
          updatedAt: '2023-11-20T14:00:00'),
      PersonalEvent(
          id: 8,
          dateTime: '2023-12-25T00:00:00',
          name: 'Christmas Day',
          description: '',
          dateEnd: '2023-12-25T23:59:59',
          typeEvent: EventType(id: 3, name: 'Holiday', color: '#FBBC05'),
          typeLoop: 2,
          createdAt: '2023-01-01T00:00:00',
          updatedAt: '2023-01-01T00:00:00'),
      PersonalEvent(
          id: 9,
          dateTime: '2024-01-01T07:00:00',
          name: 'New Year\'s Run',
          description: '5k charity run',
          dateEnd: '2024-01-01T09:00:00',
          typeEvent: EventType(id: 6, name: 'Fitness', color: '#00BCD4'),
          typeLoop: 0,
          createdAt: '2023-12-15T08:45:00',
          updatedAt: '2023-12-30T10:20:00'),
      PersonalEvent(
          id: 10,
          dateTime: '2024-02-14T19:30:00',
          name: 'Valentine\'s Dinner',
          description: 'Romantic dinner for two',
          dateEnd: '2024-02-14T22:00:00',
          typeEvent: EventType(id: 7, name: 'Romance', color: '#E91E63'),
          typeLoop: 1,
          createdAt: '2024-01-20T18:00:00',
          updatedAt: '2024-02-10T12:30:00')
    ];
    personalEvents.assignAll(sortedEvents);
  }

  @override
  void onInit() {
    super.onInit();
    final token = box.read('token');
    print(token);
    if (token != null) {
      fetchPersonalEvents("token $token");
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
