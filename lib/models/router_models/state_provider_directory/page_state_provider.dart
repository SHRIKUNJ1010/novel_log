/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';

class PageStateProvider extends ChangeNotifier {
  List<PageConfiguration> config = [];
  List<TransitionType> transitionList = [];

  PageStateProvider();

  void clearPages() {
    Utility.printLog('clearPages ----------------------------------------------------');
    config = [];
    transitionList = [];
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void addAllPages(List<PageConfiguration> conf) {
    Utility.printLog('addAllPages ----------------------------------------------------');
    config = conf;
    transitionList = [];
    for (int i = 0; i < conf.length; i++) {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void push(PageConfiguration configuration, [TransitionType? transitionType]) {
    Utility.printLog('push ----------------------------------------------------');
    config.add(configuration);
    if (transitionType != null) {
      transitionList.add(transitionType);
    } else {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void pop() {
    Utility.printLog('pop ----------------------------------------------------');
    config.removeLast();
    transitionList.removeLast();
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void pushReplacement(PageConfiguration configuration, [TransitionType? transitionType]) {
    Utility.printLog('pushReplacement ----------------------------------------------------');
    if (config.isNotEmpty) config.removeLast();
    if (transitionList.isNotEmpty) transitionList.removeLast();
    config.add(configuration);
    if (transitionType != null) {
      transitionList.add(transitionType);
    } else {
      transitionList.add(TransitionType.defaultTransition);
    }
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void popUntil(PageConfiguration configuration) {
    Utility.printLog('popUntil ----------------------------------------------------');
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
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

//end of file
}
