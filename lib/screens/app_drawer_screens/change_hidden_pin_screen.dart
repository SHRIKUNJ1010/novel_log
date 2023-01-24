/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class ChangeHiddenPinScreen extends StatefulWidget {
  final bool showAppBar;
  final String userId;

  const ChangeHiddenPinScreen({
    Key? key,
    required this.userId,
    this.showAppBar = false,
  }) : super(key: key);

  @override
  State<ChangeHiddenPinScreen> createState() => _ChangeHiddenPinScreenState();
}

class _ChangeHiddenPinScreenState extends State<ChangeHiddenPinScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextView(label: 'Change Pin'),
        ),
        body: Container(
          color: Colors.blueGrey,
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: Colors.blueGrey,
        ),
      );
    }
  }
}
