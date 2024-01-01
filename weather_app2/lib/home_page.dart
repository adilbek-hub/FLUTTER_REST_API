import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app2/components/city_name_widget.dart';
import 'package:weather_app2/components/detail_weather_card_widget.dart';
import 'package:weather_app2/components/near_me_location_widget.dart';
import 'package:weather_app2/components/temperature_widget.dart';
import 'package:weather_app2/weather_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Weather?> fetchData() async {
    final dio = Dio();
    final result = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=bishkek,&appid=41aa18abb8974c0ea27098038f6feb1b');
    if (result.statusCode == 200) {
      final weather = Weather(
        id: result.data["weather"][0]["id"],
        main: result.data["weather"][0]["main"],
        description: result.data["weather"][0]["description"],
        icon: result.data["weather"][0]["icon"],
      );
      return weather;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _myAppBar(),
      body: Center(
        child: FutureBuilder<Weather?>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Text('Сиздин интернет байланыщыңыз жок');
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  final weather = snapshot.data;
                  return Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/weather.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NearMeLocation(),
                        TemperatureWidget(
                            temperature: '8',
                            weatherImage:
                                'https://openweathermap.org/img/wn/${weather!.icon}@4x.png'),
                        CityNameWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DetailWeaterCard(),
                            DetailWeaterCard(),
                            DetailWeaterCard(),
                            DetailWeaterCard(),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('Belgisiz kata');
                }
              } else {
                return const Text('Belgisiz kata');
              }
            }),
      ),
    );
  }
}

AppBar _myAppBar() {
  return AppBar(
    title: const Center(
      child: Text(
        'Тапшырма-09',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
