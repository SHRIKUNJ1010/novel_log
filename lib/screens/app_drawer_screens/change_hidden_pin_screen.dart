/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class ChangeHiddenPinScreen extends StatefulWidget {
  final String userId;

  const ChangeHiddenPinScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ChangeHiddenPinScreen> createState() => _ChangeHiddenPinScreenState();
}

class _ChangeHiddenPinScreenState extends State<ChangeHiddenPinScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width > 600) {
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
