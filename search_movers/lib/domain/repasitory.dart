import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:search_movers/screens/user_details_page.dart';

class MovieService {
  const MovieService({required this.client});
  final http.Client client;

  List<Movie> parseUser(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    var movie = list.map((e) => Movie.fromJson(e)).toList();
    return movie;
  }

  Future<List<Movie>?> getData() async {
    try {
      final response = await http
          .get(Uri.parse('https://mcuapi.herokuapp.com/api/v1/movies'));

      if (response.statusCode == 200) {
        return compute(parseUser, response.body);
      } else {
        throw Exception('Failed to load computer data');
      }
    } catch (e) {
      print('Кештен ката: ${e.toString()}');
    }
    return null;
  }
}

final movieService = MovieService(
  client: http.Client(),
);
