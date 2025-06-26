import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  late final WebViewController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final String link = ModalRoute.of(context)!.settings.arguments as String;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _controller.runJavaScript('''
              var header = document.querySelector('header');
              if (header) header.remove();

              var nav = document.querySelector('nav');
              if (nav) nav.remove();

              var topbar = document.getElementById('topbar');
              if (topbar) topbar.remove();
            ''');
          },
        ),
      )
      ..loadRequest(Uri.parse(link));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
