/*
* Created by Shrikunj Patel on 1/27/2023.
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:novel_log/models/data_models/novel_list_item_model.dart';
import 'package:novel_log/utility/firebase_services/database_services/novel_services.dart';
import 'package:novel_log/utility/local_database_services/novel_local_services.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:sqflite/sqflite.dart';

class NovelHiddenListController extends GetxController {
  double gridScrollPosition = 0;
  double listScrollPosition = 0;
  List<NovelListItemModel> novelList = [];
  QueryDocumentSnapshot<Map<String, dynamic>>? lastData;
  int remainingLength = 0;
  bool isLoading = false;

  callIsLoading() {
    isLoading = true;
    update();
  }

  callIsNotLoading() {
    isLoading = false;
    update();
  }

  refreshList(String userId) async {
    gridScrollPosition = 0;
    listScrollPosition = 0;
    lastData = null;
    novelList = [];
    remainingLength = 0;
    callIsLoading();
    final data = await NovelServices.getNovelHiddenListFirstPage(userId);
    lastData = data['last_document'];
    novelList = data['novel_list'];
    remainingLength = data['remaining_length'];
    Utility.printLog(novelList);
    callIsNotLoading();
  }

  refreshListLocalDatabase(Database db, String userId) async {
    gridScrollPosition = 0;
    listScrollPosition = 0;
    novelList = [];
    callIsLoading();
    novelList = await NovelLocalServices.getNovelHiddenList(db, userId);
    Utility.printLog(novelList);
    callIsNotLoading();
  }

  addNextData(String userId) async {
    if (remainingLength < 20 || lastData == null) return;
    callIsLoading();
    final data = await NovelServices.getNovelHiddenListNextPages(userId, lastData);
    lastData = data['last_document'];
    novelList += data['novel_list'];
    remainingLength = data['remaining_length'];
    Utility.printLog(novelList);
    callIsNotLoading();
  }

  updateGridScrollPosition(double scrollPosition) {
    gridScrollPosition = scrollPosition;
    update();
  }

  updateListScrollPosition(double scrollPosition) {
    listScrollPosition = scrollPosition;
    update();
  }

  clearList() {
    lastData = null;
    novelList = [];
    remainingLength = 0;
    update();
  }

//end of file
}
