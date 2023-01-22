import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novel_log/models/data_models/novel_list_item_model.dart';
import 'package:novel_log/utility/firebase_services/database_services/firebase_database_services.dart';

class NovelServices {
  static Future<void> createNovel(Map<String, dynamic> data) async {
    await FirebaseDatabaseServices.novelCollectionReference.add(data);
  }

  static Future<Map<String, dynamic>> getMainNovelListFirstPage() async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("isHidden", isEqualTo: "0")
        .where("isInWishList", isEqualTo: "0")
        .orderBy("read_novel_chapter_count")
        .orderBy("total_novel_chapter_count")
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs
          .map((e) => NovelListItemModel.fromJson(e.id, e.data()))
          .toList(),
      "last_document": tempData.docs[tempData.docs.length - 1],
    };
  }

  static Future<Map<String, dynamic>> getMainNovelListNextPages(
    DocumentSnapshot<Object?> startAfterDoc,
  ) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("isHidden", isEqualTo: "0")
        .where("isInWishList", isEqualTo: "0")
        .orderBy("read_novel_chapter_count")
        .orderBy("total_novel_chapter_count")
        .startAfterDocument(startAfterDoc)
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs
          .map((e) => NovelListItemModel.fromJson(e.id, e.data()))
          .toList(),
      "last_document": tempData.docs[tempData.docs.length - 1],
    };
  }
}
