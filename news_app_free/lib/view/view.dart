import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app_free/constants/api_const.dart';
// import 'package:http/http.dart' as http;
import 'package:news_app_free/model/view_news_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
//TopNewsRepo классынан fetchTopNews() функциясын чакырат, ал Future<TopNews?> кайтарат.
// Күтүүчү оператор бул функциянын аягына чыгышын күтөт жана эң башкы жаңылыктар
// маалыматтарын алгандан кийин, натыйжа topNews өзгөрмөсүнө дайындалат.Андан кийин,
// кодуңуздагы башкы жаңылыктар маалыматтарына кирүү үчүн topNews өзгөрмөсүн колдоно
// аласыз. Мисалы, сиз аны виджетке өткөрүп же анын касиеттерин жаңылык маалыматын
//көрсөтүү үчүн колдоно аласыз.
  TopNews? topNews;
  Future<TopNews?> fetchData() async {
    Dio dio = Dio();
    final response = await dio.get(ApiConst.topNews);
    if (response.statusCode == 200) {
      topNews = TopNews(
        status: response.data['status'],
        totalResults: response.data['totalResults'],
        id: response.data['articles'][0]['source']['id'],
        name: response.data['articles'][0]['source']['name'],
        author: response.data['articles'][1]['author'],
        title: response.data['articles'][2]['title'],
        url: response.data['articles'][4]['url'],
        description: response.data['articles'][3]['description'],
        urlToImage: response.data['articles'][5]['urlToImage'],
        publishedAt: response.data['articles'][6]['publishedAt'],
        content: response.data['articles'][7]['content'],
      );
    }
    setState(() {});
    return topNews;
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
        title: const Text('HomeView'),
      ),
      body: topNews == null
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Text(topNews!.status),
                Text(topNews!.totalResults.toString()),
                Text(topNews!.id),
                Text(topNews!.name),
                Text(topNews!.author.toString()),
                Text(topNews!.id),
                Text(topNews!.title.toString()),
                Text(topNews!.url.toString()),
                Text(topNews!.description.toString()),
                Image.network(
                  topNews!.urlToImage.toString(),
                ),
                Text(topNews!.publishedAt.toString()),
                Text(topNews!.content.toString()),
              ],
            ),
    );
  }
}
