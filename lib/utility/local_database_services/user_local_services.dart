/*
* Created by Shrikunj Patel on 2/28/2023.
*/

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
              $weeklyChapterReadCountKeyName CREATE TYPE weekArray AS INTEGER ARRAY[7],
              $monthlyChapterReadCountKeyName CREATE TYPE monthArray AS INTEGER ARRAY[30],
              $yearlyChapterReadCountKeyName CREATE TYPE yearArray AS INTEGER ARRAY[365],
            )
             ''');
      },
    );
  }
}
