/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/models/data_models/novel_list_item_model.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class YourNovelListScreen extends StatefulWidget {
  final bool showAppBar;
  final String userId;

  const YourNovelListScreen({
    Key? key,
    required this.userId,
    this.showAppBar = false,
  }) : super(key: key);

  @override
  State<YourNovelListScreen> createState() => _YourNovelListScreenState();
}

class _YourNovelListScreenState extends State<YourNovelListScreen> {
  List<NovelListItemModel> novelList = [];
  QueryDocumentSnapshot<Map<String, dynamic>>? lastData;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.showAppBar){
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextView(label: 'Your Novels'),
        ),
        body: Container(
          color: Colors.green,
        ),
      );
    }else{
      return Scaffold(
        body: Container(
          color: Colors.green,
        ),
      );
    }

  }
}
