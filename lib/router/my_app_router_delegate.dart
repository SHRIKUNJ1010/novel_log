/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/page_and_transition_services/transition_to_page.dart';
import 'package:novel_log/utility/utility.dart';

class MyAppRouterDelegate extends RouterDelegate<List<PageConfiguration>> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigateKey;

  MyAppRouterDelegate() : super() {
    pageStateProvider.addListener(notifyListeners);
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
    return pageStateProvider.config.length > 1;
  }

  @override
  Future<bool> popRoute() {
    Utility.printLog('pop route called ---------------------------------------------------');
    if (canPop()) {
      pageStateProvider.pop();
      return Future.value(true);
    }
    return confirmAppExit();
  }

  bool _onPopPage(Route<dynamic> route, result) {
    Utility.printLog('on pop page called --------------------------------------------------');
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    popRoute();
    return true;
  }

  Future<bool> confirmAppExit() async {
    final bool? isExit = await showDialog<bool>(
      context: navigateKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
    return isExit ?? true;
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
    Utility.printLog('build pages called -------------------------------------------------');
    Utility.printLog("app page config list : ${pageStateProvider.config.map((e) => e.path).toList()}");
    if (pageStateProvider.config.length < pages.length) {
      pages = [];
    }
    for (int i = 0; i < pageStateProvider.config.length; i++) {
      if (i < pages.length) {
        if (pages[i].name == pageStateProvider.config[i].path) {
          //do nothing
        } else {
          pages.removeAt(i);
          addCommonPage(
            index: i,
            pageConfiguration: pageStateProvider.config[i],
            transitionType: pageStateProvider.transitionList[i],
          );
        }
      } else {
        addCommonPage(
          pageConfiguration: pageStateProvider.config[i],
          transitionType: pageStateProvider.transitionList[i],
        );
      }
    }
    if (pageStateProvider.config.isEmpty) {
      Utility.printLog('splash screen added ------------------------------------------');
      addCommonPage(
        pageConfiguration: PageConfigList.getSplashScreen(),
      );
    }
    Utility.printLog("pages list : ${pages.map((e) => e.name).toList()}");
    return List.of(pages);
  }

  @override
  List<PageConfiguration>? get currentConfiguration => pageStateProvider.config;

  @override
  Future<void> setNewRoutePath(configuration) {
    Utility.printLog('setNewRoutePath -----------------------------------------------');
    Utility.printLog("set new route path page config list : ${configuration.map((e) => e.path).toList()}");
    if (configuration.isNotEmpty) {
      pageStateProvider.addAllPages(configuration);
    }
    return SynchronousFuture(null);
  }

  @override
  Future<void> setInitialRoutePath(configuration) {
    Utility.printLog('setInitialRoutePath --------------------------------');
    Utility.printLog("set initial route path for drawer page config list : ${configuration.map((e) => e.path).toList()}");
    if (configuration.isNotEmpty) {
      pageStateProvider.addAllPages(configuration);
    } else {
      pageStateProvider.addAllPages([PageConfigList.getSplashScreen()]);
    }
    return SynchronousFuture(null);
  }

//end of file
}
