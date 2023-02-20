/*
* Created by Shrikunj Patel on 2/15/2023.
*/

import 'package:get/get.dart';
import 'package:novel_log/models/data_models/user_profile_model.dart';
import 'package:novel_log/utility/firebase_services/database_services/novel_services.dart';
import 'package:novel_log/utility/firebase_services/database_services/user_services.dart';
import 'package:novel_log/utility/utility.dart';

class UserDataController extends GetxController {
  UserProfileModel userData = UserProfileModel();

  getUserData(String userId) async {
    userData = await UserServices.getUserData(userId);
    Utility.printLog(userData.toJson());
    update();
  }

  reCalculateStatistic(String userId) async {
    final tempData = await NovelServices.userNovelStatistic(userId);
    userData.totalChapterReadCount = tempData['read_chapter_count'];
    userData.totalStartedNovelCount = tempData['total_novel_count'];
    userData.totalNovelReadCompleteWithNovelComplete = tempData['total_completed_novel_count'];
    userData.totalNovelReadCompleteWithNovelHiatus = tempData['total_hiatus_novel_count'];
    update();
  }
}
