import 'package:flutter/material.dart';
import 'package:smart_board_app/provider/web_browser_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowersScreen extends StatelessWidget {
  final String url;
  const WebBrowersScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    WebBrowserProvider webBrowserProvider = WebBrowserProvider(url);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PopScope(
        canPop: webBrowserProvider.canPop,
        onPopInvoked: (didPop) => webBrowserProvider.handlePop(didPop),
        child: WebViewWidget(controller: webBrowserProvider.controller),
      ),
    );
  }
}
