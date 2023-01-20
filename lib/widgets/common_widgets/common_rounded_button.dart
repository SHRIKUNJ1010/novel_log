import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class CommonRoundedButton extends StatelessWidget {
  final double height;
  final Color buttonColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final double letterSpacing;
  final GestureTapCallback onTap;

  const CommonRoundedButton({
    Key? key,
    required this.height,
    this.buttonColor = appPrimaryColor,
    required this.text,
    this.textColor = mWhite,
    this.fontSize = 20,
    this.fontFamily = fontProxima,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height/2),
          color: buttonColor,
        ),
        child: TextView(
          label: text,
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
