/*
* Created by Shrikunj Patel on 2/15/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:novel_log/models/data_models/user_profile_model.dart';
import 'package:novel_log/utility/firebase_services/database_services/novel_services.dart';
import 'package:novel_log/utility/firebase_services/database_services/user_services.dart';
import 'package:novel_log/utility/local_database_services/novel_local_services.dart';
import 'package:novel_log/utility/local_database_services/user_local_services.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:sqflite/sqflite.dart';

class UserDataController extends GetxController {
  UserProfileModel userData = UserProfileModel();

  //get user data by user id
  Future<void> getUserData(String userId, {Database? db}) async {
    if ((!kIsWeb) && (db != null)) {
      userData = await UserLocalServices.getUserData(db);
      Utility.printLog("from  Local Database");
    } else {
      userData = await UserServices.getUserData(userId);
      Utility.printLog("from Firebase");
    }
    Utility.printLog(userData.toJson());
    update();
    return;
  }

  Future<void> storeDataInLocalDatabase(String userId, Database db) async {
    await Utility.getUserDataFromFirebaseAndInsertIntoLocalDatabase(userId, db);
    return;
  }

  //re calculating the statistic of novels if data gets reset
  reCalculateStatistic(String userId) async {
    final tempData = await NovelServices.userNovelStatistic(userId);
    userData.totalChapterReadCount = tempData['read_chapter_count'];
    userData.totalStartedNovelCount = tempData['total_novel_count'];
    userData.totalNovelReadCompleteWithNovelComplete = tempData['total_completed_novel_count'];
    userData.totalNovelReadCompleteWithNovelHiatus = tempData['total_hiatus_novel_count'];
    UserServices.changeTotalNovelCountOfUser(userId, tempData['total_novel_count']);
    UserServices.changeTotalChapterReadCountOfUser(userId, tempData['read_chapter_count']);
    UserServices.changeHiatusNovelCountOfUser(userId, tempData['total_hiatus_novel_count']);
    UserServices.changeCompleteNovelCountOfUser(userId, tempData['total_completed_novel_count']);
    update();
  }

  reCalculateStatisticFromLocalDatabase(Database db, String userId) async {
    final tempData = await NovelLocalServices.userNovelStatistic(db, userId);
    userData.totalChapterReadCount = tempData['read_chapter_count'];
    userData.totalStartedNovelCount = tempData['total_novel_count'];
    userData.totalNovelReadCompleteWithNovelComplete = tempData['total_completed_novel_count'];
    userData.totalNovelReadCompleteWithNovelHiatus = tempData['total_hiatus_novel_count'];
    UserLocalServices.changeTotalNovelCountOfUser(db, userId, tempData['total_novel_count']);
    UserLocalServices.changeTotalChapterReadCountOfUser(db, userId, tempData['read_chapter_count']);
    UserLocalServices.changeHiatusNovelCountOfUser(db, userId, tempData['total_hiatus_novel_count']);
    UserLocalServices.changeCompleteNovelCountOfUser(db, userId, tempData['total_completed_novel_count']);
    update();
  }

  changeUserPin(String userId, String userPinNew, String userPinOld) async {
    /*final temp = await UserServices.changeUserHiddenPin(userId, userPinOld, userPinNew);
    getUserData(userId);*/
  }

  createNewUserPin(String userId, String userPin) async {
    /*final temp = await UserServices.createUserHiddenPin(userId, userPin);
    getUserData(userId);*/
  }

  Future<bool> comparePinHash(String userId, String userPin) async {
    /*final tempHash = await UserServices.getUserPinHash(userId);
    final givenPinHash = Password.hash(userPin, PBKDF2());
    return tempHash == givenPinHash;*/
    return true;
  }
}
