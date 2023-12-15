import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<dynamic> fetchData() async {
    final dio = Dio();
    final result = await dio.get(
        "https://api.openweathermap.org/data/2.5/weather?q=london,&appid=41aa18abb8974c0ea27098038f6feb1b");
    print(result);
    return result;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //FutureBuilder бул setStateсиз тиркемеге датаны алып келүү үчүн колдонууга болот.
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          return Text(snapshot.toString());
        },
      ),
    );
  }
}
