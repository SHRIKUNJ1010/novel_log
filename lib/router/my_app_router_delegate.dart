/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/router_models/fade_page.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/screens/app_drawer_screens/drawer_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/forget_password_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/login_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/sign_up_screen.dart';
import 'package:novel_log/screens/splash_screen.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';

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

  //create material for page
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

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    pages.add(
      _createPage(child, pageConfig),
    );
  }

  void _addPageAtIndex(int index, Widget child, PageConfiguration pageConfig) {
    pages.insert(
      index,
      _createPage(child, pageConfig),
    );
  }

  void addPageAtIndex(int index, PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addPageAtIndex(
          index,
          const SplashScreen(),
          pageConfig,
        );
        break;
      case loginScreenRoute:
        _addPageAtIndex(
          index,
          const LoginScreen(),
          pageConfig,
        );
        break;
      case signUpScreenRoute:
        _addPageAtIndex(
          index,
          const SignUpScreen(),
          pageConfig,
        );
        break;
      case drawerScreenRoute:
        _addPageAtIndex(
          index,
          const DrawerScreen(),
          pageConfig,
        );
        break;
      case forgetPasswordScreenRoute:
        _addPageAtIndex(
          index,
          const ForgetPasswordScreen(),
          pageConfig,
        );
        break;
      default:
        _addPageAtIndex(
          index,
          const SplashScreen(),
          pageConfig,
        );
        break;
    }
  }

  void addFadePageAtIndex(int index, PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addFadePageAtIndex(
          index,
          const SplashScreen(),
          pageConfig,
        );
        break;
      case loginScreenRoute:
        _addFadePageAtIndex(
          index,
          const LoginScreen(),
          pageConfig,
        );
        break;
      case signUpScreenRoute:
        _addFadePageAtIndex(
          index,
          const SignUpScreen(),
          pageConfig,
        );
        break;
      case drawerScreenRoute:
        _addFadePageAtIndex(
          index,
          const DrawerScreen(),
          pageConfig,
        );
        break;
      case forgetPasswordScreenRoute:
        _addFadePageAtIndex(
          index,
          const ForgetPasswordScreen(),
          pageConfig,
        );
        break;
      default:
        _addFadePageAtIndex(
          index,
          const SplashScreen(),
          pageConfig,
        );
        break;
    }
  }

  void addPage(PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addPageData(
          const SplashScreen(),
          pageConfig,
        );
        break;
      case loginScreenRoute:
        _addPageData(
          const LoginScreen(),
          pageConfig,
        );
        break;
      case signUpScreenRoute:
        _addPageData(
          const SignUpScreen(),
          pageConfig,
        );
        break;
      case drawerScreenRoute:
        _addPageData(
          const DrawerScreen(),
          pageConfig,
        );
        break;
      case forgetPasswordScreenRoute:
        _addPageData(
          const ForgetPasswordScreen(),
          pageConfig,
        );
        break;
      default:
        _addPageData(
          const SplashScreen(),
          pageConfig,
        );
        break;
    }
  }

  void addFadePage(PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addFadePage(
          const SplashScreen(),
          pageConfig,
        );
        break;
      case loginScreenRoute:
        _addFadePage(
          const LoginScreen(),
          pageConfig,
        );
        break;
      case signUpScreenRoute:
        _addFadePage(
          const SignUpScreen(),
          pageConfig,
        );
        break;
      case drawerScreenRoute:
        _addFadePage(
          const DrawerScreen(),
          pageConfig,
        );
        break;
      case forgetPasswordScreenRoute:
        _addFadePage(
          const ForgetPasswordScreen(),
          pageConfig,
        );
        break;
      default:
        _addFadePage(
          const SplashScreen(),
          pageConfig,
        );
        break;
    }
  }

  bool canPop() {
    return pageStateProvider.config.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      pageStateProvider.pop();
      return Future.value(true);
    }
    return Future.value(false);
  }

  bool _onPopPage(Route<dynamic> route, result) {
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
    //pages = [];
    if (pageStateProvider.config.length < pages.length) {
      pages = [];
    }
    for (int i = 0; i < pageStateProvider.config.length; i++) {
      if (i < pages.length) {
        if (pages[i].name == pageStateProvider.config[i].path) {
          //do nothing
        } else {
          pages.removeAt(i);
          addPageAtIndex(i, pageStateProvider.config[i]);
        }
      } else {
        addPage(pageStateProvider.config[i]);
      }
    }
    if (pageStateProvider.config.isEmpty) {
      addPage(PageConfiguration(key: '', path: ''));
    }
    return List.of(pages);
  }

  @override
  List<PageConfiguration>? get currentConfiguration => pageStateProvider.config;

  @override
  Future<void> setNewRoutePath(configuration) {
    pageStateProvider.addAllPages(configuration);
    return SynchronousFuture(null);
  }

  @override
  Future<void> setInitialRoutePath(configuration) {
    pageStateProvider.addAllPages([PageConfigList.getSplashScreen()]);
    return SynchronousFuture(null);
  }

//end of file
}
