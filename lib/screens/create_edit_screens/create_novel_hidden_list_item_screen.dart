/*
* Created by Shrikunj Patel on 1/30/2023.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/data_models/novel_description_model.dart';
import 'package:novel_log/models/getx_controller_model/novel_hidden_list_controller.dart';
import 'package:novel_log/models/getx_controller_model/user_data_controller.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/firebase_services/database_services/novel_services.dart';
import 'package:novel_log/utility/firebase_services/database_services/user_services.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class CreateNovelHiddenListItemScreen extends StatefulWidget {
  final String? novelId;
  final String? userId;

  const CreateNovelHiddenListItemScreen({
    Key? key,
    this.novelId,
    this.userId,
  }) : super(key: key);

  @override
  State<CreateNovelHiddenListItemScreen> createState() => _CreateNovelHiddenListItemScreenState();
}

class _CreateNovelHiddenListItemScreenState extends State<CreateNovelHiddenListItemScreen> {
  TextEditingController novelNameController = TextEditingController();
  TextEditingController readChapterController = TextEditingController();
  TextEditingController totalChapterController = TextEditingController();
  TextEditingController novelLinkUrlController = TextEditingController();
  TextEditingController authorNameController = TextEditingController();
  TextEditingController novelDescriptionController = TextEditingController();
  TextEditingController indexingGroupNameController = TextEditingController();

  //List<String> novelGenres = ['Action', 'Adventure', 'Comedy', 'Classics', 'Mystery', 'Horror', 'SCi-Fi', 'Thriller', 'Romance', 'Magical Realism'];
  List<String> novelGenres = [];
  bool isNovel = true;
  NovelReadingStatus novelReadingStatus = NovelReadingStatus.reading;
  NovelStatus novelStatus = NovelStatus.production;

  NovelDescriptionModel? oldNovelData;

  @override
  void initState() {
    if (widget.novelId != null) {
      initData();
    }
    super.initState();
  }

  initData() async {
    oldNovelData = await NovelServices.getNovelData(widget.novelId!);
    novelNameController.text = oldNovelData!.novelName ?? '';
    readChapterController.text = oldNovelData!.readNovelChapterCount.toString();
    totalChapterController.text = oldNovelData!.totalNovelChapterCount.toString();
    novelLinkUrlController.text = oldNovelData!.novelLinkUrl ?? '';
    authorNameController.text = oldNovelData!.novelAuthorName ?? '';
    indexingGroupNameController.text = oldNovelData!.indexingGroupName ?? '';
    novelDescriptionController.text = oldNovelData!.novelDescription ?? '';
    isNovel = oldNovelData!.isNovel ?? true;
    novelGenres = oldNovelData!.novelGenre ?? [];
    novelReadingStatus = oldNovelData!.novelReadingStatus ?? NovelReadingStatus.reading;
    novelStatus = oldNovelData!.novelStatus ?? NovelStatus.production;
  }

  checkValidationAndCreateEditNovel() {
    if (novelNameController.text.trim().isNotEmpty) {
      if (widget.novelId != null) {
        NovelServices.editNovel(
          widget.novelId ?? '',
          NovelDescriptionModel(
            userId: widget.userId ?? Preference.getUserId(),
            novelName: novelNameController.text,
            novelAuthorName: authorNameController.text,
            novelGenre: novelGenres,
            novelDescription: novelDescriptionController.text,
            novelImageUrl: '',
            indexingGroupName: indexingGroupNameController.text,
            isNovel: isNovel,
            totalNovelChapterCount: int.parse(totalChapterController.text),
            readNovelChapterCount: int.parse(readChapterController.text),
            novelLinkUrl: novelLinkUrlController.text,
            novelStatus: Utility.novelStatusToString(novelStatus),
            novelReadingStatus: Utility.novelReadingStatusToString(novelReadingStatus),
            isHidden: true,
            isInWishList: false,
          ).toJson(),
        );
        if (oldNovelData!.novelReadingStatus != novelReadingStatus) {
          final tempUserController = Get.put(UserDataController());
          switch (oldNovelData!.novelReadingStatus) {
            case NovelReadingStatus.notStarted:
              //do nothing
              break;
            case NovelReadingStatus.reading:
              //do nothing
              break;
            case NovelReadingStatus.hiatusCompleted:
              UserServices.changeHiatusNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! - 1,
              );
              break;
            case NovelReadingStatus.completed:
              UserServices.changeCompleteNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelComplete! - 1,
              );
              break;
            default:
              break;
          }
          switch (novelReadingStatus) {
            case NovelReadingStatus.notStarted:
              //do nothing
              break;
            case NovelReadingStatus.reading:
              //do nothing
              break;
            case NovelReadingStatus.hiatusCompleted:
              UserServices.changeHiatusNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! + 1,
              );
              break;
            case NovelReadingStatus.completed:
              UserServices.changeCompleteNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelComplete! + 1,
              );
              break;
            default:
              break;
          }
        }
        if (oldNovelData!.readNovelChapterCount != int.parse(readChapterController.text)) {
          final tempUserController = Get.put(UserDataController());
          UserServices.changeTotalChapterReadCountOfUser(
            widget.userId ?? Preference.getUserId(),
            tempUserController.userData.totalChapterReadCount! + (int.parse(readChapterController.text) - oldNovelData!.readNovelChapterCount!),
          );
        }
      } else {
        final tempUserController = Get.put(UserDataController());
        NovelServices.createNovel(
          NovelDescriptionModel(
            userId: widget.userId ?? Preference.getUserId(),
            novelName: novelNameController.text,
            novelAuthorName: authorNameController.text,
            novelGenre: novelGenres,
            novelDescription: novelDescriptionController.text,
            novelImageUrl: '',
            indexingGroupName: indexingGroupNameController.text,
            isNovel: isNovel,
            totalNovelChapterCount: totalChapterController.text.isEmpty ? 0 : int.parse(totalChapterController.text),
            readNovelChapterCount: readChapterController.text.isEmpty ? 0 : int.parse(readChapterController.text),
            novelLinkUrl: novelLinkUrlController.text,
            novelStatus: Utility.novelStatusToString(novelStatus),
            novelReadingStatus: Utility.novelReadingStatusToString(novelReadingStatus),
            isHidden: true,
            isInWishList: false,
          ).toJson(),
        );
        switch (novelReadingStatus) {
          case NovelReadingStatus.notStarted:
          case NovelReadingStatus.reading:
            UserServices.changeTotalNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalStartedNovelCount! + 1,
            );
            break;
          case NovelReadingStatus.hiatusCompleted:
            UserServices.changeTotalNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalStartedNovelCount! + 1,
            );
            UserServices.changeHiatusNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! + 1,
            );
            break;
          case NovelReadingStatus.completed:
            UserServices.changeTotalNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalStartedNovelCount! + 1,
            );
            UserServices.changeCompleteNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalNovelReadCompleteWithNovelComplete! + 1,
            );
            break;
          default:
            break;
        }
        UserServices.changeTotalChapterReadCountOfUser(
          widget.userId ?? Preference.getUserId(),
          tempUserController.userData.totalChapterReadCount! + (readChapterController.text.isEmpty ? 0 : int.parse(readChapterController.text)),
        );
      }
      final tempUserController = Get.put(UserDataController());
      final tempNovelHiddenListController = Get.put(NovelHiddenListController());
      tempUserController.getUserData(widget.userId ?? Preference.getUserId());
      tempNovelHiddenListController.refreshList(widget.userId ?? Preference.getUserId());
      if (kIsWeb) {
        pageStateProvider.pushReplacement(PageConfigList.getDrawerScreen(), TransitionType.foldTransition);
      } else {
        pageStateProvider.pop();
      }
    } else {
      Utility.toastMessage(mFA5D5D, 'Invalid Field', 'Novel Name field can\'t be left empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            if (kIsWeb) {
              pageStateProvider.pushReplacement(PageConfigList.getDrawerScreen(), TransitionType.foldTransition);
            } else {
              pageStateProvider.pop();
            }
          },
          child: const Icon(
            Icons.close,
            color: mWhite,
            size: 30,
          ),
        ),
        title: TextView(
          label: widget.novelId != null ? 'Edit Hidden List Novel' : 'Create Hidden List Novel',
          fontSize: 18,
          color: mWhite,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: checkValidationAndCreateEditNovel,
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
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                              child: TextField(
                                controller: readChapterController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          const TextView(
                            label: 'Read Chapter',
                            color: mBlack,
                            fontSize: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                              child: TextField(
                                controller: totalChapterController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          const TextView(
                            label: 'Total Chapter',
                            color: mBlack,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: indexingGroupNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Group Name',
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
                        label: 'Novel Reading Status:',
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
                                  value: NovelReadingStatus.notStarted,
                                  groupValue: novelReadingStatus,
                                  onChanged: (value) {
                                    setState(
                                      () => novelReadingStatus = value ?? NovelReadingStatus.reading,
                                    );
                                  },
                                ),
                              ),
                              const TextView(
                                label: 'Not Started',
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
                                  value: NovelReadingStatus.reading,
                                  groupValue: novelReadingStatus,
                                  onChanged: (value) {
                                    setState(
                                      () => novelReadingStatus = value ?? NovelReadingStatus.reading,
                                    );
                                  },
                                ),
                              ),
                              const TextView(
                                label: 'Reading',
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
                                  value: NovelReadingStatus.hiatusCompleted,
                                  groupValue: novelReadingStatus,
                                  onChanged: (value) {
                                    setState(
                                      () => novelReadingStatus = value ?? NovelReadingStatus.reading,
                                    );
                                  },
                                ),
                              ),
                              const TextView(
                                label: 'Hiatus Completed',
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
                                  value: NovelReadingStatus.completed,
                                  groupValue: novelReadingStatus,
                                  onChanged: (value) {
                                    setState(
                                      () => novelReadingStatus = value ?? NovelReadingStatus.reading,
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
