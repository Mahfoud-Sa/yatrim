import 'package:get/get.dart';
import 'package:yatrim/app/modules/events/model/events_model.dart';

class EventService extends GetConnect {
  final String baseUrl = 'https://yatrim.pythonanywhere.com/api/v1';

  Future<List<Event>> fetchEvents() async {
    final response = await get('/events/events/');

    if (response.statusCode == 200) {
      try {
        final List eventsData = response.body['data'];
        return eventsData.map((json) => Event.fromJson(json)).toList();
      } catch (e) {
        throw Exception('Error parsing events: $e');
      }
    } else {
      throw Exception('Failed to load events: ${response.statusCode}');
    }
  }

  Future<List<Department>> fetchAllDepartments() async {
    final response = await get('/events/departmants/');
    if (response.statusCode == 200) {
      final List data = response.body['data'];
      return data.map((json) => Department.fromJson(json)).toList();
    }
    throw Exception('Failed to load departments');
  }

  Future<List<EventType>> fetchAllEventTypes() async {
    final response = await get('/events/events_types/');
    if (response.statusCode == 200) {
      final List data = response.body['data'];
      return data.map((json) => EventType.fromJson(json)).toList();
    }
    throw Exception('Failed to load event types');
  }

  Future<List<City>> fetchAllCities() async {
    final response = await get('/places/cities/');
    if (response.statusCode == 200) {
      final List data = response.body['data'];
      return data.map((json) => City.fromJson(json)).toList();
    }
    throw Exception('Failed to load cities');
  }

  Future<Department> fetchDepartmentById(int id) async {
    final response = await get('/events/departmants/$id/');
    if (response.statusCode == 200 && response.body['success'] == true) {
      return Department.fromJson(response.body['data']);
    }
    throw Exception('Failed to load department');
  }

  Future<EventType> fetchEventTypeById(int id) async {
    final response = await get('/events/events_types/$id/');
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200 && response.body['success'] == true) {
      return EventType.fromJson(response.body['data']);
    }
    throw Exception('Failed to load event type');
  }

  Future<City> fetchCityById(int id) async {
    final response = await get('/places/cities/$id/');
    if (response.statusCode == 200 && response.body['success'] == true) {
      return City.fromJson(response.body['data']);
    }
    throw Exception('Failed to load city');
  }
}
