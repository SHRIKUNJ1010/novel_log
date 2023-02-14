/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/utility.dart';

class PageStateProvider extends ChangeNotifier {
  List<PageConfiguration> config = [PageConfigList.getSplashScreen()];
  List<TransitionType> transitionList = [TransitionType.slideDownTransition];

  PageStateProvider();

  void clearPages() {
    Utility.printLog('clearPages for page state provider ----------------------------------------------------');
    config = [];
    transitionList = [];
    Utility.printLog("page state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("page state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

  void addAllPages(List<PageConfiguration> conf) {
    Utility.printLog('addAllPages for page state provider ----------------------------------------------------');
    config = conf;
    transitionList = [];
    for (int i = 0; i < conf.length; i++) {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog("page state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("page state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

  Future<dynamic> push(PageConfiguration configuration, [TransitionType? transitionType]) {
    Utility.printLog('push for page state provider ----------------------------------------------------');
    config.add(configuration);
    if (transitionType != null) {
      transitionList.add(transitionType);
    } else {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog("page state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("page state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
    return configuration.popped.future;
  }

  void pop<T extends Object?>([T? result]) {
    Utility.printLog('pop for page state provider ----------------------------------------------------');
    config[config.length - 1].popped.complete(result);
    config.removeLast();
    transitionList.removeLast();
    Utility.printLog("page state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("page state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

  Future<dynamic> pushReplacement(PageConfiguration configuration, [TransitionType? transitionType]) {
    Utility.printLog('pushReplacement for page state provider ----------------------------------------------------');
    if (config.isNotEmpty) config.removeLast();
    if (transitionList.isNotEmpty) transitionList.removeLast();
    config.add(configuration);
    if (transitionType != null) {
      transitionList.add(transitionType);
    } else {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog("page state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("page state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
    return configuration.popped.future;
  }

  void popUntil(PageConfiguration configuration) {
    Utility.printLog('popUntil for page state provider ----------------------------------------------------');
    int last = config.length - 1;
    if (last < 0) {
      last = 0;
    }
    int i = config.indexWhere((element) => element.path == configuration.path);
    if (i == -1) {
      i = 0;
    }
    while (last != i) {
      config[config.length - 1].popped.complete();
      config.removeLast();
      transitionList.removeLast();
      last = config.length - 1;
    }
    Utility.printLog("page state provider page config list ${config.map((e) => e.path).toList()}");
    Utility.printLog("page state provider transition list ${transitionList.map((e) => e.toString()).toList()}");
    notifyListeners();
  }

//end of file
}
