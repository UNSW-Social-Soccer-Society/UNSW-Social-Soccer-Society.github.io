import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  final String title;
  final String desc;

  const Popup({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title,
          style: const TextStyle(
              color: Color.fromARGB(255, 48, 51, 58),
              fontWeight: FontWeight.bold)),
      content: Text(desc),
      actions: <Widget>[
        TextButton(
            onPressed: () => {Navigator.pop(context)},
            child: const Text('Dismiss',
                style: TextStyle(
                  color: Color.fromARGB(255, 50, 50, 50),
                ))),
      ],
    );
  }
}
