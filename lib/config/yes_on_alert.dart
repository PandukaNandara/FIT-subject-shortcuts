

import 'package:flutter/material.dart';

class YesNoAlert extends StatelessWidget {
  final String title;
  final String message;

  final VoidCallback? noOnPressed;
  final VoidCallback yesOnPressed;
  final String noButtonText;
  final String yesButtonText;

  const YesNoAlert({
    Key? key,
    this.noOnPressed,
    this.noButtonText = 'NO',
    this.yesButtonText = 'YES',
    required this.title,
    required this.message,
    required this.yesOnPressed,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            // NO button
            onPressed: noOnPressed ?? ()=> Navigator.pop(context, false),
            child: Text(
              noButtonText,
            ),
          ),
          TextButton(
            // YES button
            onPressed: yesOnPressed,
            child: Text(
              yesButtonText,
            ),
          ),
        ],
      ),
    );
  }
}
