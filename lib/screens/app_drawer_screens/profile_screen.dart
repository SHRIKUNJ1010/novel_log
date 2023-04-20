/*
* Created by Shrikunj Patel on 1/23/2023.
*/

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/novel_hidden_list_controller.dart';
import 'package:novel_log/models/getx_controller_model/novel_wish_list_controller.dart';
import 'package:novel_log/models/getx_controller_model/user_data_controller.dart';
import 'package:novel_log/models/getx_controller_model/your_novel_list_controller.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/common_rounded_button.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'package:novel_log/widgets/profile_screen_widgets/novel_statistic_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserDataController userController = Get.put(UserDataController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (userController.userData.email == null) {
          if (kIsWeb) {
            userController.getUserData(Preference.getUserId());
          } else {
            userController.getUserData(Preference.getUserId(), db: localDb.database);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: Utility.getCommonAppBarWithoutIcon(width, 'Profile'),
      body: GetBuilder<UserDataController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(avatarPlaceholderImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ],
                ),
                TextView(
                  label: controller.userData.userName ?? 'No Name',
                  fontSize: 28,
                  color: appPrimaryColor,
                ),
                TextView(
                  label: controller.userData.email ?? 'No Email',
                  fontSize: 24,
                  color: appPrimaryColor,
                ),
                const SizedBox(height: 20),
                Container(
                  margin: width < 600 ? const EdgeInsets.only(left: 15, right: 15) : null,
                  child: NovelStatisticWidget(
                    todayChapterReadCount: controller.userData.todayChapterReadCount ?? 0,
                    totalStartedNovelCount: controller.userData.totalStartedNovelCount ?? 0,
                    totalChapterReadCount: controller.userData.totalChapterReadCount ?? 0,
                    totalNovelReadCompleteWithNovelComplete: controller.userData.totalNovelReadCompleteWithNovelComplete ?? 0,
                    totalNovelReadCompleteWithNovelHiatus: controller.userData.totalNovelReadCompleteWithNovelHiatus ?? 0,
                    dailyAverageChapterReadCount: controller.userData.dailyAverageChapterReadCount ?? 0,
                    fontSize: width > 720
                        ? 22
                        : width > 670
                            ? 20
                            : width > 645
                                ? 18
                                : width > 620
                                    ? 16
                                    : 17,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CommonRoundedButton(
                    height: 50,
                    text: 'Re-calculate statistic',
                    fontSize: 18,
                    onTap: () {
                      if (kIsWeb) {
                        controller.reCalculateStatistic(widget.userId);
                      } else {
                        controller.reCalculateStatisticFromLocalDatabase(localDb.database, widget.userId);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: CommonRoundedButton(
                    height: 50,
                    text: 'Transfer User Data to Local Database',
                    fontSize: 18,
                    onTap: () async {
                      if (!kIsWeb) {
                        await controller.storeDataInLocalDatabase(widget.userId, localDb.database);
                        controller.getUserData(widget.userId, db: localDb.database);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: CommonRoundedButton(
                    height: 50,
                    text: 'Transfer Novel Data to Local Database',
                    fontSize: 18,
                    onTap: () async {
                      if (!kIsWeb) {
                        await Utility.getNovelDataFromFirebaseAndInsertIntoLocalDatabase(widget.userId, localDb.database);
                        YourNovelListController yourNovelListController = Get.put(YourNovelListController());
                        NovelWishListController novelWishListController = Get.put(NovelWishListController());
                        NovelHiddenListController novelHiddenListController = Get.put(NovelHiddenListController());
                        yourNovelListController.refreshListLocalDatabase(localDb.database, widget.userId);
                        novelWishListController.refreshListLocalDatabase(localDb.database, widget.userId);
                        novelHiddenListController.refreshListLocalDatabase(localDb.database, widget.userId);
                      }
                    },
                  ),
                ),
                if (!kIsWeb) Platform.isIOS || Platform.isAndroid ? const SizedBox(height: 100) : const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
