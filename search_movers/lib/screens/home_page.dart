import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:search_movers/screens/user_details_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> moves = List<Movie>[];
   List<Movie> movesForDisplay = List<Movie>[];




  Future<MovieModel?> getData() async {  final http.Client client;
    try {
      final response = await http.get(Uri.parse(ApiConst.movieApi));

      if (response.statusCode == 200) {
        final data = movieModelFromJson(response.body);
        return data;
      } else {
        throw Exception('Failed to load computer data');
      }
    } catch (e) {
      print('Кештен ката: ${e.toString()}');
    }
    return null;
  }


final movieService = MovieService(
  client: http.Client(),
);

  
 
} finally {
  client.close();
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return index == 0 ? searchBar() : cardItem(index - 1);
          }),
    );
  }

  searchBar() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(hintText: 'Поиск'),
        onChanged: (value)=> movies=movies.where((move){
          var moveTltle = move.title.to
        }),
      ),
    );
  }

  Card cardItem(int index) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(index.toString()),
        ],
      ),
    );
  }
}
