/*
* Created by Shrikunj Patel on 1/30/2023.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/data_models/novel_description_model.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/firebase_services/database_services/novel_services.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class CreateNovelWishListItemScreen extends StatefulWidget {
  const CreateNovelWishListItemScreen({Key? key}) : super(key: key);

  @override
  State<CreateNovelWishListItemScreen> createState() => _CreateNovelWishListItemScreenState();
}

class _CreateNovelWishListItemScreenState extends State<CreateNovelWishListItemScreen> {
  TextEditingController novelNameController = TextEditingController();
  TextEditingController novelLinkUrlController = TextEditingController();
  TextEditingController authorNameController = TextEditingController();
  TextEditingController novelDescriptionController = TextEditingController();

  //List<String> novelGenres = ['Action', 'Adventure', 'Comedy', 'Classics', 'Mystery', 'Horror', 'SCi-Fi', 'Thriller', 'Romance', 'Magical Realism'];
  List<String> novelGenres = [];
  bool isNovel = true;
  NovelReadingStatus novelReadingStatus = NovelReadingStatus.reading;
  NovelStatus novelStatus = NovelStatus.production;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            pageStateProvider.pop();
          },
          child: const Icon(
            Icons.close,
            color: mWhite,
            size: 30,
          ),
        ),
        title: const TextView(
          label: 'Create Novel',
          fontSize: 26,
          color: mWhite,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                if (novelNameController.text.trim().isNotEmpty) {
                  NovelServices.createNovel(
                    NovelDescriptionModel(
                      userId: Preference.getUserId(),
                      novelName: novelNameController.text,
                      novelAuthorName: authorNameController.text,
                      novelGenre: novelGenres,
                      novelDescription: novelDescriptionController.text,
                      novelImageUrl: '',
                      isNovel: isNovel,
                      totalNovelChapterCount: 0,
                      readNovelChapterCount: 0,
                      novelLinkUrl: novelLinkUrlController.text,
                      novelStatus: Utility.novelStatusToString(novelStatus),
                      novelReadingStatus: Utility.novelReadingStatusToString(novelReadingStatus),
                      isHidden: false,
                      isInWishList: true,
                    ).toJson(),
                  );
                  pageStateProvider.pop();
                } else {
                  Utility.toastMessage(mFA5D5D, 'Invalid Field', 'Novel Name field can\'t be left empty');
                }
              },
              child: const Icon(
                Icons.check,
                color: mWhite,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width < 600 ? width : 600,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: novelNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Novel Name',
                          hintStyle: Utility.getRichTextStyle(
                            fontSize: 16,
                            color: mBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: novelLinkUrlController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Novel Link URL',
                          hintStyle: Utility.getRichTextStyle(
                            fontSize: 16,
                            color: mBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: authorNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Author Name',
                          hintStyle: Utility.getRichTextStyle(
                            fontSize: 16,
                            color: mBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: novelDescriptionController,
                        textInputAction: TextInputAction.next,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Novel Description',
                          hintStyle: Utility.getRichTextStyle(
                            fontSize: 16,
                            color: mBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Divider(),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          const TextView(
                            label: 'Manga',
                            color: mBlack,
                            fontSize: 18,
                          ),
                          const SizedBox(width: 5),
                          CupertinoSwitch(
                            value: isNovel,
                            onChanged: (value) => setState(() => isNovel = value),
                          ),
                          const SizedBox(width: 5),
                          const TextView(
                            label: 'Novel',
                            color: mBlack,
                            fontSize: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Divider(),
                      const SizedBox(height: 4),
                      const TextView(
                        label: 'Novel Status:',
                        color: mBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Radio(
                                  value: NovelStatus.production,
                                  groupValue: novelStatus,
                                  onChanged: (value) {
                                    setState(
                                      () => novelStatus = value ?? NovelStatus.production,
                                    );
                                  },
                                ),
                              ),
                              const TextView(
                                label: 'Production',
                                color: mBlack,
                                fontSize: 17,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Radio(
                                  value: NovelStatus.hiatus,
                                  groupValue: novelStatus,
                                  onChanged: (value) {
                                    setState(
                                      () => novelStatus = value ?? NovelStatus.hiatus,
                                    );
                                  },
                                ),
                              ),
                              const TextView(
                                label: 'Hiatus',
                                color: mBlack,
                                fontSize: 17,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Radio(
                                  value: NovelStatus.completed,
                                  groupValue: novelStatus,
                                  onChanged: (value) {
                                    setState(
                                      () => novelStatus = value ?? NovelStatus.completed,
                                    );
                                  },
                                ),
                              ),
                              const TextView(
                                label: 'Completed',
                                color: mBlack,
                                fontSize: 17,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Divider(),
                      const SizedBox(height: 4),
                      Wrap(
                        children: [
                          for (int i = 0; i < novelGenres.length; i++) ...[
                            Container(
                              decoration: BoxDecoration(
                                color: appPrimaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: TextView(
                                label: novelGenres[i],
                                color: mWhite,
                                fontSize: 16,
                              ),
                            ),
                          ],
                          InkWell(
                            onTap: () async {
                              String genre = await Utility.addGenreDialog(context);
                              if (genre != '') {
                                novelGenres.add(genre);
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: appPrimaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.add,
                                    color: mWhite,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  TextView(
                                    label: 'add genre',
                                    color: mWhite,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
