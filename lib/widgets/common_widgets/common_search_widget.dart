/*
* Created by Shrikunj Patel on 4/10/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/utility.dart';

class CommonSearchWidget extends StatefulWidget {
  final Stream<int> stream;
  final TextEditingController searchController;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String value) onSubmitted;
  final void Function(String value) onChanged;
  final TapRegionCallback? onTapOutside;
  final EdgeInsetsGeometry? padding;
  final Color hintColor;

  const CommonSearchWidget({
    Key? key,
    required this.stream,
    required this.searchController,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.padding,
    this.hintColor = Colors.grey,
    required this.onSubmitted,
    required this.onChanged,
    this.onTapOutside,
  }) : super(key: key);

  @override
  State<CommonSearchWidget> createState() => _CommonSearchWidgetState();
}

class _CommonSearchWidgetState extends State<CommonSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return TextField(
          controller: widget.searchController,
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          style: Utility.getRichTextStyle(fontSize: 18),
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            contentPadding: widget.padding,
            hintText: widget.hintText,
            hintStyle: Utility.getRichTextStyle(fontSize: 18, color: widget.hintColor),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
          ),
          onSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,
          onTapOutside: (down) {
            if (widget.onTapOutside != null) {
              widget.onTapOutside!.call(down);
            }
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
        );
      },
    );
  }
}
