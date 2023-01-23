/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class DrawerSelectedItemButton extends StatelessWidget {
  final Widget icon;
  final GestureTapCallback onTap;
  final String title;

  const DrawerSelectedItemButton({
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
          color: appThemeColor[200]!,
          border: Border.all(
            color: appThemeColor[200]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 35, width: 35, child: icon),
            TextView(
              label: title,
              fontSize: 18,
              color: mBlack,
              padding: const EdgeInsets.only(left: 12),
            ),
          ],
        ),
      ),
    );
  }
}
