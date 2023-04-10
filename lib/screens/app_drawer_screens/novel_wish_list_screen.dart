/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/novel_wish_list_controller.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/common_stream_controller.dart';
import 'package:novel_log/utility/debouncer.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/common_search_widget.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'package:novel_log/widgets/novel_wish_list_screen_widgets/novel_wish_list_card.dart';
import 'package:novel_log/widgets/novel_wish_list_screen_widgets/novel_wish_list_tile.dart';

class NovelWishListScreen extends StatefulWidget {
  final String userId;

  const NovelWishListScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<NovelWishListScreen> createState() => _NovelWishListScreenState();
}

class _NovelWishListScreenState extends State<NovelWishListScreen> {
  NovelWishListController novelWishListController = Get.put(NovelWishListController());
  late ScrollController novelGridViewController;
  late ScrollController novelListViewController;
  CommonStreamController textSearchStream = CommonStreamController();
  final _debouncer = Debouncer(milliseconds: 500);
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    novelGridViewController = ScrollController(initialScrollOffset: novelWishListController.gridScrollPosition);
    novelListViewController = ScrollController(initialScrollOffset: novelWishListController.listScrollPosition);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (novelWishListController.novelList.isEmpty) {
          if (kIsWeb) {
            novelWishListController.refreshList(widget.userId);
          } else {
            novelWishListController.refreshListLocalDatabase(localDb.database, widget.userId);
          }
        }
        novelGridViewController.addListener(
          () {
            novelWishListController.updateGridScrollPosition(novelGridViewController.position.pixels);
            if (novelGridViewController.position.pixels == novelGridViewController.position.maxScrollExtent) {
              if (novelWishListController.isLoading) return;
              if (kIsWeb) {
                novelWishListController.addNextData(widget.userId);
              }
            }
          },
        );
        novelListViewController.addListener(
          () {
            novelWishListController.updateListScrollPosition(novelListViewController.position.pixels);
            if (novelListViewController.position.pixels == novelListViewController.position.maxScrollExtent) {
              if (novelWishListController.isLoading) return;
              if (kIsWeb) {
                novelWishListController.addNextData(widget.userId);
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
      appBar: width > 600
          ? AppBar(
              centerTitle: true,
              title: const TextView(label: 'Wish List'),
            )
          : null,
      floatingActionButton: InkWell(
        onTap: () {
          if (kIsWeb) {
            pageStateProvider.pushReplacement(PageConfigList.getCreateNovelWishListItemScreen(widget.userId), TransitionType.foldTransition);
          } else {
            pageStateProvider.push(PageConfigList.getCreateNovelWishListItemScreen(widget.userId), TransitionType.foldTransition);
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
          ? Column(
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
                              novelWishListController.refreshListLocalDatabase(localDb.database, widget.userId, searchQuery: value.trim());
                            }
                          },
                          onChanged: (value) {
                            textSearchStream.selectionSink.add(value.length);
                            _debouncer.run(
                              () {
                                novelWishListController.refreshListLocalDatabase(localDb.database, widget.userId, searchQuery: value.trim());
                              },
                            );
                          },
                        ),
                      ),
                Expanded(
                  child: GetBuilder<NovelWishListController>(
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
                                        PageConfigList.getCreateNovelWishListItemScreen(
                                          widget.userId,
                                          controller.novelList[index].novelId,
                                        ),
                                        TransitionType.foldTransition,
                                      );
                                    } else {
                                      pageStateProvider.push(
                                        PageConfigList.getCreateNovelWishListItemScreen(
                                          widget.userId,
                                          controller.novelList[index].novelId,
                                        ),
                                        TransitionType.foldTransition,
                                      );
                                    }
                                  },
                                  child: NovelWishListTile(
                                    novelName: controller.novelList[index].novelName ?? '',
                                    novelLinkUrl: controller.novelList[index].novelLinkUrl ?? '',
                                    novelGenre: controller.novelList[index].novelGenre ?? [],
                                    novelImageUrl: controller.novelList[index].novelImageUrl ?? '',
                                    novelAuthorName: controller.novelList[index].novelAuthorName ?? '',
                                    totalNovelChapterCount: controller.novelList[index].totalNovelChapterCount ?? 0,
                                    readNovelChapterCount: controller.novelList[index].readNovelChapterCount ?? 0,
                                    isNovel: controller.novelList[index].isNovel ?? true,
                                    novelStatus: controller.novelList[index].novelStatus ?? NovelStatus.production,
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
            )
          : GetBuilder<NovelWishListController>(
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
                                            PageConfigList.getCreateNovelWishListItemScreen(
                                              widget.userId,
                                              controller.novelList[index].novelId,
                                            ),
                                            TransitionType.foldTransition,
                                          );
                                        } else {
                                          pageStateProvider.push(
                                            PageConfigList.getCreateNovelWishListItemScreen(
                                              widget.userId,
                                              controller.novelList[index].novelId,
                                            ),
                                            TransitionType.foldTransition,
                                          );
                                        }
                                      },
                                      child: NovelWishListCard(
                                        novelName: controller.novelList[index].novelName ?? '',
                                        novelLinkUrl: controller.novelList[index].novelLinkUrl ?? '',
                                        novelImageUrl: controller.novelList[index].novelImageUrl ?? '',
                                        totalNovelChapterCount: controller.novelList[index].totalNovelChapterCount ?? 0,
                                        readNovelChapterCount: controller.novelList[index].readNovelChapterCount ?? 0,
                                        isNovel: controller.novelList[index].isNovel ?? true,
                                        novelStatus: controller.novelList[index].novelStatus ?? NovelStatus.production,
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
