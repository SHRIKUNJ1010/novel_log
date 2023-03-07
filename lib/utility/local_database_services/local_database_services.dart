/*
* Created by Shrikunj Patel on 2/28/2023.
*/

import 'package:novel_log/utility/local_database_services/novel_local_services.dart';
import 'package:novel_log/utility/local_database_services/user_local_services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseServices {
  static const databaseName = 'novel_database.db';
  static const databaseVersion = 1;

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    return await initDatabase();
  }

  static initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    _database = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: onCreate,
    );
    return _database;
  }

  static Future onCreate(Database db, int version) async {
    await UserLocalServices.createUserTable();
    await NovelLocalServices.createNovelTable();
  }
}
