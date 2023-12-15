import 'package:api_news_app_free/api_const.dart';
import 'package:api_news_app_free/detail_view.dart';
import 'package:api_news_app_free/model/article.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});
  final Article news;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailPage(article: news)));
      },
      child: Card(
        color: Colors.grey[300],
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image.network(
                news.urlToImage ?? ApiConst.newsImage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(news.title),
            ),
          ],
        ),
      ),
    );
  }
}
