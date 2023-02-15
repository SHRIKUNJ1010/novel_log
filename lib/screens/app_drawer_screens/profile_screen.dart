/*
* Created by Shrikunj Patel on 1/23/2023.
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/models/getx_controller_model/user_data_controller.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/preference.dart';
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
          userController.getUserData(Preference.getUserId());
        }
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
              title: const TextView(label: 'Profile'),
            )
          : null,
      body: GetBuilder<UserDataController>(
        builder: (controller) {
          return Column(
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
              NovelStatisticWidget(
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
                                : 18,
              ),
            ],
          );
        },
      ),
    );
  }
}
