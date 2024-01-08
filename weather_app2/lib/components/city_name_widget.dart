import 'package:flutter/material.dart';
import 'package:weather_app2/constants/app_text_style.dart';

class CityNameWidget extends StatelessWidget {
  const CityNameWidget({
    super.key,
    required this.city,
  });
  final String city;

  @override
  Widget build(BuildContext context) {
    return Text(
      city,
      style: AppTextStyle.cityStyle,
    );
  }
}
