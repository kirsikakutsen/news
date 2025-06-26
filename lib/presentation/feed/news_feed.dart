import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news/models/news_model.dart';
import 'package:news/presentation/feed/news_item.dart';
import 'package:news/repository/news_repository.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  Future<List<NewsResponse>>? futureNews;

  @override
  void initState() {
    super.initState();
    _initNews();
  }

  void _initNews() async {
    try {
      Locale deviceLocale = PlatformDispatcher.instance.locale;
      String languageCode = deviceLocale.languageCode;
      final newsFuture = fetchNews(languageCode);
      setState(() {
        futureNews = newsFuture;
      });
    } catch (e) {
      setState(() {
        futureNews = Future.error("News not available");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: FutureBuilder<List<NewsResponse>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return _buildNewsList(snapshot.data);
          }
        },
      ),
    );
  }
}

Widget _buildNewsList(List<NewsResponse>? newsResponse) {
  return ListView.builder(
    itemCount: newsResponse?.length ?? 0,
    itemBuilder: (context, index) {
      final item = newsResponse?[index];
      return NewsItem(item: item ?? NewsResponse());
    },
  );
}
