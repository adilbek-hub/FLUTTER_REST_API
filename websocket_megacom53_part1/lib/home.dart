import 'dart:convert';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = '';
  String price = '';
  List<double> data = [];
  webSocketFun() async {
    print('object');
    final wsUrl = Uri.parse('wss://stream.binance.com:9443/ws/etheur@trade');
    var channel = WebSocketChannel.connect(wsUrl);

    channel.stream.listen((message) {
      print(message.runtimeType);
      Map valueMap = json.decode(message);
      print("MMMMMMMM$valueMap");
      print(valueMap.runtimeType);
      name = valueMap["s"];
      price = valueMap["p"];
      data.add(double.tryParse(price) ?? 0.0);
      print(name);
      print(price);
      print(data);
      setState(() {});
    });
  }

  @override
  void initState() {
    webSocketFun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Sparkline(
              data: data,
              gridLinelabelPrefix: '\$',
              gridLineLabelPrecision: 3,
              enableGridLines: true,
              fillMode: FillMode.below,
              fillColor: Colors.red,
              pointsMode: PointsMode.all,
            ),
          ],
        ),
      ),
    );
  }
}
