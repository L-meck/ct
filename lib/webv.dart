import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Tired extends StatefulWidget {
  const Tired({Key? key}) : super(key: key);

  //  final Completer<WebViewController> controller;

  @override
  State<Tired> createState() => _TiredState();
}

class _TiredState extends State<Tired> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   // onWillPop: () async=> false, //disable back button
    //   onWillPop: () async {
    //     if (await controller.canGoBack()) {
    //       controller.goBack();
    //       return false;
    //     } else {
    //       return true;
    //     }
    //
    //SHOWING DIALOG BUTTON
    //
    // Future<dynamic> _showMyDialog() async {
    //   return showDialog<void>(
    //     context: context,
    //     barrierDismissible: false, // user must tap button!
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('AlertDialog Title'),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: const <Widget>[
    //               Text('Ad.'),
    //               Text('Interstitial Ad'),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('Close'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    // bool? result = await _showMyDialog();
    // result ??= false;
    // return result;
    // },
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: const Text('pdf'),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              'Quick Google',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => WillPopScope(
                onWillPop: () async {
                  if (await controller.canGoBack()) {
                    controller.goBack();
                    return false;
                  } else {
                    return true;
                  }
                },
                child: Stack(
                  children: [
                    WebView(
                      initialUrl: 'https://www.google.com',
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureRecognizers: gestureRecognizers,
                      //back and forth button
                      onWebViewCreated: (controller) {
                        //
                        this.controller = controller;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4.0, right: 4.0, bottom: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: () async {
                                controller.clearCache();
                                CookieManager().clearCookies();
                              },
                              backgroundColor: Colors.grey,
                              splashColor: Colors.red,
                              elevation: 0.0,
                              child: const Icon(
                                Icons.cookie,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: () async {
                                if (await controller.canGoBack()) {
                                  controller.goBack();
                                }
                              },
                              backgroundColor: Colors.grey,
                              splashColor: Colors.amber,
                              elevation: 0.0,
                              child: const Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: () async {
                                controller.reload();
                              },
                              backgroundColor: Colors.grey,
                              splashColor: Colors.green,
                              elevation: 0.0,
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: () async {
                                if (await controller.canGoForward()) {
                                  controller.goForward();
                                }
                              },
                              backgroundColor: Colors.grey,
                              splashColor: Colors.purple,
                              elevation: 0.0,
                              // child: const Icon(
                              //   Icons.arrow_forward_ios_outlined,
                              //   color: Colors.white,
                              // ),
                              // Zondicons.airplane
                              child: const Iconify(Zondicons.arrow_left)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
    // );
  }
}


// Future<bool>? _onBackPressed() {
//   return showDialog(
//     context: context,
//     builder: (context) => new AlertDialog(
//       title: Text('Are you sure?'),
//       content: Text('Do you want to exit an App'),
//       actions: <Widget>[
//          GestureDetector(
//           onTap: () => Navigator.of(context).pop(false),
//           child: const Text("NO"),
//         ),
//         const SizedBox(height: 16),
//          GestureDetector(
//           onTap: () => Navigator.of(context).pop(true),
//           child: const Text("YES"),
//         ),
//       ],
//     ),
//   ) ??
//       false;
// }
