/*
* Created by Shrikunj Patel on 2/28/2023.
*/

import 'package:novel_log/utility/local_database_services/novel_local_services.dart';
import 'package:novel_log/utility/local_database_services/user_local_services.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseServices {
  static const databaseName = 'novel_database.db';
  static const databaseVersion = 1;

  late Database database;

  Future<void> initDatabase() async {
    Utility.printLog("initDatabase method called");
    final tempDocumentDirectory = await getApplicationDocumentsDirectory();
    String path = join(tempDocumentDirectory.path, databaseName);
    database = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int version) async {
    Utility.printLog("database onCreate method called");
    UserLocalServices.createUserTable(db);
    NovelLocalServices.createNovelTable(db);
  }
}
