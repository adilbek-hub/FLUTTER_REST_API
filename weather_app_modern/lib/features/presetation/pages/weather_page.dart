import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_modern/constants/api_const.dart';
import 'package:weather_app_modern/constants/app_text_styles.dart';
import 'package:weather_app_modern/features/data/model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<Weather?> getWeather() async {
    Dio dio = Dio();
    final result = await dio.get(ApiConst.apiWeather);
    if (result.statusCode == 200) {
      final weather = Weather(
        cityName: result.data['name'],
        temp: result.data['main']['temp'],
        description: result.data['weather'][0]['description'],
      );
      return weather;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getWeather(),
      builder: (c, sn) {
        final weather = sn.data;
        if (sn.connectionState == ConnectionState.none) {
          return Text('Not Connection');
        } else if (sn.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (sn.connectionState == ConnectionState.done) {
          if (sn.hasError) {
            return Text('Error: ${sn.error}');
          } else if (sn.hasData) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weather!.cityName,
                      style: cityTextStyle,
                    ),
                    Text(
                      "${(weather.temp - 273.1).toInt()}°",
                      style: degreeTextStyle,
                    ),
                    Text(
                      weather.description,
                      style: clearTextStyle,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 80,
                          ),
                          child: Image.asset('assets/home.png'),
                        ),
                        Positioned(
                          bottom: 20,
                          child: DefaultTabController(
                            length: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 270,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  _tabBar,
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 222,
                                    child: TabBarView(children: [
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 300,
                                          color: Colors.transparent,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  HearlyForcastCard(),
                                                  HearlyForcastCard(),
                                                  HearlyForcastCard(),
                                                  HearlyForcastCard(),
                                                  HearlyForcastCard(),
                                                ],
                                              )
                                            ],
                                          )),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                        color: Colors.green,
                                        child: const Icon(Icons.abc_outlined),
                                      )
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text('Unknown Error');
          }
        } else {
          return Text('Unknown Error');
        }
      },
    ));
  }

  TabBar get _tabBar {
    return const TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.white,
      tabs: [
        Tab(
          text: 'Hourly Forecast',
        ),
        Tab(
          text: 'Weekly Forecast',
        )
      ],
    );
  }
}

class HearlyForcastCard extends StatelessWidget {
  const HearlyForcastCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 50,
      height: 120,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 12, 26, 52).withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            '12AM',
            style: timeTextStyle,
          ),
          Image.asset('assets/cloud.png'),
          const Text(
            '30%',
            style: prosentTextStyle,
          ),
          const Text(
            '19°',
            style: tempTextStyle,
          )
        ],
      ),
    );
  }
}
