/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/models/getx_controller_model/your_novel_list_controller.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'package:novel_log/widgets/your_novel_list_screen_widgets/your_novel_list_tile.dart';

class YourNovelListScreen extends StatefulWidget {
  final bool showAppBar;
  final String userId;

  const YourNovelListScreen({
    Key? key,
    required this.userId,
    this.showAppBar = false,
  }) : super(key: key);

  @override
  State<YourNovelListScreen> createState() => _YourNovelListScreenState();
}

class _YourNovelListScreenState extends State<YourNovelListScreen> {
  YourNovelListController yourNovelListController = Get.put(YourNovelListController());
  ScrollController novelListController = ScrollController();

  @override
  void initState() {
    Get.find<YourNovelListController>().refreshList(widget.userId);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        novelListController.addListener(
          () {
            if (novelListController.position.pixels == novelListController.position.maxScrollExtent) {
              if (Get.find<YourNovelListController>().isLoading) return;
              Get.find<YourNovelListController>().addNewPage(widget.userId);
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextView(label: 'Your Novels'),
        ),
        body: GetBuilder<YourNovelListController>(
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
                  controller: novelListController,
                  itemBuilder: (context, index) {
                    if (index == controller.novelList.length) {
                      return Utility.getLoadingView(isLoading: controller.isLoading);
                    } else {
                      return YourNovelListTile(
                        novelName: controller.novelList[index].novelName ?? '',
                        novelLinkUrl: controller.novelList[index].novelLinkUrl ?? '',
                        novelImageUrl: controller.novelList[index].novelImageUrl ?? '',
                        totalNovelChapterCount: controller.novelList[index].totalNovelChapterCount ?? 0,
                        readNovelChapterCount: controller.novelList[index].readNovelChapterCount ?? 0,
                        isNovel: controller.novelList[index].isNovel ?? true,
                        novelReadingStatus: controller.novelList[index].novelReadingStatus ?? NovelReadingStatus.reading,
                      );
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: controller.novelList.length + 1,
                ),
              );
            }
          },
        ),
      );
    } else {
      return Scaffold(
        body: GetBuilder<YourNovelListController>(
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
                  controller: novelListController,
                  itemBuilder: (context, index) {
                    if (index == controller.novelList.length) {
                      return Utility.getLoadingView(isLoading: controller.isLoading);
                    } else {
                      return YourNovelListTile(
                        novelName: controller.novelList[index].novelName ?? '',
                        novelLinkUrl: controller.novelList[index].novelLinkUrl ?? '',
                        novelImageUrl: controller.novelList[index].novelImageUrl ?? '',
                        totalNovelChapterCount: controller.novelList[index].totalNovelChapterCount ?? 0,
                        readNovelChapterCount: controller.novelList[index].readNovelChapterCount ?? 0,
                        isNovel: controller.novelList[index].isNovel ?? true,
                        novelReadingStatus: controller.novelList[index].novelReadingStatus ?? NovelReadingStatus.reading,
                      );
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: controller.novelList.length + 1,
                ),
              );
            }
          },
        ),
      );
    }
  }
}
