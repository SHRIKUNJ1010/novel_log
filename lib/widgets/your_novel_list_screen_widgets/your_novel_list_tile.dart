/*
* Created by Shrikunj Patel on 1/24/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class YourNovelListTile extends StatefulWidget {
  final String novelName;
  final String novelImageUrl;
  final List<String> novelGenre;
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
    this.novelGenre = const [],
    this.isNovel = true,
    this.novelReadingStatus = NovelReadingStatus.reading,
  }) : super(key: key);

  @override
  State<YourNovelListTile> createState() => _YourNovelListTileState();
}

class _YourNovelListTileState extends State<YourNovelListTile> {
  final columnKey = GlobalKey();
  double? height;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        height = columnKey.currentContext!.size!.height;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
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
                  Image.asset(
                    bookImagePlaceholder,
                    fit: BoxFit.cover,
                    height: ((height ?? 0) < 100) ? null : height,
                  ),
                  widget.isNovel
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
                key: columnKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextView(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                          label: Utility.getFirstLetterCapital(widget.novelName),
                          fontSize: 20,
                          maxLines: 6,
                          softWrap: true,
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CircleAvatar(
                          radius: 8.5,
                          backgroundColor: Utility.novelReadingStatusColor(widget.novelReadingStatus),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  TextView(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    label:
                        'Chapter ${widget.readNovelChapterCount}/${widget.totalNovelChapterCount == 0 ? "${widget.readNovelChapterCount}+" : "${widget.totalNovelChapterCount}"}',
                    fontSize: 17,
                    color: mBlack,
                  ),
                  InkWell(
                    onTap: () {
                      widget.novelLinkUrl != '' ? Utility.launchInBrowser(widget.novelLinkUrl) : null;
                    },
                    child: TextView(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      label: widget.novelLinkUrl,
                      fontSize: 18,
                      color: m0A77E8,
                      decorationColor: m0A77E8,
                      decorationThickness: 2,
                      maxLines: 10,
                      softWrap: true,
                      textDecoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      children: [
                        for (int index = 0; index < widget.novelGenre.length; index++) ...[
                          Container(
                            decoration: BoxDecoration(
                              color: appPrimaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: TextView(
                              label: widget.novelGenre[index],
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
