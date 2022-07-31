// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';

// class WebVi extends StatefulWidget {
//   const WebVi({Key? key}) : super(key: key);

//   @override
//   State<WebVi> createState() => _WebViState();
// }

// class _WebViState extends State<WebVi> {
//   final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
//     Factory(() => EagerGestureRecognizer())
//   };
//   final UniqueKey _key = UniqueKey();

//   var loadingPercentage = 0;

//   late Completer<WebViewController> controller;

//   //TODO: FIX THIS CONTROLLER

//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: const Text('pdf'),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: Text(
//               'Quick Search',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           FloatingActionButton(
//             onPressed: () => showModalBottomSheet(
//               context: context,
//               builder: (context) => Stack(
//                 clipBehavior: Clip.antiAlias,
//                 children: [
//                   const WebviewScaffold(
//                     url: 'https://www.google.com',
//                     mediaPlaybackRequiresUserGesture: false,
//                     // withA?Zoom: true,
//                     withLocalStorage: true,
//                     // hidden: true,
//                   ),
//                   // Positioned(
//                   //   bottom: -20,
//                   //   child: Row(
//                   //     mainAxisAlignment: MainAxisAlignment.center,
//                   //     children: [
//                   //       Padding(
//                   //         padding: const EdgeInsets.all(8.0),
//                   //         child: IconButton(
//                   //           icon: const Icon(
//                   //             Icons.replay,
//                   //             color: Colors.black,
//                   //           ),
//                   //           onPressed: () {
//                   //             print('refresh');
//                   //           },
//                   //         ),
//                   //       ),
//                   //       Padding(
//                   //         padding: const EdgeInsets.all(8.0),
//                   //         child: IconButton(
//                   //           color: Colors.pink,
//                   //           icon: const Icon(
//                   //             Icons.arrow_back_ios,
//                   //             color: Colors.black,
//                   //           ),
//                   //           onPressed: () {
//                   //             print('back pressed');
//                   //           },
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   if (loadingPercentage < 100)
//                     LinearProgressIndicator(
//                       value: loadingPercentage / 100.0,
//                     ),
//                 ],
//               ),
//             ),
//             child: const Icon(Icons.search),
//           ),
//         ],
//       ),
//     );
//   }
// }
// //TODO: Advert Placement
