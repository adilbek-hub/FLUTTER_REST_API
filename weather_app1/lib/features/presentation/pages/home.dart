import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app1/constants/api_const.dart';
import 'package:weather_app1/features/data/models/weather_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Weather?> fetchData() async {
    final dio = Dio();
    final result = await dio.get(APIConst.address);
    if (result.statusCode == 200) {
      final Weather weather = Weather(
        id: result.data['weather'][0]['id'],
        main: result.data['weather'][0]['main'],
        description: result.data['weather'][0]['description'],
        icon: result.data['weather'][0]['icon'],
      );
      return weather;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: fetchData(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data!.id.toString(),
                    ),
                    Text(
                      snapshot.data!.main,
                    ),
                    Text(
                      snapshot.data!.description,
                    ),
                    Text(
                      snapshot.data!.icon,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.hasError.toString());
              } else {
                return const CircularProgressIndicator();
              }
            })),
      ),
    );
  }
}
