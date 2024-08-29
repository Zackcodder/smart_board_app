import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowserProvider extends ChangeNotifier {
  bool canPop = false;
  late WebViewController controller;

  WebBrowserProvider(String url) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            CircularProgressIndicator();
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void handlePop(didPop) async {
    bool value = await controller.canGoBack();
    if (value) {
      await controller.goBack();
      canPop = !await controller.canGoBack();
      notifyListeners();
    } else {
      canPop = true;
      notifyListeners();
    }
  }
}
