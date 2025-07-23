import 'package:get/get.dart';
import 'package:yatrim/app/modules/events/model/events_model.dart';

class FavoriteService extends GetConnect {
  final String _baseUrl = 'https://yatrim.pythonanywhere.com/api/v1';
  final String _token = '19b9adf68f7cb1501bd8dcf71350bdb97b7c4ebf';

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] = 'Token $_token';
      return request;
    });
  }

  Future<List<Event>> fetchFavorites() async {
    final response = await get('/accounts/event_account/');
    if (response.statusCode == 200) {
      final List data = response.body['data'];
      return data.map((j) => Event.fromJson(j)).toList();
    }
    throw Exception('Failed to load favorites: \${response.statusCode}');
  }
}
