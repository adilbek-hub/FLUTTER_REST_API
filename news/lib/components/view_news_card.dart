import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constants/api_const.dart';
import 'package:news/model/article.dart';
import 'package:news/view/detail_view.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
  });

  final Article news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailView(
              article: news,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.grey[100],
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? ApiConst.newsImage,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/errorImage.jpg'),
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
