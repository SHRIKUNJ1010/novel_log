/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/hidden_pin_controller.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/page_and_transition_services/page_routes.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';

class MyAppRouterInformationParser extends RouteInformationParser<List<PageConfiguration>> {
  @override
  Future<List<PageConfiguration>> parseRouteInformation(RouteInformation routeInformation) async {
    Utility.printLog('parseRouteInformation -----------------------------------------------');
    final Uri uri = Uri.parse(routeInformation.location!);
    final List<String> urlSegments = uri.pathSegments;
    Utility.printLog('url path segments: $urlSegments');
    List<PageConfiguration> tempConfig = [];
    List<PageConfiguration> drawerConfig = [];

    bool show404 = false;
    Utility.printLog('Url Path: ${uri.path}');
    Utility.printLog('Is User Logged In : ${Preference.getIsUserLoggedIn()}');
    if (urlSegments.isNotEmpty) {
      switch (urlSegments[0]) {
        case loginScreenRoute:
          if (Preference.getIsUserLoggedIn()) {
            tempConfig.add(PageConfigList.getDrawerScreen());
            drawerConfig.add(PageConfigList.getYourNovelListScreen(Preference.getUserId() != '' ? Preference.getUserId() : '123'));
          } else {
            tempConfig.add(PageConfigList.getLoginScreen());
          }
          break;
        case signUpScreenRoute:
          if (Preference.getIsUserLoggedIn()) {
            tempConfig.add(PageConfigList.getDrawerScreen());
            drawerConfig.add(PageConfigList.getYourNovelListScreen(Preference.getUserId() != '' ? Preference.getUserId() : '123'));
          } else {
            tempConfig.add(PageConfigList.getSignUpScreen());
          }
          break;
        case forgetPasswordScreenRoute:
          if (Preference.getIsUserLoggedIn()) {
            tempConfig.add(PageConfigList.getDrawerScreen());
            drawerConfig.add(PageConfigList.getYourNovelListScreen(Preference.getUserId() != '' ? Preference.getUserId() : '123'));
          } else {
            tempConfig.add(PageConfigList.getForgetPasswordScreen());
          }
          break;
        case createNovelListItemScreenRoute:
          if (Preference.getIsUserLoggedIn()) {
            final data = uri.queryParameters;
            tempConfig.add(PageConfigList.getCreateNovelListItemScreen(data['user_id'], data['novel_id']));
          } else {
            tempConfig.add(PageConfigList.getLoginScreen());
          }
          break;
        case createNovelWishListItemScreenRoute:
          if (Preference.getIsUserLoggedIn()) {
            final data = uri.queryParameters;
            tempConfig.add(PageConfigList.getCreateNovelWishListItemScreen(data['user_id'], data['novel_id']));
          } else {
            tempConfig.add(PageConfigList.getLoginScreen());
          }
          break;
        case createNovelHiddenListItemScreenRoute:
          if (Preference.getIsUserLoggedIn()) {
            final data = uri.queryParameters;
            tempConfig.add(PageConfigList.getCreateNovelHiddenListItemScreen(data['user_id'], data['novel_id']));
          } else {
            tempConfig.add(PageConfigList.getLoginScreen());
          }
          break;
        case drawerScreenRoute:
          HiddenPinController pinController = Get.put(HiddenPinController());
          if (Preference.getIsUserLoggedIn()) {
            tempConfig.add(PageConfigList.getDrawerScreen());
            switch (urlSegments.length > 1 ? urlSegments[1] : yourNovelListScreenRoute) {
              case yourNovelListScreenRoute:
                drawerConfig.add(PageConfigList.getYourNovelListScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                break;
              case novelWishListScreenRoute:
                drawerConfig.add(PageConfigList.getNovelWishListScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                break;
              case novelHiddenListScreenRoute:
                if (pinController.hasEnteredPassword) {
                  drawerConfig.add(PageConfigList.getNovelHiddenListScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                } else {
                  drawerConfig.add(PageConfigList.getEnterPinScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                }
                break;
              case enterPinScreenRoute:
                if (pinController.hasEnteredPassword) {
                  drawerConfig.add(PageConfigList.getNovelHiddenListScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                } else {
                  drawerConfig.add(PageConfigList.getEnterPinScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                }
                break;
              case profileScreenRoute:
                drawerConfig.add(PageConfigList.getProfileScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                break;
              case changePasswordScreenRoute:
                drawerConfig.add(PageConfigList.getChangePasswordScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                break;
              case changeHiddenPinScreenRoute:
                drawerConfig.add(PageConfigList.getChangeHiddenPinScreen(urlSegments.length > 2 ? urlSegments[2] : '123'));
                break;
              default:
                show404 = true;
                break;
            }
          } else {
            tempConfig.add(PageConfigList.getLoginScreen());
          }
          break;
        default:
          show404 = true;
          break;
      }
    }
    if (show404) {
      return [PageConfigList.getSplashScreen()];
    } else {
      if (pageStateProvider.config.isNotEmpty) {
        pageStateProvider.addAllPages(tempConfig);
      } else {
        pageStateProvider.addAllPages([PageConfigList.getSplashScreen()]);
      }
      if (drawerConfig.isNotEmpty) {
        drawerStateProvider.addAllPages(drawerConfig);
      }
      return tempConfig;
    }
  }

  @override
  RouteInformation? restoreRouteInformation(List<PageConfiguration> configuration) {
    Utility.printLog('restoreRouteInformation -------------------------------------------------');
    Utility.printLog(configuration.map((e) => e.path).toList());
    String url = '/';
    if (configuration.isNotEmpty) {
      switch (configuration[configuration.length - 1].path) {
        case splashScreenRoute:
          url += splashScreenRoute;
          break;
        case loginScreenRoute:
          url += loginScreenRoute;
          break;
        case signUpScreenRoute:
          url += signUpScreenRoute;
          break;
        case forgetPasswordScreenRoute:
          if (configuration.length > 1) {
            url += '$loginScreenRoute/$forgetPasswordScreenRoute';
          } else {
            url += forgetPasswordScreenRoute;
          }
          break;
        case drawerScreenRoute:
          url += drawerScreenRoute;
          final int tempIndex = drawerStateProvider.config.length - 1;
          if (tempIndex != -1) {
            switch (drawerStateProvider.config[tempIndex].path) {
              case yourNovelListScreenRoute:
                url += "/$yourNovelListScreenRoute/${drawerStateProvider.config[tempIndex].arguments}";
                break;
              case novelWishListScreenRoute:
                url += "/$novelWishListScreenRoute/${drawerStateProvider.config[tempIndex].arguments}";
                break;
              case novelHiddenListScreenRoute:
                url += "/$novelHiddenListScreenRoute/${drawerStateProvider.config[tempIndex].arguments}";
                break;
              case enterPinScreenRoute:
                url += "/$enterPinScreenRoute/${drawerStateProvider.config[tempIndex].arguments}";
                break;
              case profileScreenRoute:
                url += "/$profileScreenRoute/${drawerStateProvider.config[tempIndex].arguments}";
                break;
              case changePasswordScreenRoute:
                url += "/$changePasswordScreenRoute/${drawerStateProvider.config[tempIndex].arguments}";
                break;
              case changeHiddenPinScreenRoute:
                url += "/$changeHiddenPinScreenRoute/${drawerStateProvider.config[tempIndex].arguments}";
                break;
            }
          }
          break;
        case createNovelListItemScreenRoute:
          url += '$createNovelListItemScreenRoute?user_id=${(configuration[configuration.length - 1].arguments as Map)['user_id']}';
          break;
        case createNovelWishListItemScreenRoute:
          url += '$createNovelWishListItemScreenRoute?user_id=${(configuration[configuration.length - 1].arguments as Map)['user_id']}';
          break;
        case createNovelHiddenListItemScreenRoute:
          url += '$createNovelHiddenListItemScreenRoute?user_id=${(configuration[configuration.length - 1].arguments as Map)['user_id']}';
          break;
        case editNovelListItemScreenRoute:
          url +=
              '$editNovelListItemScreenRoute?user_id=${(configuration[configuration.length - 1].arguments as Map)['user_id']}&novel_id=${(configuration[configuration.length - 1].arguments as Map)['novel_id']}';
          break;
        case editNovelWishListItemScreenRoute:
          url +=
              '$editNovelWishListItemScreenRoute?user_id=${(configuration[configuration.length - 1].arguments as Map)['user_id']}&novel_id=${(configuration[configuration.length - 1].arguments as Map)['novel_id']}';
          break;
        case editNovelHiddenListItemScreenRoute:
          url +=
              '$editNovelHiddenListItemScreenRoute?user_id=${(configuration[configuration.length - 1].arguments as Map)['user_id']}&novel_id=${(configuration[configuration.length - 1].arguments as Map)['novel_id']}';
          break;
        default:
          return const RouteInformation(location: '/');
      }
    }
    return RouteInformation(location: url);
  }

//end of file
}
