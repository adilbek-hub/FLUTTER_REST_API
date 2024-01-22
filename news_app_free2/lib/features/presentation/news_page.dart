import 'package:flutter/material.dart';
import 'package:news_app_free2/features/data/countries_model.dart';
import 'package:news_app_free2/features/data/model.dart';
import 'package:news_app_free2/features/data/service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsModel? topNews;
  Future<void> fetchData([String? domain]) async {
    topNews = null;
    setState(() {});
    topNews = await DataRepo().fetchNews(domain);
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
        actions: [
          PopupMenuButton<Countries>(onSelected: (Countries items) async {
            await fetchData(items.domain);
          }, itemBuilder: (BuildContext context) {
            return countries
                .map((e) =>
                    PopupMenuItem<Countries>(value: e, child: Text(e.name)))
                .toList();
          })
        ],
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
                        flex: 2,
                        child: Image.network(news.urlToImage ?? ''),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 3,
                        child: Text(news.title),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
