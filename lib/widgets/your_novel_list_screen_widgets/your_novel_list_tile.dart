/*
* Created by Shrikunj Patel on 1/24/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/utility/enum_variable_types.dart';

class YourNovelListTile extends StatelessWidget {
  final String novelName;
  final String novelImageUrl;
  final int totalNovelChapterCount;
  final int readNovelChapterCount;
  final String novelLinkUrl;
  final bool isNovel;
  final NovelReadingStatus novelReadingStatus;

  const YourNovelListTile({
    Key? key,
    required this.novelName,
    required this.novelLinkUrl,
    this.novelImageUrl = '',
    this.totalNovelChapterCount = 0,
    this.readNovelChapterCount = 0,
    this.isNovel = true,
    this.novelReadingStatus = NovelReadingStatus.reading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.red,
    );
  }
}
