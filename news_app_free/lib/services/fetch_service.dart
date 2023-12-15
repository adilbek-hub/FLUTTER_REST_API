import 'package:http/http.dart' as http;
import 'package:news_app_free/constants/api_const.dart';

Future<void> fetchData() async {
  var url = Uri.https(ApiConst.topNews);
  var response = await http.post(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
