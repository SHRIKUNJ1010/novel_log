/*
* Created by Shrikunj Patel on 2/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class NovelWishListTile extends StatelessWidget {
  final String novelName;
  final String novelImageUrl;
  final List<String> novelGenre;
  final String novelAuthorName;
  final int totalNovelChapterCount;
  final int readNovelChapterCount;
  final String novelLinkUrl;
  final bool isNovel;
  final NovelStatus novelStatus;

  const NovelWishListTile({
    Key? key,
    required this.novelName,
    required this.novelLinkUrl,
    this.novelImageUrl = '',
    this.novelAuthorName = '',
    this.totalNovelChapterCount = 0,
    this.readNovelChapterCount = 0,
    this.novelGenre = const [],
    this.isNovel = true,
    this.novelStatus = NovelStatus.production,
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
                  isNovel
                      ? Positioned(
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
                        )
                      : const SizedBox(),
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
                      Expanded(
                        child: TextView(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                          label: Utility.getFirstLetterCapital(novelName),
                          fontSize: 20,
                          maxLines: 2,
                          softWrap: true,
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        radius: 8.5,
                        backgroundColor: Utility.novelStatusColor(novelStatus),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      novelLinkUrl != '' ? Utility.launchInBrowser(novelLinkUrl) : null;
                    },
                    child: TextView(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      label: novelLinkUrl,
                      fontSize: 18,
                      color: m0A77E8,
                      decorationColor: m0A77E8,
                      decorationThickness: 2,
                      maxLines: 3,
                      softWrap: true,
                      textDecoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  novelAuthorName != ''
                      ? TextView(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 10),
                          label: Utility.getFirstLetterCapital(novelAuthorName),
                          fontSize: 17,
                          color: mBlack,
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      children: [
                        for (int index = 0; index < novelGenre.length; index++) ...[
                          Container(
                            decoration: BoxDecoration(
                              color: appPrimaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: TextView(
                              label: novelGenre[index],
                              color: mWhite,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
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
