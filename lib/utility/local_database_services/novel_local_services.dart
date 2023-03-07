/*
* Created by Shrikunj Patel on 2/28/2023.
*/

import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/local_database_services/local_database_services.dart';

class NovelLocalServices {
  static const novelTable = 'novel_table';

  static Future<void> createNovelTable() async {
    await LocalDatabaseServices.database.then((value) {
      value.execute('''
      CREATE TABLE $novelTable (
        $novelIdKeyName TEXT PRIMARY KEY,
        $novelNameKeyName TEXT,
        $novelGenreKeyName TEXT,
        $novelAuthorNameKeyName TEXT,
        $novelDescriptionKeyName TEXT,
        $novelImageUrlKeyName TEXT,
        $indexingGroupNameKeyName TEXT,
        $isNovelKeyName TEXT,
        $totalNovelChapterCountKeyName INTEGER,
        $readNovelChapterCountKeyName INTEGER,
        $novelLinkUrlKeyName TEXT,
        $novelStatusKeyName TEXT,
        $novelReadingStatusKeyName TEXT,
        $isHiddenKeyName TEXT,
        $isInWishListKeyName TEXT,
      )
      ''');
    });
  }
}
