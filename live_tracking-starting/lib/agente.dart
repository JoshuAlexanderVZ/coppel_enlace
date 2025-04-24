import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BotWebPage extends StatefulWidget {
  const BotWebPage({super.key});

  @override
  State<BotWebPage> createState() => _BotWebPageState();
}

class _BotWebPageState extends State<BotWebPage> {
  late final WebViewController controller;


  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("https://copilotstudio.microsoft.com/environments/Default-a7bc5300-92fc-4ae4-ac76-154a4799f135/bots/cr56e_coppelEnlace/webchat?__version__=2"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coppel Enlace")),
      body: WebViewWidget(controller: controller),
    );
  }
}
