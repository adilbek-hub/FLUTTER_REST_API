import 'package:http/http.dart' as http;

class TopJsonPlaysholder {
  Future<http.Response> fetchPhotos(http.Client client) async {
    return client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  }
}
