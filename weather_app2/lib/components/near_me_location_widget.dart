import 'package:flutter/material.dart';
import 'package:weather_app2/constants/app_colors.dart';

class NearMeLocation extends StatelessWidget {
  const NearMeLocation({
    super.key,
    required this.onPressed,
    required this.cityNameButton,
  });
  final void Function() onPressed;
  final void Function() cityNameButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.near_me,
              color: AppColors.white,
              size: 45,
            ),
          ),
          IconButton(
            onPressed: cityNameButton,
            icon: Icon(
              Icons.location_city,
              color: AppColors.white,
              size: 45,
            ),
          ),
        ],
      ),
    );
  }
}
