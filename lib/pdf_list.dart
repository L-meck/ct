import 'package:flutter/material.dart';

final kuku = Color(0xFF6049D3);

List<String> pdfs = [
  'assets/ELECTRICAL MEASUREMENTS.pdf',
  'assets/ELECTRICAL MEASUREMENTS.pdf',
  'assets/ELECTRICAL MEASUREMENTS.pdf',
  'assets/ELECTRICAL MEASUREMENTS.pdf',
];

// 1. fine
// 2. banana
// 3. foot
// 4. stay
// 5. crunch
// 6. inspire
// 7. tray
// 8. glad
// 9. casino
// 10. recipe
// 11. coconut
// 12. unfair



class PdfsButton extends StatelessWidget {
  
  final String paper;

  const PdfsButton({Key? key, required this.paper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const kuku = Color(0xFF6049D3);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListTile(
          leading: const Icon(
            Icons.library_books,
            color: Colors.black,
          ),
          title: Text(
            paper,
            style: const TextStyle(
              color: kuku,
              fontFamily: 'Francois One',
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}