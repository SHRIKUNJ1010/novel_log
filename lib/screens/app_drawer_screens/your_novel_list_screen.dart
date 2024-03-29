/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/your_novel_list_controller.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/common_stream_controller.dart';
import 'package:novel_log/utility/debouncer.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/common_search_widget.dart';
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
  CommonStreamController textSearchStream = CommonStreamController();
  final _debouncer = Debouncer(milliseconds: 500);
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    novelGridViewController = ScrollController(initialScrollOffset: yourNovelListController.gridScrollPosition);
    novelListViewController = ScrollController(initialScrollOffset: yourNovelListController.listScrollPosition);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (yourNovelListController.novelList.isEmpty) {
          if (kIsWeb) {
            yourNovelListController.refreshList(widget.userId);
          } else {
            yourNovelListController.refreshListLocalDatabase(localDb.database, widget.userId);
          }
        }
        novelGridViewController.addListener(
          () {
            yourNovelListController.updateGridScrollPosition(novelGridViewController.position.pixels);
            if (novelGridViewController.position.pixels == novelGridViewController.position.maxScrollExtent) {
              if (yourNovelListController.isLoading) return;
              if (kIsWeb) {
                yourNovelListController.addNextData(widget.userId);
              }
            }
          },
        );
        novelListViewController.addListener(
          () {
            yourNovelListController.updateListScrollPosition(novelListViewController.position.pixels);
            if (novelListViewController.position.pixels == novelListViewController.position.maxScrollExtent) {
              if (yourNovelListController.isLoading) return;
              if (kIsWeb) {
                yourNovelListController.addNextData(widget.userId);
              }
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
      appBar: Utility.getCommonAppBarWithoutIcon(width, 'Your Novels'),
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
      body: width < 500 ? getListViewBody(width) : getGridViewBody(width),
    );
  }

  Widget getListViewBody(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        kIsWeb
            ? const SizedBox()
            : Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(color: appThemeColor[50]!, borderRadius: BorderRadius.circular(7.5)),
                height: 40,
                width: width - 10,
                child: CommonSearchWidget(
                  stream: textSearchStream.selectionStream,
                  searchController: searchTextEditingController,
                  padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 18),
                  hintText: 'Search',
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      yourNovelListController.refreshListLocalDatabase(localDb.database, widget.userId, searchQuery: value.trim());
                    }
                  },
                  onChanged: (value) {
                    textSearchStream.selectionSink.add(value.length);
                    _debouncer.run(
                      () {
                        yourNovelListController.refreshListLocalDatabase(localDb.database, widget.userId, searchQuery: value.trim());
                      },
                    );
                  },
                ),
              ),
        Expanded(
          child: GetBuilder<YourNovelListController>(
            builder: (controller) {
              if (!controller.isLoading && controller.novelList.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    if (kIsWeb) {
                      controller.refreshList(widget.userId);
                    } else {
                      controller.refreshListLocalDatabase(localDb.database, widget.userId);
                    }
                    return Future.value(null);
                  },
                  child: Utility.noDataLoadedText(),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    if (kIsWeb) {
                      controller.refreshList(widget.userId);
                    } else {
                      controller.refreshListLocalDatabase(localDb.database, widget.userId);
                    }
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
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget getGridViewBody(double width) {
    return GetBuilder<YourNovelListController>(
      builder: (controller) {
        if (!controller.isLoading && controller.novelList.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              if (kIsWeb) {
                controller.refreshList(widget.userId);
              } else {
                controller.refreshListLocalDatabase(localDb.database, widget.userId);
              }
              return Future.value(null);
            },
            child: Utility.noDataLoadedText(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              if (kIsWeb) {
                controller.refreshList(widget.userId);
              } else {
                controller.refreshListLocalDatabase(localDb.database, widget.userId);
              }
              return Future.value(null);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                controller: novelGridViewController,
                children: [
                  StaggeredGrid.count(
                    crossAxisCount: Utility.widthToGridCount(width),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
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
            ),
          );
        }
      },
    );
  }
}
