import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future main() async {
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
bool isLoading = true;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          String? url = await controllerGlobal.currentUrl();
          print(url);
          if (url.toString() == 'https://jatinkamboj.me/') {
            return true;
          } else {
            controllerGlobal.goBack();
            String? url = await controllerGlobal.currentUrl();
            print('go back' + url.toString());
            return false;
          }
        },
        child: Scaffold(
            body: Stack(
          children: [
            SafeArea(
              child: WebView(
                initialUrl: 'https://jatinkamboj.me/',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controllerGlobal = webViewController;
                },
                onPageFinished: (finished) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ),
            isLoading
                ? Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: Text(
                            'JK',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  )
                : Stack(),
          ],
        )),
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
