import 'package:get/get.dart';
import 'package:yatrim/app/modules/MyEvents/model/my_event_model.dart';
import 'package:yatrim/app/modules/events/model/events_model.dart';

class PersonalEventService extends GetConnect {
  final Map<int, EventType> _typeEventCache = {};

  @override
  void onInit() {
    httpClient.baseUrl = 'https://yatrim.pythonanywhere.com/api/v1';
    httpClient.timeout = const Duration(seconds: 15);
    super.onInit();
  }

  Future<void> fetchAllEventTypes() async {
    if (_typeEventCache.isNotEmpty) return;

    final response = await get(
      'https://yatrim.pythonanywhere.com/api/v1/events/events_types/',
    ).timeout(const Duration(seconds: 30));

    if (response.status.hasError) {
      throw Exception('Failed to fetch type events: ${response.statusText}');
    }

    final List<dynamic> typeEventsData = response.body['data'];
    print(typeEventsData);
    for (var t in typeEventsData) {
      final type = EventType.fromJson(t);
      _typeEventCache[type.id] = type;
      print(_typeEventCache[type.id]?.color);
    }
    print(_typeEventCache);
  }

  Future<List<PersonalEvent>> getPersonalEvents(String token) async {
    await fetchAllEventTypes();

    final response = await get(
      'https://yatrim.pythonanywhere.com/api/v1/accounts/personal_event/',
      headers: {'Authorization': token},
    );

    if (response.status.hasError) {
      throw Exception('Error fetching personal events: ${response.statusText}');
    }

    final List<dynamic> data = response.body['data'];
    final List<PersonalEvent> events = [];

    for (var e in data) {
      final typeEventId = int.parse(e['type_event'].toString());
      print(typeEventId);
      final typeEvent = _typeEventCache[typeEventId]!;

      final event = PersonalEvent.fromJson(e, typeEvent);
      events.add(event);
    }

    return events;
  }
}
