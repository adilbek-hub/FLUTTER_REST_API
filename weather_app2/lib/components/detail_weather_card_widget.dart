import 'package:flutter/material.dart';
import 'package:weather_app2/constants/app_colors.dart';
import 'package:weather_app2/constants/app_text_style.dart';

class DetailWeaterCard extends StatelessWidget {
  const DetailWeaterCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 70,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.detailContainerColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.air,
              color: AppColors.white,
              size: 30,
            ),
            Container(
              width: 25,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.tempContainerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  '8',
                  style: AppTextStyle.detailTempStyle,
                ),
              ),
            ),
            const Text(
              '5pm',
              style: AppTextStyle.detailOclock,
            ),
          ],
        ),
      ),
    );
  }
}
