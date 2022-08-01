import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Tired extends StatefulWidget {
  const Tired({Key? key}) : super(key: key);

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
                      Text('This is a demo alert dialog.'),
                      Text('Would you like to approve of this message?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
         bool? result= await _showMyDialog();
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
                builder: (context) => WebView(
                  initialUrl: 'https://www.google.com',
                  javascriptMode: JavascriptMode.unrestricted,
                  gestureRecognizers: gestureRecognizers,
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
