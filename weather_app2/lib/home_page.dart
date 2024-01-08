import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app2/components/city_name_widget.dart';
import 'package:weather_app2/components/detail_weather_card_widget.dart';
import 'package:weather_app2/components/near_me_location_widget.dart';
import 'package:weather_app2/components/temperature_widget.dart';
import 'package:weather_app2/constants/api_const.dart';
import 'package:weather_app2/main.dart';
import 'package:weather_app2/weather_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Future<Weather?> fetchData() async {
  //   final dio = Dio();
  //   final result = await dio.get(
  //       'https://api.openweathermap.org/data/2.5/weather?q=bishkek,&appid=41aa18abb8974c0ea27098038f6feb1b');
  //   if (result.statusCode == 200) {
  //     final weather = Weather(
  //       id: result.data["weather"][0]["id"],
  //       main: result.data["weather"][0]["main"],
  //       description: result.data["weather"][0]["description"],
  //       icon: result.data["weather"][0]["icon"],
  //     );
  //     return weather;
  //   } else {
  //     return null;
  //   }
  // }

  Weather? weather;
  Future<void> weatherLocation() async {
    setState(() {
      weather = null;
    });
    /*1. КОЛДОНУУЧУ УЧУН ГЕОЛОКАТОР ИШТЕТУУ ҮЧҮН ГЕОЛОКАТОРДУ ИШТЕТҮҮ УРУКСАТЫН АЛУУ ЖАНА КОЛДОНУУЧУНУН ӨЗҮНӨН ТИРКЕМЕСИНДЕ ГЕОЛОКАТОРДУН ИШТЕШИ ТУУРАЛУУ УРУКСАТ СУРОО ТАЛАПТАРЫ*/
    //LocationPermission тибинде улуксат алып жатабыз
    LocationPermission permission = await Geolocator.checkPermission();
    // Эгер колдонуучунун телефонунда локацияны алганга уруксат берилген эмес болсо
    if (permission == LocationPermission.denied) {
      // колдонуучудан уруксат сурадык.
      permission = await Geolocator.requestPermission();
      //колдонуучу кайта уруксат бербей койсо
      if (permission == LocationPermission.always &&
          // колдонуучу тараптан мурда уруксат берилген болсо
          permission == LocationPermission.whileInUse) {
        /*2. ГЕОЛОКАЦИЯНЫ ИШТЕТҮҮ УРУКСАТЫ БЕРИЛСЕ, КОЛДОНУУЧУДАН МАКУЛДУК БОЛСО, КОЛДОНУУЧУ МУРДА ЭЛЕ УРУКСАТ БЕРГЕН БОЛСО КИЙИНКИ ПОЗИЦИЯГА ӨТ*/
        Position position = await Geolocator.getCurrentPosition();
        // Dio(); bul flutter tarabynan ishtelip chykkan packet. Interceptors, Global конфигурация, FormData, Request Request, File Download, Timeout ж.б. колдойт.
        final dio = Dio();
        // dio пакети аркылуу мен берген багыттагы датага бар
        final res = await dio.get(ApiConst.latLongAdress(
            lat: position.latitude, long: position.longitude));
        //Эгер датага баруу ийгиликтүү болсо
        if (res.statusCode == 200) {
          // анда ошол датанын ичиндеги белгиленген объекттерди ал жана аларды weatherге барабарлап кой
          weather = Weather(
            id: res.data['current']['weather'][0]['id'],
            main: res.data['current']['weather'][0]['main'],
            description: res.data['current']['weather'][0]['description'],
            icon: res.data['current']['weather'][0]['icon'],
            city: res.data['timezone'],
            temp: res.data['current']['temp'],
            // country: res.data['sys']['country'],
          );
        }
        setState(() {});
      }
    } else {
      Position position = await Geolocator.getCurrentPosition();
      final dio = Dio();
      final res = await dio.get(ApiConst.latLongAdress(
          lat: position.latitude, long: position.longitude));
      if (res.statusCode == 200) {
        weather = Weather(
          id: res.data['current']['weather'][0]['id'],
          main: res.data['current']['weather'][0]['main'],
          description: res.data['current']['weather'][0]['description'],
          icon: res.data['current']['weather'][0]['icon'],
          city: res.data['timezone'],
          temp: res.data['current']['temp'],
        );
      }

      setState(() {});
    }
  }

  Widget weatherIcon(String iconURL) {
    switch (iconURL) {
      case 'https://openweathermap.org/img/wn/11d@4x.png':
        return Image.asset('assets/1.png', scale: 3);

      case 'https://openweathermap.org/img/wn/09d@4x.png':
        return Image.asset('assets/2.png', scale: 3);
      case 'https://openweathermap.org/img/wn/10d@4x.png':
        return Image.asset('assets/3.png', scale: 3);
      case 'https://openweathermap.org/img/wn/13d@4x.png':
        return Image.asset('assets/4.png', scale: 3);
      case 'https://openweathermap.org/img/wn/50d@4x.png':
        return Image.asset('assets/5.png', scale: 3);
      case 'https://openweathermap.org/img/wn/01d@4x.png':
        return Image.asset('assets/6.png', scale: 3);
      case 'https://openweathermap.org/img/wn/02d@4x.png':
        return Image.asset('assets/7.png', scale: 3);
      default:
        return Image.asset('assets/7.png', scale: 3);
    }
  }

  Future<void> weatherCityNames([String? name]) async {
    Dio dio = Dio();
    final result = await dio.get(ApiConst.cityName(name ?? 'Бишкек'));
    if (result.statusCode == 200) {
      weather = Weather(
        id: result.data['weather'][0]['id'],
        main: result.data['weather'][0]['main'],
        description: result.data['weather'][0]['description'],
        icon: result.data['weather'][0]['icon'],
        city: result.data['name'],
        temp: result.data['main']['temp'],
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    weatherCityNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _myAppBar(),
      body: weather == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/weather.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NearMeLocation(
                        onPressed: weatherLocation, cityNameButton: showBottom),
                    Row(
                      children: [
                        TemperatureWidget(
                          temperature: '${(weather!.temp - 273.2).round()}°C',
                        ),
                        weatherIcon(weather!.icon),
                      ],
                    ),
                    CityNameWidget(
                      city: weather!.city,
                    ),
                    const Row(
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
              ),
            ),
    );
  }

  List<String> cities = [
    'Бишкек',
    'Ош',
    'Каракол',
    'Токмок',
    'Жалал-Абад',
    'Нарын',
    'Талас',
    'Баткен',
  ];
  void showBottom() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 7),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 88, 87, 84),
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (BuildContext context, int index) {
              final city = cities[index];
              return Card(
                child: ListTile(
                  onTap: () async {
                    setState(() {
                      weather = null;
                    });
                    weatherCityNames(city);
                    Text(city);
                    Navigator.pop(context);
                  },
                  title: Text(
                    city,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            },
          ),
        );
      },
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
