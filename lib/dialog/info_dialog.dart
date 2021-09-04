import 'package:fit_shortcuts/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyTextStyle = Theme.of(context).textTheme.bodyText1!;
    return AlertDialog(
      title: Text("About this site"),
      actionsPadding: kDefaultPadding,
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              style: bodyTextStyle,
              text:
                  'This site is made possible by Flutter. If you want to contribute to this project, fork ',
            ),
            TextSpan(
              style: bodyTextStyle.copyWith(
                color: Colors.blue,
              ),
              text: 'this ',
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final url =
                      'https://github.com/PandukaNandara/FIT-subject-shortcuts';
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                },
            ),
            TextSpan(
              style: bodyTextStyle,
              text: 'Github repository and create a pull request with your changes.',
            ),
          ],
        ),
      ),
      // Wrap(
      //   children: [
      //     Text(
      //         'This site is possibly made with Flutter. If you want to contribute to this project create a fort on '),
      //     GestureDetector(
      //       child: Text(
      //         "this ",
      //         style: TextStyle(
      //           decoration: TextDecoration.underline,
      //           color: Colors.blue,
      //         ),
      //       ),
      //       onTap: () => launch(
      //           'https://github.com/PandukaNandara/FIT-subject-shortcuts'),
      //     ),
      //     Text('Github repository and make a pull request'),
      //   ],
      // ),

      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
