/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/screens/app_drawer_screens/drawer_screen.dart';
import 'package:novel_log/screens/create_edit_screens/create_novel_hidden_list_item_screen.dart';
import 'package:novel_log/screens/create_edit_screens/create_novel_list_item_screen.dart';
import 'package:novel_log/screens/create_edit_screens/create_novel_wish_list_item_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/forget_password_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/login_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/sign_up_screen.dart';
import 'package:novel_log/screens/splash_screen.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';
import 'package:novel_log/utility/transition_list.dart';
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
            TransitionList.createPage(child, pageConfiguration),
          );
          break;
        case TransitionType.fadeTransition:
          pages.insert(
            index,
            TransitionList.createFadePage(child, pageConfiguration),
          );
          break;
        case TransitionType.slideDownTransition:
          pages.insert(
            index,
            TransitionList.createSlidePage(child, pageConfiguration),
          );
          break;
      }
    } else {
      switch (transitionType) {
        case TransitionType.defaultTransition:
          pages.add(
            TransitionList.createPage(child, pageConfiguration),
          );
          break;
        case TransitionType.fadeTransition:
          pages.add(
            TransitionList.createFadePage(child, pageConfiguration),
          );
          break;
        case TransitionType.slideDownTransition:
          pages.add(
            TransitionList.createSlidePage(child, pageConfiguration),
          );
          break;
      }
    }
  }

  void addCommonPage({
    int? index,
    required PageConfiguration pageConfig,
    TransitionType transitionType = TransitionType.defaultTransition,
  }) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addCommonPage(
          index: index,
          child: const SplashScreen(),
          pageConfiguration: pageConfig,
          transitionType: transitionType,
        );
        break;
      case loginScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const LoginScreen(),
        );
        break;
      case signUpScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const SignUpScreen(),
        );
        break;
      case drawerScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const DrawerScreen(),
        );
        break;
      case createNovelListItemScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const CreateNovelListItemScreen(),
        );
        break;
      case createNovelWishListItemScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const CreateNovelWishListItemScreen(),
        );
        break;
      case createNovelHiddenListItemScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const CreateNovelHiddenListItemScreen(),
        );
        break;
      case forgetPasswordScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const ForgetPasswordScreen(),
        );
        break;
      default:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const SplashScreen(),
        );
        break;
    }
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
    return Future.value(false);
  }

  bool _onPopPage(Route<dynamic> route, result) {
    Utility.printLog('on pop page called --------------------------------------------------');
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pageStateProvider.pop();
      return true;
    } else {
      return false;
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
          addCommonPage(index: i, pageConfig: pageStateProvider.config[i], transitionType: pageStateProvider.transitionList[i]);
        }
      } else {
        addCommonPage(pageConfig: pageStateProvider.config[i], transitionType: pageStateProvider.transitionList[i]);
      }
    }
    if (pageStateProvider.config.isEmpty) {
      Utility.printLog('splash screen added ------------------------------------------');
      addCommonPage(pageConfig: PageConfigList.getSplashScreen());
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
