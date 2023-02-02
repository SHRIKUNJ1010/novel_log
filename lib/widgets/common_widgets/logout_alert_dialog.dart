/*
* Created by Shrikunj Patel on 2/2/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class LogoutAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function? onPositivePressed;
  final Function? onNegativePressed;
  final double circularBorderRadius;

  const LogoutAlertDialog({
    super.key,
    this.title = '',
    this.message = '',
    this.circularBorderRadius = 10,
    this.bgColor = Colors.white,
    this.positiveBtnText = 'Yes',
    this.negativeBtnText = 'No',
    this.onPositivePressed,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextView(label: title, fontWeight: FontWeight.w600, fontSize: 16),
      content: TextView(label: message),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onNegativePressed != null) {
              onNegativePressed!();
            }
          },
          child: TextView(label: negativeBtnText, color: appPrimaryColor),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onPositivePressed != null) {
              onPositivePressed!();
            }
          },
          child: TextView(label: positiveBtnText, color: appPrimaryColor),
        ),
      ],
    );
  }
}
