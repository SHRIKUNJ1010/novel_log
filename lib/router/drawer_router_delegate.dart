/*
* Created by Shrikunj Patel on 1/24/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/page_and_transition_services/transition_to_page.dart';
import 'package:novel_log/utility/utility.dart';

class DrawerRouterDelegate extends RouterDelegate<List<PageConfiguration>> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  @override
  GlobalKey<NavigatorState>? get navigatorKey => drawerNavigatorKey;

  DrawerRouterDelegate() : super() {
    drawerStateProvider.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: buildPages(),
      onPopPage: _onPopPage,
    );
  }

  bool canPop() {
    return drawerStateProvider.config.length > 1;
  }

  @override
  Future<bool> popRoute() {
    Utility.printLog('pop route called for drawer ---------------------------------------------------');
    if (canPop()) {
      drawerStateProvider.pop();
      return Future.value(true);
    }
    return Future.value(false);
  }

  bool _onPopPage(Route<dynamic> route, result) {
    Utility.printLog('on pop page called for drawer --------------------------------------------------------');
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    popRoute();
    return true;
  }

  void addCommonPage({
    int? index,
    required PageConfiguration pageConfiguration,
    TransitionType transitionType = TransitionType.defaultTransition,
  }) {
    if (index != null) {
      pages.insert(
        index,
        TransitionToPage.getPage(
          transitionType,
          pageConfiguration,
        ),
      );
    } else {
      pages.add(
        TransitionToPage.getPage(
          transitionType,
          pageConfiguration,
        ),
      );
    }
  }

  List<Page> buildPages() {
    Utility.printLog('build pages called for drawer -------------------------------------------------');
    Utility.printLog("drawer page config list : ${drawerStateProvider.config.map((e) => e.path).toList()}");
    if (drawerStateProvider.config.length < pages.length) {
      pages = [];
    }
    for (int i = 0; i < drawerStateProvider.config.length; i++) {
      if (i < pages.length) {
        if (pages[i].name == drawerStateProvider.config[i].path) {
          //do nothing
        } else {
          pages.removeAt(i);
          addCommonPage(
            index: i,
            pageConfiguration: drawerStateProvider.config[i],
            transitionType: drawerStateProvider.transitionList[i],
          );
        }
      } else {
        addCommonPage(
          pageConfiguration: drawerStateProvider.config[i],
          transitionType: drawerStateProvider.transitionList[i],
        );
      }
    }
    if (drawerStateProvider.config.isEmpty) {
      Utility.printLog('your novel screen added when empty config got ------------------------------------------');
      addCommonPage(
        pageConfiguration: PageConfigList.getYourNovelListScreen(Preference.getUserId()),
      );
    }
    Utility.printLog("pages list drawer: ${pages.map((e) => e.name).toList()}");
    return List.of(pages);
  }

  @override
  List<PageConfiguration>? get currentConfiguration => drawerStateProvider.config;

  @override
  Future<void> setNewRoutePath(List<PageConfiguration> configuration) {
    Utility.printLog('set new route path called for drawer -------------------------------------------');
    Utility.printLog("set new route path for drawer page config list : ${configuration.map((e) => e.path).toList()}");
    if (configuration.isNotEmpty) {
      drawerStateProvider.addAllPages(configuration);
    }
    return SynchronousFuture(null);
  }

  @override
  Future<void> setInitialRoutePath(List<PageConfiguration> configuration) {
    Utility.printLog('set initial route path called for drawer -------------------------------------------');
    Utility.printLog("set initial route path for drawer page config list : ${configuration.map((e) => e.path).toList()}");
    if (configuration.isNotEmpty) {
      drawerStateProvider.addAllPages(configuration);
    } else {
      drawerStateProvider.addAllPages([PageConfigList.getYourNovelListScreen(Preference.getUserId())]);
    }

    return SynchronousFuture(null);
  }

//end of file
}
