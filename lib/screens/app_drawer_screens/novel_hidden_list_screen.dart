/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class NovelHiddenListScreen extends StatefulWidget {
  final String userId;

  const NovelHiddenListScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<NovelHiddenListScreen> createState() => _NovelHiddenListScreenState();
}

class _NovelHiddenListScreenState extends State<NovelHiddenListScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: width > 600
          ? AppBar(
              centerTitle: true,
              title: const TextView(label: 'Hidden List'),
            )
          : null,
      floatingActionButton: InkWell(
        onTap: () {
          pageStateProvider.push(PageConfigList.getCreateNovelHiddenListItemScreen(widget.userId), TransitionType.slideDownTransition);
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(color: appPrimaryColor, borderRadius: BorderRadius.circular(27.5)),
          child: const Icon(color: mWhite, size: 30, Icons.add),
        ),
      ),
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}
