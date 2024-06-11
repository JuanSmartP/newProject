



import 'package:flutter/material.dart';




class CustomDialogAlert extends StatelessWidget {
  final String message;
  const CustomDialogAlert({
    super.key, required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text(message),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            )
          ],
        ));
  }
}