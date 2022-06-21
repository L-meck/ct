import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaperViewer extends StatelessWidget {
  const PaperViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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