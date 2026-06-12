import 'package:flutter/material.dart';
import 'package:movies_app/constents/apis.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrailerView extends StatelessWidget {
  final String youtubeKey;

  const TrailerView({super.key, required this.youtubeKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Trailer"),
        backgroundColor: Colors.black,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse('$youtubeUrl$youtubeKey')),
      ),
    );
  }
}
