import 'package:flutter/material.dart';
import 'package:weather_app2/constants/app_text_style.dart';

class CityNameWidget extends StatelessWidget {
  const CityNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Бишкек',
      style: AppTextStyle.cityStyle,
    );
  }
}
