import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';


class PaperViewer extends StatefulWidget {
   const PaperViewer({Key? key}) : super(key: key);

   @override
  State<PaperViewer> createState() => _PaperViewerState();
}

class _PaperViewerState extends State<PaperViewer> {
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
      Factory(() => EagerGestureRecognizer())
    };
    final UniqueKey _key = UniqueKey();

    var loadingPercentage = 0;
    late Completer<WebViewController> controller;
    final Completer<WebViewController> _controller =
    Completer<WebViewController>();
    late Future<WebViewController> _webViewControllerFuture;
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
                    WebView(
                      key: _key,
                      initialUrl: 'https://www.google.com',
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureRecognizers: gestureRecognizers,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                      },
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
                    if(loadingPercentage < 100)
                      LinearProgressIndicator(
                        value: loadingPercentage / 100.0,
                      ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        color: Colors.black12,
                        child: FutureBuilder<WebViewController>(
                          future: _webViewControllerFuture,
                          builder:
                          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
                          final bool webViewReady =
                          snapshot.connectionState == ConnectionState.done;
                          final WebViewController? controller = snapshot.data;
                       return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                icon: const Icon(Icons.replay,
                                color: Colors.black,
                                ),
                                onPressed: (){
                                  print('replay');
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.black,
                                ),
                                onPressed: (){
                                  print('back pressed');
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios,
                                color: Colors.black,
                                ),
                                onPressed: ()async{
                                  await controller!.goBack();
                                  print('forward');
                                  return;
                                },
                              ),
                            ),
                          ],);},
                        ),
                      ),
                    ),
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

