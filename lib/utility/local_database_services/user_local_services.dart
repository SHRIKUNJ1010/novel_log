/*
* Created by Shrikunj Patel on 2/28/2023.
*/

import 'package:novel_log/models/data_models/user_profile_model.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalServices {
  static const userTable = 'user_table';

  static Future<void> createUserTable(Database db) async {
    await db.execute('''
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
              $yearlyChapterReadCountKeyName TEXT
            )
             ''');
    Utility.printLog("user table created");
  }

  static Future<void> insertUserData(Database db, UserProfileModel user) async {
    await db.rawDelete('DELETE FROM $userTable');
    Utility.printLog("user data deleted");
    await db.rawInsert('''
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
          $yearlyChapterReadCountKeyName
        ) VALUES (
          "${user.userId}",
          "${user.userName}",
          "${user.email}",
          ${user.totalChapterReadCount},
          ${user.totalStartedNovelCount},
          ${user.totalNovelReadCompleteWithNovelComplete},
          ${user.totalNovelReadCompleteWithNovelHiatus},
          "${user.userProfileImageUrl}",
          "${user.userHiddenPin}",
          ${user.todayChapterReadCount},
          ${user.dailyAverageChapterReadCount},
          "",
          "",
          ""
        )
        ''');
    Utility.printLog("user data inserted");
  }

  static Future<UserProfileModel> getUserData(Database db) async {
    //when inserting or updating user table data existing data is removed and
    // new data is added so required data will always be in first element of query
    // result list
    List data = await db.rawQuery('''SELECT * FROM $userTable''');
    UserProfileModel temp = UserProfileModel(
      userId: data[0][userIdKeyName],
      userName: data[0][userNameKeyName],
      email: data[0][emailKeyName],
      userProfileImageUrl: data[0][userProfileImageUrlKeyName],
      userHiddenPin: data[0][userHiddenPinKeyName],
      todayChapterReadCount: data[0][todayChapterReadCountKeyName],
      weeklyChapterReadCount: [],
      monthlyChapterReadCount: [],
      yearlyChapterReadCount: [],
      dailyAverageChapterReadCount: data[0][dailyAverageChapterReadCountKeyName] * 1.00,
      totalChapterReadCount: data[0][totalChapterReadCountKeyName],
      totalNovelReadCompleteWithNovelComplete: data[0][totalNovelReadCompleteWithNovelCompleteKeyName],
      totalNovelReadCompleteWithNovelHiatus: data[0][totalNovelReadCompleteWithNovelHiatusKeyName],
      totalStartedNovelCount: data[0][totalStartedNovelCountKeyName],
    );
    Utility.printLog("user data get query called");
    return temp;
  }

  static Future<void> changeTotalNovelCountOfUser(Database db, String userId, int totalNovelCount) async {
    await db.rawUpdate('''
    UPDATE $userTable
    SET $totalStartedNovelCountKeyName = $totalNovelCount
    WHERE $userIdKeyName = $userId
    ''');
  }

  static Future<void> changeTotalChapterReadCountOfUser(Database db, String userId, int totalChapterReadCount) async {
    await db.rawUpdate('''
    UPDATE $userTable
    SET $totalChapterReadCountKeyName = $totalChapterReadCount
    WHERE $userIdKeyName = $userId
    ''');
  }

  static Future<void> changeCompleteNovelCountOfUser(Database db, String userId, int completeNovelCount) async {
    await db.rawUpdate('''
    UPDATE $userTable
    SET $totalNovelReadCompleteWithNovelCompleteKeyName = $completeNovelCount
    WHERE $userIdKeyName = $userId
    ''');
  }

  static Future<void> changeHiatusNovelCountOfUser(Database db, String userId, int hiatusNovelCount) async {
    await db.rawUpdate('''
    UPDATE $userTable
    SET $totalNovelReadCompleteWithNovelHiatusKeyName = $hiatusNovelCount
    WHERE $userIdKeyName = $userId
    ''');
  }

  //end of file
}
