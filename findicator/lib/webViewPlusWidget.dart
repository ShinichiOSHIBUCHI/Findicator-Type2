import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewPlusWidget extends StatefulWidget {
  String dataSource;
  WebViewPlusWidget({Key? key, required this.dataSource}) : super(key: key);

  //final Completer<WebViewPlusController> controller;

  @override
  State<StatefulWidget> createState() => WebViewPlusWidgetState(dataSource: dataSource);
}

class WebViewPlusWidgetState extends State<WebViewPlusWidget> {
  String dataSource;
  late WebViewPlusController controller;
  WebViewPlusWidgetState({required this.dataSource});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewPlus(
          javascriptMode: JavascriptMode.disabled,
          serverPort: 44013,
          //initialUrl: dataSource,
          onWebViewCreated: (webViewPlusController) {
            controller = webViewPlusController;
            webViewPlusController.loadUrl(dataSource);
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black45,
                spreadRadius: 5,
                blurRadius: 5,
              ),
            ]),
            child: IconButton(
              onPressed: (){
                controller.webViewController.clearCache();
              }, icon: const Icon(Icons.refresh),
            ),
          )
        ),
      ],
    );
  }

}