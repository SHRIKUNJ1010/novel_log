import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novel_log/models/data_models/novel_description_model.dart';
import 'package:novel_log/models/data_models/novel_list_item_model.dart';
import 'package:novel_log/models/data_models/novel_wish_list_item_model.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/firebase_services/database_services/firebase_database_services.dart';
import 'package:novel_log/utility/utility.dart';

class NovelServices {
  //function for creating novel data in server
  static Future<void> createNovel(Map<String, dynamic> data) async {
    await FirebaseDatabaseServices.novelCollectionReference.add(data);
  }

  static Future<void> editNovel(String novelId, Map<String, dynamic> data) async {
    await FirebaseDatabaseServices.novelCollectionReference.doc(novelId).set(data);
  }

  static Future<NovelDescriptionModel> getNovelData(String novelId) async {
    final temp = await FirebaseDatabaseServices.novelCollectionReference.doc(novelId).get();
    return NovelDescriptionModel.fromJson(novelId, temp.data() ?? {});
  }

  static Future<void> userNovelStatistic(String userId) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference.where("user_id", isEqualTo: userId).get();
    int readChapterCount = 0;
    int totalNovelCount = tempData.docs.length;
    int totalCompletedNovelCount = 0;
    int totalHiatusNovelCount = 0;

    final tempList = tempData.docs.map((e) => NovelDescriptionModel.fromJson(e.id, e.data())).toList();

    for (var e in tempList) {
      readChapterCount += e.readNovelChapterCount ?? 0;
      if (e.novelReadingStatus == NovelReadingStatus.completed) {
        totalCompletedNovelCount++;
      }
      if (e.novelReadingStatus == NovelReadingStatus.hiatusCompleted) {
        totalHiatusNovelCount++;
      }
    }

    Utility.printLog(
        "Read chapter count: $readChapterCount ======== \nTotal Novel Count $totalNovelCount ======= \nTotal Completed Novel Count $totalCompletedNovelCount ======= \nTotal Hiatus Novel Count $totalHiatusNovelCount =======");
  }

  //getting first page data for main page novel list
  static Future<Map<String, dynamic>> getMainNovelListFirstPage(String userId) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("user_id", isEqualTo: userId)
        .where("is_hidden", isEqualTo: "0")
        .where("is_in_wish_list", isEqualTo: "0")
        .orderBy("novel_reading_status")
        .orderBy("is_novel", descending: true)
        .orderBy("indexing_group_name")
        .orderBy("novel_author_name")
        .orderBy("read_novel_chapter_count")
        .orderBy("total_novel_chapter_count")
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs.map((e) => NovelListItemModel.fromJson(e.id, e.data())).toList(),
      "last_document": tempData.docs.isEmpty ? null : tempData.docs[tempData.docs.length - 1],
      "remaining_length": tempData.docs.length,
    };
  }

  //getting next page data from last document snapshot of previous page for
  //main page novel list
  static Future<Map<String, dynamic>> getMainNovelListNextPages(
    String userId,
    QueryDocumentSnapshot<Map<String, dynamic>>? startAfterDoc,
  ) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("user_id", isEqualTo: userId)
        .where("is_hidden", isEqualTo: "0")
        .where("is_in_wish_list", isEqualTo: "0")
        .orderBy("novel_reading_status")
        .orderBy("is_novel", descending: true)
        .orderBy("indexing_group_name")
        .orderBy("novel_author_name")
        .orderBy("read_novel_chapter_count")
        .orderBy("total_novel_chapter_count")
        .startAfterDocument(startAfterDoc!)
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs.map((e) => NovelListItemModel.fromJson(e.id, e.data())).toList(),
      "last_document": tempData.docs.isEmpty ? null : tempData.docs[tempData.docs.length - 1],
      "remaining_length": tempData.docs.length,
    };
  }

  //first page novel wish list
  static Future<Map<String, dynamic>> getNovelWishListFirstPage(String userId) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("user_id", isEqualTo: userId)
        .where("is_hidden", isEqualTo: "0")
        .where("is_in_wish_list", isEqualTo: "1")
        .orderBy("is_novel", descending: true)
        .orderBy("indexing_group_name")
        .orderBy("novel_author_name")
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs.map((e) => NovelWishListItemModel.fromJson(e.id, e.data())).toList(),
      "last_document": tempData.docs.isEmpty ? null : tempData.docs[tempData.docs.length - 1],
      "remaining_length": tempData.docs.length,
    };
  }

  //next page novel wish list
  static Future<Map<String, dynamic>> getNovelWishListNextPages(
    String userId,
    QueryDocumentSnapshot<Map<String, dynamic>>? startAfterDoc,
  ) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("user_id", isEqualTo: userId)
        .where("is_hidden", isEqualTo: "0")
        .where("is_in_wish_list", isEqualTo: "1")
        .orderBy("is_novel", descending: true)
        .orderBy("indexing_group_name")
        .orderBy("novel_author_name")
        .startAfterDocument(startAfterDoc!)
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs.map((e) => NovelWishListItemModel.fromJson(e.id, e.data())).toList(),
      "last_document": tempData.docs.isEmpty ? null : tempData.docs[tempData.docs.length - 1],
      "remaining_length": tempData.docs.length,
    };
  }

  //first page for novel hidden list
  static Future<Map<String, dynamic>> getNovelHiddenListFirstPage(String userId) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("user_id", isEqualTo: userId)
        .where("is_hidden", isEqualTo: "1")
        .where("is_in_wish_list", isEqualTo: "0")
        .orderBy("novel_reading_status")
        .orderBy("is_novel", descending: true)
        .orderBy("indexing_group_name")
        .orderBy("novel_author_name")
        .orderBy("read_novel_chapter_count")
        .orderBy("total_novel_chapter_count")
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs.map((e) => NovelListItemModel.fromJson(e.id, e.data())).toList(),
      "last_document": tempData.docs.isEmpty ? null : tempData.docs[tempData.docs.length - 1],
      "remaining_length": tempData.docs.length,
    };
  }

  //next page for novel hidden list
  static Future<Map<String, dynamic>> getNovelHiddenListNextPages(
    String userId,
    QueryDocumentSnapshot<Map<String, dynamic>>? startAfterDoc,
  ) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("user_id", isEqualTo: userId)
        .where("is_hidden", isEqualTo: "1")
        .where("is_in_wish_list", isEqualTo: "0")
        .orderBy("novel_reading_status")
        .orderBy("is_novel", descending: true)
        .orderBy("indexing_group_name")
        .orderBy("novel_author_name")
        .orderBy("read_novel_chapter_count")
        .orderBy("total_novel_chapter_count")
        .startAfterDocument(startAfterDoc!)
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs.map((e) => NovelListItemModel.fromJson(e.id, e.data())).toList(),
      "last_document": tempData.docs.isEmpty ? null : tempData.docs[tempData.docs.length - 1],
      "remaining_length": tempData.docs.length,
    };
  }

//end of file
}
