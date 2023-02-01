/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/your_novel_list_controller.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
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
  ScrollController novelListController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (Get.find<YourNovelListController>().novelList.isEmpty) {
          Get.find<YourNovelListController>().refreshList(widget.userId);
        }
        novelListController.addListener(
          () {
            if (novelListController.position.pixels == novelListController.position.maxScrollExtent) {
              if (Get.find<YourNovelListController>().isLoading) return;
              Get.find<YourNovelListController>().addNextData(widget.userId);
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
          pageStateProvider.push(PageConfigList.getCreateNovelListItemScreen(widget.userId));
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(color: appPrimaryColor, borderRadius: BorderRadius.circular(27.5)),
          child: const Icon(color: mWhite, size: 30, Icons.add),
        ),
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
                itemCount: controller.novelList.length + 1,
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
              ),
            );
          }
        },
      ),
    );
  }
}
