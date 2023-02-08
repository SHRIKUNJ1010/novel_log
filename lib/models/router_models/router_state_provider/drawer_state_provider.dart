/*
* Created by Shrikunj Patel on 1/23/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';

class DrawerStateProvider extends ChangeNotifier {
  List<PageConfiguration> config = [PageConfigList.getYourNovelListScreen(Preference.getUserId())];
  List<TransitionType> transitionList = [TransitionType.defaultTransition];

  DrawerStateProvider();

  void clearPages() {
    Utility.printLog('clearPages for drawer state provider ----------------------------------------------------');
    config = [];
    transitionList = [];
    Utility.printLog("drawer state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("drawer state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

  void addAllPages(List<PageConfiguration> conf) {
    Utility.printLog('addAllPages for drawer state provider ----------------------------------------------------');
    config = conf;
    transitionList = [];
    for (int i = 0; i < conf.length; i++) {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog("drawer state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("drawer state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

  void push(PageConfiguration configuration, [TransitionType? transitionType]) {
    Utility.printLog('push for drawer state provider ----------------------------------------------------');
    config.add(configuration);
    if (transitionType != null) {
      transitionList.add(transitionType);
    } else {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog("drawer state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("drawer state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

  void pop() {
    Utility.printLog('pop for drawer state provider ----------------------------------------------------');
    config.removeLast();
    transitionList.removeLast();
    Utility.printLog("drawer state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("drawer state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

  void pushReplacement(PageConfiguration configuration, [TransitionType? transitionType]) {
    Utility.printLog('pushReplacement for drawer state provider ----------------------------------------------------');
    if (config.isNotEmpty) config.removeLast();
    if (transitionList.isNotEmpty) transitionList.removeLast();
    config.add(configuration);
    if (transitionType != null) {
      transitionList.add(transitionType);
    } else {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog("drawer state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("drawer state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

  void popUntil(PageConfiguration configuration) {
    Utility.printLog('popUntil for drawer state provider ----------------------------------------------------');
    int last = config.length - 1;
    if (last < 0) {
      last = 0;
    }
    int i = config.indexWhere((element) => element.path == configuration.path);
    if (i == -1) {
      i = 0;
    }
    while (last != i) {
      config.removeLast();
      transitionList.removeLast();
      last = config.length - 1;
    }
    Utility.printLog("drawer state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("drawer state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

//end of file
}
