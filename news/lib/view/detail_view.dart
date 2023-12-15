import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/components/detail-desctription.dart';
import 'package:news/components/detail_divider.dart';
import 'package:news/components/detail_news_time.dart';
import 'package:news/components/detail_site_button.dart';
import 'package:news/components/detail_title.dart';
import 'package:news/model/article.dart';
import 'package:share_plus/share_plus.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final newsTime = DateFormat('d MMMM y H:m:s').format(
      DateTime.parse(article.publishedAt),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(article.title),
        actions: article.url.isNotEmpty
            ? [
                IconButton(
                  onPressed: () {
                    Share.share(article.url);
                  },
                  icon: const Icon(Icons.share),
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailTitle(article: article),
              const SizedBox(height: 10),
              const DetailDivider(),
              DetailNewsTime(newsTime: newsTime),
              const SizedBox(height: 15),
              Image.network(
                article.urlToImage.toString(),
              ),
              const SizedBox(height: 15),
              DetailDesctription(article: article),
              DetailSiteButton(article: article),
            ],
          ),
        ),
      ),
    );
  }
}
