import 'package:flutter/material.dart';
import 'package:news/model/article.dart';
import 'package:news/theme/app_text_styles.dart';

class DetailDesctription extends StatelessWidget {
  const DetailDesctription({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Text(
      article.description.toString(),
      textAlign: TextAlign.center,
      style: AppTextStyles.descriptionTextStyle,
    );
  }
}
