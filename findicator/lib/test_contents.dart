//import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'videoPlayerWidget.dart';
import 'webViewPlusWidget.dart';

var pages = [
  WebViewPlusWidget(dataSource: 'assets/html/scene1.html'),
  WebViewPlusWidget(dataSource: 'assets/html/scene2.html'),
  WebViewPlusWidget(dataSource: 'assets/html/scene3.html'),
  WebViewPlusWidget(dataSource: 'assets/html/scene4.html'),
  WebViewPlusWidget(dataSource: 'assets/html/scene5.html'),
  WebViewPlusWidget(dataSource: 'assets/html/scene6.html'),
  VideoPlayerWidget(dataSource: 'assets/IMG_0120.MOV'),
];

/*
var pages = [
  [
    WebView(
      javascriptMode: JavascriptMode.disabled,
      onWebViewCreated: (controller) async {
        await _loadHtmlFromAssets(controller, 'assets/html/scene1.html');
      },
    ),
    Container(
      child: const Text("1-2"),
    ),
  ],[
    WebView(
      javascriptMode: JavascriptMode.disabled,
      onWebViewCreated: (controller) async {
        await _loadHtmlFromAssets(controller, 'assets/html/scene2.html');
      },
    ),
    Container(
      child: const Text("2-2"),
    ),
  ],[
    WebView(
      javascriptMode: JavascriptMode.disabled,
      onWebViewCreated: (controller) async {
        await _loadHtmlFromAssets(controller, 'assets/html/scene3.html');
      },
    ),
    Container(
      child: const Text("3-2"),
    ),
  ],[
    WebView(
      javascriptMode: JavascriptMode.disabled,
      onWebViewCreated: (controller) async {
        await _loadHtmlFromAssets(controller, 'assets/html/scene4.html');
      },
    ),
    Container(
      child: const Text("4-2"),
    ),
  ],[
    WebView(
      javascriptMode: JavascriptMode.disabled,
      onWebViewCreated: (controller) async {
        await _loadHtmlFromAssets(controller, 'assets/html/scene5.html');
      },
    ),
    Container(
      child: const Text("5-2"),
    ),
  ],[
    WebView(
      javascriptMode: JavascriptMode.disabled,
      onWebViewCreated: (controller) async {
        await _loadHtmlFromAssets(controller, 'assets/html/scene6.html');
      },
    ),
    Container(
      child: const Text("6-2"),
    ),
  ]
];
*/