import 'package:flutter/material.dart';

void congratsShowDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Congratulations! 🥳'),
        content: const Text('You have completed your task!'),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 241, 234, 181)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}