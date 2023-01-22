import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novel_log/models/data_models/novel_list_item_model.dart';
import 'package:novel_log/models/data_models/novel_wish_list_item_model.dart';
import 'package:novel_log/utility/firebase_services/database_services/firebase_database_services.dart';

class NovelServices {
  //function for creating novel data in server
  static Future<void> createNovel(Map<String, dynamic> data) async {
    await FirebaseDatabaseServices.novelCollectionReference.add(data);
  }

  //getting first page data for main page novel list
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

  //getting next page data from last document snapshot of previous page for
  //main page novel list
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

  //first page novel wish list
  static Future<Map<String, dynamic>> getNovelWishListFirstPage() async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("isHidden", isEqualTo: "0")
        .where("isInWishList", isEqualTo: "1")
        .orderBy("total_novel_chapter_count")
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs
          .map((e) => NovelWishListItemModel.fromJson(e.id, e.data()))
          .toList(),
      "last_document": tempData.docs[tempData.docs.length - 1],
    };
  }

  //next page novel wish list
  static Future<Map<String, dynamic>> getNovelWishListNextPages(
    DocumentSnapshot<Object?> startAfterDoc,
  ) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("isHidden", isEqualTo: "0")
        .where("isInWishList", isEqualTo: "1")
        .orderBy("total_novel_chapter_count")
        .startAfterDocument(startAfterDoc)
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs
          .map((e) => NovelWishListItemModel.fromJson(e.id, e.data()))
          .toList(),
      "last_document": tempData.docs[tempData.docs.length - 1],
    };
  }

  //first page for novel hidden list
  static Future<Map<String, dynamic>> getNovelHiddenListFirstPage() async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("isHidden", isEqualTo: "1")
        .where("isInWishList", isEqualTo: "0")
        .limit(20)
        .get();
    return {
      "novel_list": tempData.docs
          .map((e) => NovelListItemModel.fromJson(e.id, e.data()))
          .toList(),
      "last_document": tempData.docs[tempData.docs.length - 1],
    };
  }

  //next page for novel hidden list
  static Future<Map<String, dynamic>> getNovelHiddenListNextPages(
    DocumentSnapshot<Object?> startAfterDoc,
  ) async {
    final tempData = await FirebaseDatabaseServices.novelCollectionReference
        .where("isHidden", isEqualTo: "1")
        .where("isInWishList", isEqualTo: "0")
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

//end of file
}
