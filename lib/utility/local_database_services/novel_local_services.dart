/*
* Created by Shrikunj Patel on 2/28/2023.
*/

import 'package:novel_log/models/data_models/novel_description_model.dart';
import 'package:novel_log/models/data_models/novel_list_item_model.dart';
import 'package:novel_log/models/data_models/novel_wish_list_item_model.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:sqflite/sqflite.dart';

class NovelLocalServices {
  static const novelTable = 'novel_table';

  static Future<void> createNovelTable(Database db) async {
    db.execute('''
      CREATE TABLE $novelTable (
        $novelIdKeyName TEXT PRIMARY KEY,
        $userIdKeyName TEXT,
        $novelNameKeyName TEXT,
        $novelAuthorNameKeyName TEXT,
        $novelGenreKeyName TEXT,
        $novelDescriptionKeyName TEXT,
        $novelImageUrlKeyName TEXT,
        $isNovelKeyName TEXT,
        $totalNovelChapterCountKeyName INTEGER,
        $readNovelChapterCountKeyName INTEGER,
        $novelLinkUrlKeyName TEXT,
        $indexingGroupNameKeyName TEXT,
        $novelStatusKeyName TEXT,
        $novelReadingStatusKeyName TEXT,
        $isHiddenKeyName TEXT,
        $isInWishListKeyName TEXT
      )
      ''');
    Utility.printLog("novel table created");
  }

  static Future<void> insertNovelData(Database db, NovelDescriptionModel data) async {
    List temp = await db.rawQuery('''
         SELECT COUNT(*)
         FROM $novelTable
         WHERE $novelNameKeyName = "${data.novelName}";
    ''');
    if (temp[0]["COUNT(*)"] != 0) {
      await editNovelData(db, data.novelId ?? '', data);
      return;
    }
    await db.rawInsert('''
        INSERT INTO $novelTable (
          $novelIdKeyName,
          $userIdKeyName,
          $novelNameKeyName,
          $novelAuthorNameKeyName,
          $novelGenreKeyName,
          $novelDescriptionKeyName,
          $novelImageUrlKeyName,
          $isNovelKeyName,
          $totalNovelChapterCountKeyName,
          $readNovelChapterCountKeyName,
          $novelLinkUrlKeyName,
          $indexingGroupNameKeyName,
          $novelStatusKeyName,
          $novelReadingStatusKeyName,
          $isHiddenKeyName,
          $isInWishListKeyName
        ) VALUES (
          "${data.novelId}",
          "${data.userId}",
          "${data.novelName}",
          "${data.novelAuthorName}",
          "${Utility.listToCommaSeparatedString(data.novelGenre ?? [])}",
          "${data.novelDescription}",
          "${data.novelImageUrl}",
          "${(data.isNovel ?? false) ? 1 : 0}",
          ${data.totalNovelChapterCount},
          ${data.readNovelChapterCount},
          "${data.novelLinkUrl}",
          "${data.indexingGroupName}",
          "${Utility.novelStatusToString(data.novelStatus ?? NovelStatus.production)}",
          "${Utility.novelReadingStatusToString(data.novelReadingStatus ?? NovelReadingStatus.reading)}",
          "${(data.isHidden ?? false) ? 1 : 0}",
          "${(data.isInWishList ?? false) ? 1 : 0}"
        );
        ''');
    Utility.printLog("novel inserted");
  }

  static Future<void> editNovelData(Database db, String novelId, NovelDescriptionModel data) async {
    await db.rawUpdate('''
    UPDATE $novelTable
    SET $novelNameKeyName = "${data.novelName}",
        $novelAuthorNameKeyName = "${data.novelAuthorName}",
        $novelGenreKeyName = "${Utility.listToCommaSeparatedString(data.novelGenre ?? [])}",
        $novelDescriptionKeyName = "${data.novelDescription}",
        $novelImageUrlKeyName = "${data.novelImageUrl}",
        $isNovelKeyName = "${(data.isNovel ?? false) ? 1 : 0}",
        $totalNovelChapterCountKeyName = ${data.totalNovelChapterCount},
        $readNovelChapterCountKeyName = ${data.readNovelChapterCount},
        $novelLinkUrlKeyName = "${data.novelLinkUrl}",
        $indexingGroupNameKeyName = "${data.indexingGroupName}",
        $novelStatusKeyName = "${Utility.novelStatusToString(data.novelStatus ?? NovelStatus.production)}",
        $novelReadingStatusKeyName = "${Utility.novelReadingStatusToString(data.novelReadingStatus ?? NovelReadingStatus.reading)}",
        $isHiddenKeyName = "${(data.isHidden ?? false) ? 1 : 0}",
        $isInWishListKeyName = "${(data.isInWishList ?? false) ? 1 : 0}"        
    WHERE $novelIdKeyName = "$novelId";
    ''');
    Utility.printLog("novel data updated");
  }

  static Future<NovelDescriptionModel> getNovelData(Database db, String novelId) async {
    List data = await db.rawQuery('''SELECT * FROM $novelTable WHERE $novelIdKeyName = "$novelId";''');
    Utility.printLog("novel get data called");
    return NovelDescriptionModel.fromJson(novelId, data[0]);
  }

  static Future<void> deleteNovel(Database db, String novelId) async {
    await db.rawDelete('''DELETE FROM $novelTable WHERE $novelIdKeyName = "$novelId";''');
    Utility.printLog("novel get data called");
  }

  static Future<Map<String, dynamic>> userNovelStatistic(Database db, String userId) async {
    List temp1 = await db.rawQuery('''
         SELECT 
            COUNT(*) AS $totalStartedNovelCountKeyName, 
            SUM($readNovelChapterCountKeyName) AS $totalChapterReadCountKeyName
         FROM $novelTable
         WHERE $userIdKeyName = "$userId";
    ''');
    List temp2 = await db.rawQuery('''
         SELECT 
            COUNT(*) AS $totalNovelReadCompleteWithNovelCompleteKeyName
         FROM $novelTable
         WHERE 
            $userIdKeyName = "$userId" 
            AND 
            $novelReadingStatusKeyName = "completed";
    ''');
    List temp3 = await db.rawQuery('''
         SELECT 
            COUNT(*) AS $totalNovelReadCompleteWithNovelHiatusKeyName
         FROM $novelTable
         WHERE 
            $userIdKeyName = "$userId" 
            AND 
            $novelReadingStatusKeyName = "hiatus_completed";
    ''');

    Utility.printLog("novel statistic data called");
    return {
      'read_chapter_count': temp1[0][totalChapterReadCountKeyName],
      'total_novel_count': temp1[0][totalStartedNovelCountKeyName],
      'total_completed_novel_count': temp2[0][totalNovelReadCompleteWithNovelCompleteKeyName],
      'total_hiatus_novel_count': temp3[0][totalNovelReadCompleteWithNovelHiatusKeyName],
    };
  }

  static Future<List<NovelListItemModel>> getNovelList(Database db, String userId) async {
    List data = await db.rawQuery('''
    SELECT * 
    FROM $novelTable 
    WHERE 
      $userIdKeyName = "$userId" 
      AND 
      $isHiddenKeyName = "0" 
      AND 
      $isInWishListKeyName = "0"
    ORDER BY 
      $novelReadingStatusKeyName ASC, 
      $isNovelKeyName DESC, 
      $indexingGroupNameKeyName ASC, 
      $novelAuthorNameKeyName ASC, 
      $readNovelChapterCountKeyName ASC, 
      $totalNovelChapterCountKeyName ASC, 
      $novelNameKeyName ASC;
    ''');
    Utility.printLog("novel get list data called");
    return data.map((e) => NovelListItemModel.fromJsonLocal(e)).toList();
  }

  static Future<List<NovelWishListItemModel>> getNovelWishList(Database db, String userId) async {
    List data = await db.rawQuery('''
    SELECT * 
    FROM $novelTable 
    WHERE 
      $userIdKeyName = "$userId" 
      AND 
      $isHiddenKeyName = "0" 
      AND 
      $isInWishListKeyName = "1"
    ORDER BY  
      $isNovelKeyName DESC, 
      $indexingGroupNameKeyName ASC, 
      $novelAuthorNameKeyName ASC, 
      $novelNameKeyName ASC;
    ''');
    Utility.printLog("novel get wish list data called");
    return data.map((e) => NovelWishListItemModel.fromJsonLocal(e)).toList();
  }

  static Future<List<NovelListItemModel>> getNovelHiddenList(Database db, String userId) async {
    List data = await db.rawQuery('''
    SELECT * 
    FROM $novelTable 
    WHERE 
      $userIdKeyName = "$userId" 
      AND 
      $isHiddenKeyName = "1" 
      AND 
      $isInWishListKeyName = "0"
    ORDER BY 
      $novelReadingStatusKeyName ASC, 
      $isNovelKeyName DESC, 
      $indexingGroupNameKeyName ASC, 
      $novelAuthorNameKeyName ASC, 
      $readNovelChapterCountKeyName ASC, 
      $totalNovelChapterCountKeyName ASC, 
      $novelNameKeyName ASC;
    ''');
    Utility.printLog("novel get hidden list data called");
    return data.map((e) => NovelListItemModel.fromJsonLocal(e)).toList();
  }

  static Future<List<NovelDescriptionModel>> getAllNovelList(Database db, String userId) async {
    List data = await db.rawQuery('''
    SELECT * 
    FROM $novelTable 
    WHERE $userIdKeyName = "$userId";
    ''');
    Utility.printLog("novel get all list data called");
    return data.map((e) => NovelDescriptionModel.fromJsonLocal(e)).toList();
  }
}
