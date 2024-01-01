import 'package:flutter/material.dart';
import 'package:weather_app2/constants/app_text_style.dart';

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({
    super.key,
    required this.temperature,
    required this.weatherImage,
  });
  final String temperature;
  final String weatherImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            temperature,
            style: AppTextStyle.tempStyle,
          ),
          Image.network(
            weatherImage,
            width: 150,
          ),
        ],
      ),
    );
  }
}
