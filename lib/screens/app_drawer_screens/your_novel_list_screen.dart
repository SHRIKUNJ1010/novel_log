/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/your_novel_list_controller.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'package:novel_log/widgets/your_novel_list_screen_widgets/your_novel_list_card.dart';
import 'package:novel_log/widgets/your_novel_list_screen_widgets/your_novel_list_tile.dart';

class YourNovelListScreen extends StatefulWidget {
  final String userId;

  const YourNovelListScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<YourNovelListScreen> createState() => _YourNovelListScreenState();
}

class _YourNovelListScreenState extends State<YourNovelListScreen> {
  YourNovelListController yourNovelListController = Get.put(YourNovelListController());
  late ScrollController novelGridViewController;
  late ScrollController novelListViewController;

  @override
  void initState() {
    novelGridViewController = ScrollController(initialScrollOffset: yourNovelListController.gridScrollPosition);
    novelListViewController = ScrollController(initialScrollOffset: yourNovelListController.listScrollPosition);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (yourNovelListController.novelList.isEmpty) {
          yourNovelListController.refreshList(widget.userId);
        }
        novelGridViewController.addListener(
          () {
            yourNovelListController.updateGridScrollPosition(novelGridViewController.position.pixels);
            if (novelGridViewController.position.pixels == novelGridViewController.position.maxScrollExtent) {
              if (yourNovelListController.isLoading) return;
              yourNovelListController.addNextData(widget.userId);
            }
          },
        );
        novelListViewController.addListener(
          () {
            yourNovelListController.updateListScrollPosition(novelListViewController.position.pixels);
            if (novelListViewController.position.pixels == novelListViewController.position.maxScrollExtent) {
              if (yourNovelListController.isLoading) return;
              yourNovelListController.addNextData(widget.userId);
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: width > 600
          ? AppBar(
              centerTitle: true,
              title: const TextView(label: 'Your Novels'),
            )
          : null,
      floatingActionButton: InkWell(
        onTap: () {
          if (kIsWeb) {
            pageStateProvider.pushReplacement(PageConfigList.getCreateNovelListItemScreen(widget.userId), TransitionType.foldTransition);
          } else {
            pageStateProvider.push(PageConfigList.getCreateNovelListItemScreen(widget.userId), TransitionType.foldTransition);
          }
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(color: appPrimaryColor, borderRadius: BorderRadius.circular(27.5)),
          child: const Icon(color: mWhite, size: 30, Icons.add),
        ),
      ),
      body: width < 620
          ? GetBuilder<YourNovelListController>(
              builder: (controller) {
                if (!controller.isLoading && controller.novelList.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.refreshList(widget.userId);
                      return Future.value(null);
                    },
                    child: Utility.noDataLoadedText(),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.refreshList(widget.userId);
                      return Future.value(null);
                    },
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      controller: novelListViewController,
                      itemCount: controller.novelList.length + 1,
                      itemBuilder: (context, index) {
                        if (index == controller.novelList.length) {
                          return Utility.getLoadingView(isLoading: controller.isLoading);
                        } else {
                          return InkWell(
                            onTap: () {
                              if (kIsWeb) {
                                pageStateProvider.pushReplacement(
                                  PageConfigList.getCreateNovelListItemScreen(
                                    widget.userId,
                                    controller.novelList[index].novelId,
                                  ),
                                  TransitionType.foldTransition,
                                );
                              } else {
                                pageStateProvider.push(
                                  PageConfigList.getCreateNovelListItemScreen(
                                    widget.userId,
                                    controller.novelList[index].novelId,
                                  ),
                                  TransitionType.foldTransition,
                                );
                              }
                            },
                            child: YourNovelListTile(
                              novelName: controller.novelList[index].novelName ?? '',
                              novelLinkUrl: controller.novelList[index].novelLinkUrl ?? '',
                              novelGenre: controller.novelList[index].novelGenre ?? [],
                              novelImageUrl: controller.novelList[index].novelImageUrl ?? '',
                              totalNovelChapterCount: controller.novelList[index].totalNovelChapterCount ?? 0,
                              readNovelChapterCount: controller.novelList[index].readNovelChapterCount ?? 0,
                              isNovel: controller.novelList[index].isNovel ?? true,
                              novelReadingStatus: controller.novelList[index].novelReadingStatus ?? NovelReadingStatus.reading,
                            ),
                          );
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                    ),
                  );
                }
              },
            )
          : GetBuilder<YourNovelListController>(
              builder: (controller) {
                if (!controller.isLoading && controller.novelList.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.refreshList(widget.userId);
                      return Future.value(null);
                    },
                    child: Utility.noDataLoadedText(),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.refreshList(widget.userId);
                      return Future.value(null);
                    },
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      controller: novelGridViewController,
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            for (int index = 0; index < controller.novelList.length + 1; index++) ...[
                              index == controller.novelList.length
                                  ? Utility.getLoadingView(isLoading: controller.isLoading)
                                  : InkWell(
                                      onTap: () {
                                        if (kIsWeb) {
                                          pageStateProvider.pushReplacement(
                                            PageConfigList.getCreateNovelListItemScreen(
                                              widget.userId,
                                              controller.novelList[index].novelId,
                                            ),
                                            TransitionType.foldTransition,
                                          );
                                        } else {
                                          pageStateProvider.push(
                                            PageConfigList.getCreateNovelListItemScreen(
                                              widget.userId,
                                              controller.novelList[index].novelId,
                                            ),
                                            TransitionType.foldTransition,
                                          );
                                        }
                                      },
                                      child: YourNovelListCard(
                                        novelName: controller.novelList[index].novelName ?? '',
                                        novelLinkUrl: controller.novelList[index].novelLinkUrl ?? '',
                                        novelImageUrl: controller.novelList[index].novelImageUrl ?? '',
                                        totalNovelChapterCount: controller.novelList[index].totalNovelChapterCount ?? 0,
                                        readNovelChapterCount: controller.novelList[index].readNovelChapterCount ?? 0,
                                        isNovel: controller.novelList[index].isNovel ?? true,
                                        novelReadingStatus: controller.novelList[index].novelReadingStatus ?? NovelReadingStatus.reading,
                                        novelAuthorName: controller.novelList[index].novelAuthorName ?? '',
                                        novelDescription: controller.novelList[index].novelDescription ?? '',
                                        novelGenre: controller.novelList[index].novelGenre ?? [],
                                      ),
                                    ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
    );
  }
}
