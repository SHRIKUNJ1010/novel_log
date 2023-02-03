/*
* Created by Shrikunj Patel on 2/2/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class YourNovelListCard extends StatelessWidget {
  final String novelName;
  final String novelImageUrl;
  final int totalNovelChapterCount;
  final int readNovelChapterCount;
  final String novelLinkUrl;
  final bool isNovel;
  final NovelReadingStatus novelReadingStatus;

  const YourNovelListCard({
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
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Stack(
        children: [
          Container(
            width: 300,
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appThemeColor[50]!, appThemeColor[100]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Stack(
                        children: [
                          Image.asset(
                            bookImagePlaceholder,
                            width: 270,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 7,
                            right: 7,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Utility.novelReadingStatusColor(novelReadingStatus),
                              ),
                              padding: const EdgeInsets.all(7),
                              child: TextView(
                                label: Utility.novelReadingStatusLabel(novelReadingStatus),
                                fontSize: 10,
                                color: mWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextView(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  label: Utility.getFirstLetterCapital(novelName),
                  fontSize: 20,
                  color: appPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                TextView(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  label: 'Chapter $readNovelChapterCount/$totalNovelChapterCount',
                  fontSize: 17,
                  color: mBlack,
                ),
                InkWell(
                  onTap: () {
                    //TODO: launch novel link url
                  },
                  child: TextView(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    label: novelLinkUrl,
                    fontSize: 18,
                    color: m0A77E8,
                    textDecoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: mBlack,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: const TextView(
                label: 'N',
                fontSize: 10,
                color: mBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}