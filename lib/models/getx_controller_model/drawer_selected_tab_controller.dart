/*
* Created by Shrikunj Patel on 2/1/2023.
*/

import 'package:get/get.dart';
import 'package:novel_log/utility/page_and_transition_services/page_routes.dart';

class DrawerSelectedTabController extends GetxController {
  String selectedPath = yourNovelListScreenRoute;

  updateSelectedPath(String path) {
    selectedPath = path;
    update();
  }

//end of file
}
