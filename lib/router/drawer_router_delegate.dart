/*
* Created by Shrikunj Patel on 1/24/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/router_models/transition_pages/fade_page.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/models/router_models/transition_pages/slide_down_page.dart';
import 'package:novel_log/screens/app_drawer_screens/change_hidden_pin_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/change_password_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/novel_hidden_list_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/novel_wish_list_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/profile_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/your_novel_list_screen.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';

class DrawerRouterDelegate extends RouterDelegate<List<PageConfiguration>> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

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

  bool _onPopPage(Route<dynamic> route, result) {
    Utility.printLog('on pop page called for drawer --------------------------------------------------------');
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      drawerStateProvider.pop();
      return true;
    } else {
      return false;
    }
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  FadePage _createFadePage(Widget child, PageConfiguration pageConfig) {
    return FadePage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  SlideDownPage _createSlidePage(Widget child, PageConfiguration pageConfig) {
    return SlideDownPage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  void _addCommonPage({
    int? index,
    required Widget child,
    required PageConfiguration pageConfiguration,
    TransitionType transitionType = TransitionType.defaultTransition,
  }) {
    if (index != null) {
      switch (transitionType) {
        case TransitionType.defaultTransition:
          pages.insert(
            index,
            _createPage(child, pageConfiguration),
          );
          break;
        case TransitionType.fadeTransition:
          pages.insert(
            index,
            _createFadePage(child, pageConfiguration),
          );
          break;
        case TransitionType.slideDownTransition:
          pages.insert(
            index,
            _createSlidePage(child, pageConfiguration),
          );
          break;
      }
    } else {
      switch (transitionType) {
        case TransitionType.defaultTransition:
          pages.add(
            _createPage(child, pageConfiguration),
          );
          break;
        case TransitionType.fadeTransition:
          pages.add(
            _createFadePage(child, pageConfiguration),
          );
          break;
        case TransitionType.slideDownTransition:
          pages.add(
            _createSlidePage(child, pageConfiguration),
          );
          break;
      }
    }
  }

  /*void _addPageData(Widget child, PageConfiguration pageConfig) {
    pages.add(
      _createPage(child, pageConfig),
    );
  }

  void _addPageAtIndex(int index, Widget child, PageConfiguration pageConfig) {
    pages.insert(
      index,
      _createPage(child, pageConfig),
    );
  }*/

  void addCommonPage({int? index, required PageConfiguration pageConfig, TransitionType transitionType = TransitionType.defaultTransition}) {
    switch (pageConfig.path) {
      case yourNovelListScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: YourNovelListScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case novelWishListScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: NovelWishListScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case novelHiddenListScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: NovelHiddenListScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case profileScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: ProfileScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case changePasswordScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: ChangePasswordScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case changeHiddenPinScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: ChangeHiddenPinScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      default:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: YourNovelListScreen(
            userId: Preference.getUserId(),
          ),
        );
        break;
    }
  }

  /*void addPage(PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case yourNovelListScreenRoute:
        _addPageData(
          YourNovelListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case novelWishListScreenRoute:
        _addPageData(
          NovelWishListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case novelHiddenListScreenRoute:
        _addPageData(
          NovelHiddenListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case profileScreenRoute:
        _addPageData(
          ProfileScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case changePasswordScreenRoute:
        _addPageData(
          ChangePasswordScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case changeHiddenPinScreenRoute:
        _addPageData(
          ChangeHiddenPinScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      default:
        _addPageData(
          YourNovelListScreen(
            userId: Preference.getUserId(),
          ),
          pageConfig,
        );
        break;
    }
  }

  FadePage _createFadePage(Widget child, PageConfiguration pageConfig) {
    return FadePage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  void _addFadePage(Widget child, PageConfiguration pageConfig) {
    pages.add(
      _createFadePage(child, pageConfig),
    );
  }

  void _addFadePageAtIndex(int index, Widget child, PageConfiguration pageConfig) {
    pages.insert(
      index,
      _createFadePage(child, pageConfig),
    );
  }

  void addFadePageAtIndex(int index, PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case yourNovelListScreenRoute:
        _addFadePageAtIndex(
          index,
          YourNovelListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case novelWishListScreenRoute:
        _addFadePageAtIndex(
          index,
          NovelWishListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case novelHiddenListScreenRoute:
        _addFadePageAtIndex(
          index,
          NovelHiddenListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case profileScreenRoute:
        _addFadePageAtIndex(
          index,
          ProfileScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case changePasswordScreenRoute:
        _addFadePageAtIndex(
          index,
          ChangePasswordScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case changeHiddenPinScreenRoute:
        _addFadePageAtIndex(
          index,
          ChangeHiddenPinScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      default:
        _addFadePageAtIndex(
          index,
          YourNovelListScreen(
            userId: Preference.getUserId(),
          ),
          pageConfig,
        );
        break;
    }
  }

  void addFadePage(PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case yourNovelListScreenRoute:
        _addFadePage(
          YourNovelListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case novelWishListScreenRoute:
        _addFadePage(
          NovelWishListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case novelHiddenListScreenRoute:
        _addFadePage(
          NovelHiddenListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case profileScreenRoute:
        _addFadePage(
          ProfileScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case changePasswordScreenRoute:
        _addFadePage(
          ChangePasswordScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case changeHiddenPinScreenRoute:
        _addFadePage(
          ChangeHiddenPinScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      default:
        _addFadePage(
          YourNovelListScreen(
            userId: Preference.getUserId(),
          ),
          pageConfig,
        );
        break;
    }
  }*/

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

  List<Page> buildPages() {
    Utility.printLog('build pages called for drawer -------------------------------------------------');
    //pages = [];
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
          addCommonPage(index: i, pageConfig: drawerStateProvider.config[i], transitionType: drawerStateProvider.transitionList[i]);
        }
      } else {
        addCommonPage(pageConfig: drawerStateProvider.config[i], transitionType: drawerStateProvider.transitionList[i]);
      }
    }
    if (drawerStateProvider.config.isEmpty) {
      Utility.printLog('your novel screen added when empty config got ------------------------------------------');
      addCommonPage(pageConfig: PageConfigList.getYourNovelListScreen(Preference.getUserId()));
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
