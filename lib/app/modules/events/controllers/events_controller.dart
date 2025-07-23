import 'package:get/get.dart';
import 'package:yatrim/app/modules/events/model/events_model.dart';
import 'package:yatrim/app/modules/events/service/events_service.dart';

class EventsController extends GetxController {
  final EventService _eventService = EventService();

  var events = <Event>[].obs;
  var filteredEvents = <Event>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // البيانات العامة
  var allDepartments = <Department>[].obs;
  var allEventTypes = <EventType>[].obs;
  var allCities = <City>[].obs;

  // الفلاتر
  var selectedEventType = RxnInt();
  var selectedCity = RxnInt();
  var selectedDateType = Rxn<dynamic>(); // int (0,1) أو 'all'

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  // Renamed to avoid conflict with GetLifeCycleBase.onDelete
  void onControllerDelete() {
    super.onDelete();
    print('[GetX] EventsController onDelete called. Stack:');
    print(StackTrace.current);
  }

  Future<void> fetchEvents() async {
    isLoading.value = true;
    try {
      final responses = await Future.wait([
        _eventService.fetchEvents(),
        _eventService.fetchAllDepartments(),
        _eventService.fetchAllEventTypes(),
        _eventService.fetchAllCities(),
      ]);

      final rawEvents = responses[0] as List<Event>;
      allDepartments.assignAll(responses[1] as List<Department>);
      allEventTypes.assignAll(responses[2] as List<EventType>);
      allCities.assignAll(responses[3] as List<City>);

      // ربط البيانات
      for (var event in rawEvents) {
        event.department = allDepartments
            .firstWhereOrNull((d) => d.id == event.department?.id);
        event.eventType =
            allEventTypes.firstWhereOrNull((e) => e.id == event.eventType?.id);
        event.city = allCities.firstWhereOrNull((c) => c.id == event.city?.id);
      }

      events.assignAll(rawEvents);
      applyFilters();
    } catch (e) {
      errorMessage.value = 'فشل في تحميل البيانات.';
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // تحديث الفلتر
  void updateFilter(String key, dynamic value) {
    switch (key) {
      case 'type':
        selectedEventType.value = value;
        break;
      case 'location':
        selectedCity.value = value;
        break;
      case 'dateType':
        selectedDateType.value = value;
        break;
    }
    applyFilters();
  }

  void applyFilters() {
    var filtered = events;

    if (selectedEventType.value != null) {
      filtered = filtered
          .where((e) => e.eventType?.id == selectedEventType.value)
          .toList()
          .obs;
    }

    if (selectedCity.value != null) {
      filtered =
          filtered.where((e) => e.city?.id == selectedCity.value).toList().obs;
    }

    if (selectedDateType.value != null && selectedDateType.value != 'all') {
      filtered = filtered
          .where((e) => e.typeDate == selectedDateType.value)
          .toList()
          .obs;
    }

    filteredEvents.assignAll(filtered);
  }

  // الفلاتر
  List<Map<String, dynamic>> get departmentNames {
    return allEventTypes
        .map((type) => {
              'displayText': type.name,
              'value': type.id,
            })
        .toList();
  }

  List<Map<String, dynamic>> get cityNames {
    return allCities
        .map((city) => {
              'displayText': city.name,
              'value': city.id,
            })
        .toList();
  }
}
