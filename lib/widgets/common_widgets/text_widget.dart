/*
* Created by Shrikunj Patel on 1/6/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/utility.dart';

class TextView extends StatelessWidget {
  final String label;
  final Color color;
  final double fontSize;
  final double letterSpacing;
  final bool softWrap;
  final bool isEllipsis;
  final int maxLines;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;
  final TextDecoration textDecoration;
  final Color decorationColor;
  final double decorationThickness;

  const TextView({
    super.key,
    required this.label,
    this.color = mWhite,
    this.fontSize = 16,
    this.letterSpacing = 0,
    this.maxLines = 1,
    this.isEllipsis = false,
    this.softWrap = false,
    this.fontWeight = FontWeight.w400,
    this.fontFamily = fontProxima,
    this.textAlign = TextAlign.start,
    this.padding = EdgeInsets.zero,
    this.textDecoration = TextDecoration.none,
    this.decorationColor = Colors.transparent,
    this.decorationThickness = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        label,
        softWrap: softWrap,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: isEllipsis ? TextOverflow.ellipsis : TextOverflow.fade,
        style: Utility.getRichTextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          fontFamily: fontFamily,
          textDecoration: textDecoration,
          decorationColor: decorationColor,
          decorationThickness: decorationThickness,
        ),
      ),
    );
  }
}
