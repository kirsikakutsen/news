import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/presentation/details/news_details.dart';
import 'package:news/presentation/feed/news_feed.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      routes: {
        '/': (context) => NewsFeed(),
        '/newsDetails': (context) => NewsDetails(),
      },
    );
  }
}

