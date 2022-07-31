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
    return Scaffold(
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
    );
  }
}
