import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_free2/features/data/model.dart';
import 'package:news_app_free2/features/data/service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsModel? topNews;
  Future<void> fetchData() async {
    topNews = await DataRepo().fetchData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewsPage'),
      ),
      body: topNews == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: topNews!.articles.length,
              itemBuilder: (context, index) {
                final news = topNews!.articles[index];
                return Card(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2, child: Image.network(news.urlToImage ?? '')),
                      Expanded(flex: 3, child: Text(news.title)),
                    ],
                  ),
                );
              }),
    );
  }
}
