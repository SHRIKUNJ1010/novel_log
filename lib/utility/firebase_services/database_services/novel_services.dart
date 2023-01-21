import 'package:novel_log/utility/firebase_services/database_services/firebase_database_services.dart';

class NovelServices {

  static Future<void> createNovel(Map<String, dynamic> data) async{
    await FirebaseDatabaseServices.novelCollectionReference.add(data);
  }

}
