import 'package:api_news_app_free/model/source.dart';

class Article {
  Article({
    required this.source,
    this.autor,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
  final Source source;
  final String? autor;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      title: json['title'],
      description: json['description'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }
}
