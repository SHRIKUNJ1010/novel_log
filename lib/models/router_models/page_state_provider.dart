/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';

class PageStateProvider extends ChangeNotifier {
  List<PageConfiguration> config = [];

  PageStateProvider();

  void addPage(PageConfiguration configuration) {
    config.add(configuration);
    notifyListeners();
  }

  void removeLastPage() {
    config.removeLast();
    notifyListeners();
  }

  void clearPages() {
    config = [];
    notifyListeners();
  }

  void addAllPages(List<PageConfiguration> conf) {
    config = conf;
    notifyListeners();
  }

  void replaceLastPage(PageConfiguration configuration) {
    if (config.isNotEmpty) config.removeLast();
    config.add(configuration);
    notifyListeners();
  }
}
