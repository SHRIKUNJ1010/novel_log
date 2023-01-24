/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class NovelHiddenListScreen extends StatefulWidget {
  final bool showAppBar;
  final String userId;

  const NovelHiddenListScreen({
    Key? key,
    required this.userId,
    this.showAppBar = false,
  }) : super(key: key);

  @override
  State<NovelHiddenListScreen> createState() => _NovelHiddenListScreenState();
}

class _NovelHiddenListScreenState extends State<NovelHiddenListScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextView(label: 'Hidden List'),
        ),
        body: Container(
          color: Colors.yellow,
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: Colors.yellow,
        ),
      );
    }
  }
}
