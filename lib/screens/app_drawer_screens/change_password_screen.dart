/*
* Created by Shrikunj Patel on 1/23/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool showAppBar;

  const ChangePasswordScreen({
    Key? key,
    this.showAppBar = false,
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextView(label: 'Change Password'),
        ),
        body: Container(
          color: Colors.cyanAccent,
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: Colors.cyanAccent,
        ),
      );
    }
  }
}
