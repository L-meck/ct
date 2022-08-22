import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'pdf_list.dart';

// class PaperViewer extends StatefulWidget {
//   const PaperViewer({Key? key}) : super(key: key);

//   @override
//   State<PaperViewer> createState() => _PaperViewerState();
// }

// class _PaperViewerState extends State<PaperViewer> {
//   final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
//     Factory(() => EagerGestureRecognizer())
//   };


class PaperViewer extends StatefulWidget {

    final pdf;
    final paperName;

  PaperViewer({Key? key, this.pdf, this.paperName}) : super(key: key);

  @override
  State<PaperViewer> createState() => _PaperViewerState();
}

class _PaperViewerState extends State<PaperViewer> {
  //  PaperViewer(this._webViewControllerFuture, {Key? key}) : super(key: key);
 final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final UniqueKey _key = UniqueKey();

  var loadingPercentage = 0;

  late Completer<WebViewController> controller;

  late final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,
      // extendBodyBehindAppBar: true,
      
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kuku,
        ),
        title: Text(
          widget.paperName,
          style: TextStyle(color: kuku, ),//fontFamily: 'Francois One'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: SfPdfViewer.asset(
        widget.pdf
      // body: PdfView(
      //   pdf,
      // width: double.infinity,
      // height: MediaQuery.of(context).size.height,
      ),

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
              builder: (context) => FutureBuilder<WebViewController>(
                future: _webViewControllerFuture,
                builder: (BuildContext context,
                    AsyncSnapshot<WebViewController> snapshot) {
                  final WebViewController? controller = snapshot.data;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      WebView(
                        key: _key,
                        initialUrl: 'https://www.google.com',
                        javascriptMode: JavascriptMode.unrestricted,
                        gestureRecognizers: gestureRecognizers,
                        // onWebViewCreated:
                        //     (WebViewController webViewController) {
                        //   _controller.complete(webViewController);
                        // },
                        // onPageStarted: (url) {
                        //   setState(() {
                        //     loadingPercentage = 0;
                        //   });
                        // },
                        // onProgress: (progress) {
                        //   setState(
                        //     () {
                        //       loadingPercentage = progress;
                        //     },
                        //   );
                        // },
                        // onPageFinished: (url) {
                        //   setState(() {
                        //     loadingPercentage = 100;
                        //   });
                        // },
                      ),
                      if (loadingPercentage < 100)
                        LinearProgressIndicator(
                          value: loadingPercentage / 100.0,
                        ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                focusColor: Colors.red,
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.yellow,
                                ),
                                onPressed: () {
                                  print('forward');//todo: remove after full debugging
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                focusColor: Colors.red,
                                icon: const Icon(
                                  Icons.replay,
                                  color: Colors.yellow,
                                ),
                                onPressed: () {
                                  print('reload');//todo: remove after full debugging
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                focusColor: Colors.red,
                                color: Colors.pink,
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.yellow,
                                ),
                                onPressed: () {
                                  print('backward');//todo: remove after full debugging
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
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

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture, {Key? key})
      : super(key: key);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoBack()) {
                        await controller.goBack();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No back history item')),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoForward()) {
                        await controller.goForward();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('No forward history item')),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller!.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
