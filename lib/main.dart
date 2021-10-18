import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

late WebViewController controllerGlobal;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          String? url = await controllerGlobal.currentUrl();
          print(url);
          if (url.toString() == 'https://www.google.com/') {
            return true;
          } else {
            controllerGlobal.goBack();
            String? url = await controllerGlobal.currentUrl();
            print('go back' + url.toString());
            return false;
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: WebView(
              initialUrl: 'https://google.com/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                controllerGlobal = webViewController;
              },
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildShowUrl() {
  //   return FutureBuilder<WebViewController>(
  //     future: controllerGlobal.future,
  //     builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
  //       if (controller.hasData) {
  //          String?  url = await controller.data!.currentUrl();
  //       }
  //     },
  //   );
  // }
}
