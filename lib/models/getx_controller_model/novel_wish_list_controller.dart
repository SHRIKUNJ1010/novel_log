/*
* Created by Shrikunj Patel on 1/27/2023.
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:novel_log/models/data_models/novel_wish_list_item_model.dart';
import 'package:novel_log/utility/firebase_services/database_services/novel_services.dart';
import 'package:novel_log/utility/utility.dart';

class NovelWishListController extends GetxController {
  double gridScrollPosition = 0;
  double listScrollPosition = 0;
  List<NovelWishListItemModel> novelList = [];
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
    lastData = null;
    novelList = [];
    remainingLength = 0;
    callIsLoading();
    final data = await NovelServices.getNovelWishListFirstPage(userId);
    lastData = data['last_document'];
    novelList = data['novel_list'];
    remainingLength = data['remaining_length'];
    Utility.printLog(novelList);
    callIsNotLoading();
  }

  addNextData(String userId) async {
    if (remainingLength < 20) return;
    callIsLoading();
    final data = await NovelServices.getNovelWishListNextPages(userId, lastData);
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
