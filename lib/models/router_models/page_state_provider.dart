/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/utility.dart';

class PageStateProvider extends ChangeNotifier {
  List<PageConfiguration> config = [];

  PageStateProvider();

  void clearPages() {
    Utility.printLog('clearPages ----------------------------------------------------');
    config = [];
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void addAllPages(List<PageConfiguration> conf) {
    Utility.printLog('addAllPages ----------------------------------------------------');
    config = conf;
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void push(PageConfiguration configuration) {
    Utility.printLog('push ----------------------------------------------------');
    config.add(configuration);
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void pop() {
    Utility.printLog('pop ----------------------------------------------------');
    config.removeLast();
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

  void pushReplacement(PageConfiguration configuration) {
    Utility.printLog('pushReplacement ----------------------------------------------------');
    if (config.isNotEmpty) config.removeLast();
    config.add(configuration);
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
      last = config.length - 1;
    }
    Utility.printLog(config.map((e) => e.path).toList());
    notifyListeners();
  }

//end of file
}
