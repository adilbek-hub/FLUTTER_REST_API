import 'package:flutter/material.dart';
import 'package:news/components/view_news_card.dart';
import 'package:news/model/countries_news.dart';
import 'package:news/model/top_news.dart';
import 'package:news/services/fetch_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TopNews? topNews;
  Future<void> fetchNews([String? domain]) async {
    topNews == null;
    setState(() {});
    topNews = await TopNewsRepo().fetchTopNews(domain);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFE5722),
        title: const Text(
          'News Agregator',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton<Country>(onSelected: (Country item) async {
            await fetchNews(item.domain);
          }, itemBuilder: (BuildContext context) {
            return countries
                .map((e) => PopupMenuItem(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList();
          })
        ],
      ),
      body: topNews == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: topNews!.article.length,
              itemBuilder: (context, index) {
                final news = topNews!.article[index];
                return NewsCard(news: news);
              }),
    );
  }
}
