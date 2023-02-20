/*
* Created by Shrikunj Patel on 2/15/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class NovelStatisticWidget extends StatelessWidget {
  final int todayChapterReadCount;
  final int totalStartedNovelCount;
  final int totalChapterReadCount;
  final int totalNovelReadCompleteWithNovelComplete;
  final int totalNovelReadCompleteWithNovelHiatus;
  final double dailyAverageChapterReadCount;
  final double fontSize;

  const NovelStatisticWidget({
    Key? key,
    required this.todayChapterReadCount,
    required this.totalStartedNovelCount,
    required this.totalChapterReadCount,
    required this.totalNovelReadCompleteWithNovelComplete,
    required this.totalNovelReadCompleteWithNovelHiatus,
    required this.dailyAverageChapterReadCount,
    this.fontSize = 22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appThemeColor[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: 'Total Chapter Read Count: ',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: 'Total Novel Count: ',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: 'Complete Novel Count: ',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: 'Hiatus Novel Count: ',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: 'Today Chapter Read Count: ',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: 'Daily Average Chapter Read Count: ',
                color: mWhite,
                fontSize: fontSize,
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: '$totalChapterReadCount',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: '$totalStartedNovelCount',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: '$totalNovelReadCompleteWithNovelComplete',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: '$totalNovelReadCompleteWithNovelHiatus',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: '$todayChapterReadCount',
                color: mWhite,
                fontSize: fontSize,
              ),
              TextView(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                label: '$dailyAverageChapterReadCount',
                color: mWhite,
                fontSize: fontSize,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
