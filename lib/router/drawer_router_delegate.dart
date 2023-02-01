/*
* Created by Shrikunj Patel on 1/24/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/router_models/fade_page.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/screens/app_drawer_screens/change_hidden_pin_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/change_password_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/novel_hidden_list_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/novel_wish_list_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/profile_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/your_novel_list_screen.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';
import 'package:novel_log/utility/preference.dart';

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

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
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
      case yourNovelListScreenRoute:
        _addPageAtIndex(
          index,
          YourNovelListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case novelWishListScreenRoute:
        _addPageAtIndex(
          index,
          NovelWishListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case novelHiddenListScreenRoute:
        _addPageAtIndex(
          index,
          NovelHiddenListScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case profileScreenRoute:
        _addPageAtIndex(
          index,
          ProfileScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case changePasswordScreenRoute:
        _addPageAtIndex(
          index,
          ChangePasswordScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      case changeHiddenPinScreenRoute:
        _addPageAtIndex(
          index,
          ChangeHiddenPinScreen(
            userId: pageConfig.arguments as String,
          ),
          pageConfig,
        );
        break;
      default:
        _addPageAtIndex(
          index,
          YourNovelListScreen(
            userId: Preference.getUserId(),
          ),
          pageConfig,
        );
        break;
    }
  }

  void addPage(PageConfiguration pageConfig) {
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
  }

  bool canPop() {
    return true;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      pageStateProvider.pop();
      return Future.value(true);
    }
    return Future.value(false);
  }

  List<Page> buildPages() {
    pages = [];
    addPage(drawerStateProvider.selectedPageConfig);
    return List.of(pages);
  }

  @override
  List<PageConfiguration>? get currentConfiguration => [drawerStateProvider.selectedPageConfig];

  @override
  Future<void> setNewRoutePath(List<PageConfiguration> configuration) {
    drawerStateProvider.changeCurrentSelectedPage(configuration[0]);
    return SynchronousFuture(null);
  }

  @override
  Future<void> setInitialRoutePath(List<PageConfiguration> configuration) {
    drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getYourNovelListScreen(Preference.getUserId()));
    return SynchronousFuture(null);
  }

//end of file
}
