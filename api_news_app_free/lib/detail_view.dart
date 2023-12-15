import 'package:api_news_app_free/api_const.dart';
import 'package:api_news_app_free/model/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 173, 113),
        centerTitle: true,
        title: Text(
          article.title,
          overflow: TextOverflow.fade,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text(article.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
            const Divider(
              height: 1.5,
              color: Colors.black,
            ),
            NewsTime(article: article.publishedAt),
            Image.network(article.urlToImage ?? ApiConst.newsImage),
            Text(article.description.toString()),
          ],
        ),
      ),
    );
  }
}

class NewsTime extends StatelessWidget {
  const NewsTime({
    super.key,
    required this.article,
  });

  final String article;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('d MMM, y, h:m').format(DateTime.parse(article));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          color: Colors.grey,
        ),
        SizedBox(width: 10),
        Text(time),
      ],
    );
  }
}
