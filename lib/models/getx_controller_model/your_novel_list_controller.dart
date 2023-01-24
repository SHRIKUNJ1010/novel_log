/*
* Created by Shrikunj Patel on 1/24/2023.
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:novel_log/models/data_models/novel_list_item_model.dart';
import 'package:novel_log/utility/firebase_services/database_services/novel_services.dart';
import 'package:novel_log/utility/utility.dart';

class YourNovelListController extends GetxController {
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
    lastData = null;
    novelList = [];
    remainingLength = 0;
    callIsLoading();
    final data = await NovelServices.getMainNovelListFirstPage();
    lastData = data['last_document'];
    novelList += data['novel_list'];
    remainingLength = data['remaining_length'];
    Utility.printLog(novelList);
    callIsNotLoading();
    //update();
  }

  addNextData(String userId) async {
    if (remainingLength < 20) return;
    callIsLoading();
    final data = await NovelServices.getMainNovelListNextPages(lastData);
    lastData = data['last_document'];
    novelList += data['novel_list'];
    remainingLength = data['remaining_length'];
    Utility.printLog(novelList);
    callIsNotLoading();
    //update();
  }

//end of file
}
