import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () async=> false, //disable back button
      onWillPop: () async {
        Future<dynamic> _showMyDialog() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('AlertDialog Title'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('Ad.'),
                      Text('Interstitial Ad'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }

        bool? result = await _showMyDialog();
        result ??= false;
        return result;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: const Text('pdf'),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                'Quick Search',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => Stack(
                  children: [
                    WebView(
                      initialUrl: 'https://www.google.com',
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureRecognizers: gestureRecognizers,
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
                              onPressed: () {
                                print('back');
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
                              onPressed: () {
                                print('refresh');
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
                              onPressed: () {
                                print('forward');
                              },
                              backgroundColor: Colors.grey,
                              splashColor: Colors.purple,
                              elevation: 0.0,
                              child: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              child: const Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
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
