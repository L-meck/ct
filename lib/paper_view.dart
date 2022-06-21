import 'dart:async';

import 'package:collegetemplate/web_ctrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';


class PaperViewer extends StatefulWidget {
   const PaperViewer({Key? key}) : super(key: key);

   @override
  State<PaperViewer> createState() => _PaperViewerState();
}

class _PaperViewerState extends State<PaperViewer> {
    // final PanelController _pc = PanelController();
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
      Factory(() => EagerGestureRecognizer())
    };
    final UniqueKey _key = UniqueKey();

    var loadingPercentage = 0;
    // late Completer<WebViewController> controller;
    final Completer<WebViewController> _controller =
    Completer<WebViewController>();

@override
  Widget build(BuildContext context){
  return Scaffold(
    resizeToAvoidBottomInset: true,
  body: const Text('pdf'),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Text('Quick Search',
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        FloatingActionButton(
          onPressed: () => showModalBottomSheet(
                context: context,
                // isScrollControlled: true,
                builder: (context) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        child: NavigationControls(controller: _controller),
                    ),
                    Positioned(
                      child: WebView(
                        key: _key,
                        initialUrl: 'https://www.google.com',
                        javascriptMode: JavascriptMode.unrestricted,
                        gestureRecognizers: gestureRecognizers,
                        onPageStarted: (url){
                          setState(() {
                            loadingPercentage = 0;
                          });
                        },
                        onProgress: (progress){
                          setState(() {
                            loadingPercentage = progress;
                            },
                          );
                        },
                        onPageFinished: (url){
                          setState(() {
                            loadingPercentage = 100;
                          });
                        },
                      ),
                    ),
                    if(loadingPercentage < 100)
                      LinearProgressIndicator(
                        value: loadingPercentage / 100.0,
                      ),
                    // NavigationControls(controller: controller),
                  ],
                ),
            ),
          child: const Icon(Icons.search),
        ),
      ],
    ),
  );
}
}
//TODO: Advert Placement

