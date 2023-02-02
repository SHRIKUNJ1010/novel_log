/*
* Created by Shrikunj Patel on 1/24/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

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
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appThemeColor[50]!, appThemeColor[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      bookImagePlaceholder,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: mBlack,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      child: const TextView(
                        label: 'N',
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: mBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      TextView(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                        label: Utility.getFirstLetterCapital(novelName),
                        fontSize: 20,
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const Expanded(child: SizedBox()),
                      CircleAvatar(
                        radius: 8.5,
                        backgroundColor: Utility.novelReadingStatusColor(novelReadingStatus),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  TextView(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    label: 'Chapter $readNovelChapterCount/$totalNovelChapterCount',
                    fontSize: 17,
                    color: mBlack,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO: launch novel link url
                    },
                    child: TextView(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
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
          ],
        ),
      ),
    );
  }
}
