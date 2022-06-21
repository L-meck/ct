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
    final PanelController _pc = PanelController();
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
      Factory(() => EagerGestureRecognizer())
    };
    final UniqueKey _key = UniqueKey();


  //   @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SlidingUpPanel(
  //       controller: _pc,
  //       backdropEnabled: true,
  //       parallaxEnabled: true,
  //       panel: const WebView(
  //         initialUrl: 'https://www.google.com',
  //       ),
  //       body: const Center(
  //         child: Text("Pdf Display"),
  //       ),
  //     ),
  //   );
  // }
@override
  Widget build(BuildContext context){
  return Scaffold(
    resizeToAvoidBottomInset: true,
  body: Text('pdf'),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        showModalBottomSheet(
            context: context,
            builder: (context) => WebView(
              key: _key,
              initialUrl: 'https://www.google.com',
              javascriptMode: JavascriptMode.unrestricted,
              gestureRecognizers: gestureRecognizers,
            ),
        );
      },
      child: Icon(Icons.search),
    ),
  );
}
}
//TODO: Advert Placement
void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          // color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.75,
            builder: (_, controller) {
              // return Container(
              //   decoration: const BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.only(
              //       topLeft: const Radius.circular(25.0),
              //       topRight: const Radius.circular(25.0),
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       Icon(
              //         Icons.remove,
              //         color: Colors.grey[600],
              //       ),
              //       Expanded(
              //         child: ListView.builder(
              //           controller: controller,
              //           itemCount: 100,
              //           itemBuilder: (_, index) {
              //             return Card(
              //               child: Padding(
              //                 padding: EdgeInsets.all(8),
              //                 child: Text("Element at index($index)"),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // );
              return const WebView(
                gestureNavigationEnabled: true,
                initialUrl: 'https://www.google.com',
              );
            },
          ),
        ),
      );
    },
  );
}