/*
* Created by Shrikunj Patel on 1/23/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/page_config_list.dart';

class DrawerStateProvider extends ChangeNotifier {
  PageConfiguration selectedPageConfig = PageConfigList.getYourNovelListScreen();

  DrawerStateProvider();

  void changeCurrentSelectedPage(PageConfiguration configuration) {
    selectedPageConfig = configuration;
    notifyListeners();
  }

//end of file
}
