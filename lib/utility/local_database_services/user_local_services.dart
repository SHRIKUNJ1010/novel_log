/*
* Created by Shrikunj Patel on 2/28/2023.
*/

import 'package:novel_log/models/data_models/user_profile_model.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/local_database_services/local_database_services.dart';

class UserLocalServices {
  static const userTable = 'user_table';

  static Future<void> createUserTable() async {
    await LocalDatabaseServices.database.then(
      (value) {
        value.execute('''
            CREATE TABLE $userTable (
              $userIdKeyName TEXT PRIMARY KEY,
              $userNameKeyName TEXT,
              $emailKeyName TEXT,
              $totalChapterReadCountKeyName INTEGER,
              $totalStartedNovelCountKeyName INTEGER,
              $totalNovelReadCompleteWithNovelCompleteKeyName INTEGER,
              $totalNovelReadCompleteWithNovelHiatusKeyName INTEGER,
              $userProfileImageUrlKeyName TEXT,
              $userHiddenPinKeyName TEXT,
              $todayChapterReadCountKeyName INTEGER,
              $dailyAverageChapterReadCountKeyName INTEGER,
              $weeklyChapterReadCountKeyName TEXT,
              $monthlyChapterReadCountKeyName TEXT,
              $yearlyChapterReadCountKeyName TEXT,
            )
             ''');
      },
    );
  }

  static Future<void> insertUserData(UserProfileModel user) async {
    await LocalDatabaseServices.database.then(
      (value) {
        value.rawInsert('''
        INSERT INTO $userTable (
          $userIdKeyName,
          $userNameKeyName,
          $emailKeyName,
          $totalChapterReadCountKeyName,
          $totalStartedNovelCountKeyName,
          $totalNovelReadCompleteWithNovelCompleteKeyName,
          $totalNovelReadCompleteWithNovelHiatusKeyName,
          $userProfileImageUrlKeyName,
          $userHiddenPinKeyName,
          $todayChapterReadCountKeyName,
          $dailyAverageChapterReadCountKeyName,
          $weeklyChapterReadCountKeyName,
          $monthlyChapterReadCountKeyName,
          $yearlyChapterReadCountKeyName,
        ) VALUES (
          ${user.userId},
          ${user.userName},
          ${user.email},
          ${user.totalChapterReadCount},
          ${user.totalStartedNovelCount},
          ${user.totalNovelReadCompleteWithNovelComplete},
          ${user.totalNovelReadCompleteWithNovelHiatus},
          ${user.userProfileImageUrl},
          ${user.userHiddenPin},
          ${user.todayChapterReadCount},
          ${user.dailyAverageChapterReadCount},
          ${user.weeklyChapterReadCount},
          ${user.monthlyChapterReadCount},
          ${user.yearlyChapterReadCount},
        )
        ''');
      },
    );
  }

  static Future<UserProfileModel> getUserData() async {
    var db = await LocalDatabaseServices.database;
    List data = await db.rawQuery('''SELECT * FROM $userTable''');
    UserProfileModel temp = UserProfileModel(
      userId: data[0][userIdKeyName],
      userName: data[0][userNameKeyName],
      email: data[0][emailKeyName],
      userProfileImageUrl: data[0][userProfileImageUrlKeyName],
      userHiddenPin: data[0][userHiddenPinKeyName],
      todayChapterReadCount: data[0][todayChapterReadCountKeyName],
      weeklyChapterReadCount: data[0][weeklyChapterReadCountKeyName],
      monthlyChapterReadCount: data[0][monthlyChapterReadCountKeyName],
      yearlyChapterReadCount: data[0][yearlyChapterReadCountKeyName],
      dailyAverageChapterReadCount: data[0][dailyAverageChapterReadCountKeyName],
      totalChapterReadCount: data[0][totalChapterReadCountKeyName],
      totalNovelReadCompleteWithNovelComplete: data[0][totalNovelReadCompleteWithNovelCompleteKeyName],
      totalNovelReadCompleteWithNovelHiatus: data[0][totalNovelReadCompleteWithNovelHiatusKeyName],
      totalStartedNovelCount: data[0][totalStartedNovelCountKeyName],
    );
    return temp;
  }
}
