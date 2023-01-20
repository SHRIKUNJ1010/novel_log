/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';

class PageStateProvider extends ChangeNotifier {
  List<PageConfiguration> config = [];

  PageStateProvider();

  void clearPages() {
    config = [];
    notifyListeners();
  }

  void addAllPages(List<PageConfiguration> conf) {
    config = conf;
    notifyListeners();
  }

  void push(PageConfiguration configuration) {
    config.add(configuration);
    notifyListeners();
  }

  void pop() {
    config.removeLast();
    notifyListeners();
  }

  void pushReplacement(PageConfiguration configuration) {
    if (config.isNotEmpty) config.removeLast();
    config.add(configuration);
    notifyListeners();
  }

  void popUntil(PageConfiguration configuration) {
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
  }
}
