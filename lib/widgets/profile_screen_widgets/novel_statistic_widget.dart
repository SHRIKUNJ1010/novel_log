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

  const NovelStatisticWidget({
    Key? key,
    required this.todayChapterReadCount,
    required this.totalStartedNovelCount,
    required this.totalChapterReadCount,
    required this.totalNovelReadCompleteWithNovelComplete,
    required this.totalNovelReadCompleteWithNovelHiatus,
    required this.dailyAverageChapterReadCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appThemeColor[300],
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          TextView(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            label: 'Today Chapter Read Count: $todayChapterReadCount',
            color: mWhite,
            fontSize: 22,
          ),
          TextView(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            label: 'Total Novel Count: $totalStartedNovelCount',
            color: mWhite,
            fontSize: 22,
          ),
          TextView(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            label: 'Total Chapter Read Count: $totalChapterReadCount',
            color: mWhite,
            fontSize: 22,
          ),
          TextView(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            label: 'Complete Novel Count: $totalNovelReadCompleteWithNovelComplete',
            color: mWhite,
            fontSize: 22,
          ),
          TextView(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            label: 'Hiatus Novel Count: $totalNovelReadCompleteWithNovelHiatus',
            color: mWhite,
            fontSize: 22,
          ),
          TextView(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            label: 'Daily Average Chapter Read Count: $dailyAverageChapterReadCount',
            color: mWhite,
            fontSize: 22,
          ),
        ],
      ),
    );
  }
}
