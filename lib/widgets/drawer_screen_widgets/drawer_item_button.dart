/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class DrawerItemButton extends StatelessWidget {
  final Widget icon;
  final GestureTapCallback onTap;
  final String title;

  const DrawerItemButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: appThemeColor[200]!,
              width: 2,
            ),
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 35, width: 35, child: icon),
            TextView(
              label: title,
              fontSize: 18,
              color: mWhite,
              padding: const EdgeInsets.only(left: 12),
            ),
          ],
        ),
      ),
    );
  }
}
