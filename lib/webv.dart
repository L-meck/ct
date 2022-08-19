import 'dart:io';
import 'package:collegetemplate/test_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_outline.dart';
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

  late WebViewController controller;

  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    _createInterstitialAd();
    _showInterstitialAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialTest,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      //TODO: REMOVE THIS print statements after refactoring
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose(); //TODO: REMOVE
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint(
            '$ad onAdFailedToShowFullScreenContent: $error'); //TODO: REMOVE
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = (null) as InterstitialAd;
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
                      initialUrl: 'https://www.google.com', //TODO: REMOVE
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
                                splashColor: Colors.transparent,
                                elevation: 0.0,
                                // child: const Icon(
                                //   Icons.arrow_back_ios_outlined,
                                //   color: Colors.white,
                                // ),
                                child:
                                    const Iconify(IconParkOutline.arrow_left)),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: () async {
                                controller.reload();
                              },
                              backgroundColor: Colors.grey,
                              splashColor: Colors.green,
                              elevation: 1.0,
                              // child: const Icon(
                              //   Icons.refresh,
                              //   color: Colors.white,
                              // ),
                              child: const Iconify(
                                  IconParkOutline.rotating_forward),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                                onPressed: () async {
                                  if (await controller.canGoForward()) {
                                    controller.goForward();
                                  }
                                  _showInterstitialAd(); //TODO: REMOVE
                                },
                                backgroundColor: Colors.grey,
                                splashColor: Colors.purple,
                                elevation: 0.0,
                                // child: const Icon(
                                //   Icons.arrow_forward_ios_outlined,
                                //   color: Colors.white,
                                // ),
                                // Zondicons.airplane
                                child:
                                    const Iconify(IconParkOutline.arrow_right)),
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

// showdialog 

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
