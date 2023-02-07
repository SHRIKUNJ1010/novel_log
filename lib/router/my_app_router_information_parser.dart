/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/cupertino.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';
import 'package:novel_log/utility/utility.dart';

class MyAppRouterInformationParser extends RouteInformationParser<List<PageConfiguration>> {
  @override
  Future<List<PageConfiguration>> parseRouteInformation(RouteInformation routeInformation) async {
    Utility.printLog('parseRouteInformation -----------------------------------------------');
    final Uri uri = Uri.parse(routeInformation.location!);
    List<PageConfiguration> tempConfig = [];
    bool show404 = false;
    Utility.printLog('Url Path: ${uri.path}');
    if (uri.pathSegments.isNotEmpty) {
      switch (uri.pathSegments[0]) {
        case loginScreenRoute:
          tempConfig.add(PageConfigList.getLoginScreen());
          if (uri.pathSegments.length > 1) {
            switch (uri.pathSegments[1]) {
              case forgetPasswordScreenRoute:
                tempConfig.add(PageConfigList.getForgetPasswordScreen());
                break;
              default:
                show404 = true;
                break;
            }
          }
          break;
        case signUpScreenRoute:
          tempConfig.add(PageConfigList.getSignUpScreen());
          break;
        case forgetPasswordScreenRoute:
          tempConfig.add(PageConfigList.getForgetPasswordScreen());
          break;
        case drawerScreenRoute:
          tempConfig.add(PageConfigList.getDrawerScreen());
          switch (uri.pathSegments[1]) {
            case yourNovelListScreenRoute:
              drawerStateProvider.pushReplacement(PageConfigList.getYourNovelListScreen(uri.pathSegments[2]));
              break;
            case novelWishListScreenRoute:
              drawerStateProvider.pushReplacement(PageConfigList.getNovelWishListScreen(uri.pathSegments[2]));
              break;
            case novelHiddenListScreenRoute:
              drawerStateProvider.pushReplacement(PageConfigList.getNovelHiddenListScreen(uri.pathSegments[2]));
              break;
            case profileScreenRoute:
              drawerStateProvider.pushReplacement(PageConfigList.getProfileScreen(uri.pathSegments[2]));
              break;
            case changePasswordScreenRoute:
              drawerStateProvider.pushReplacement(PageConfigList.getChangePasswordScreen(uri.pathSegments[2]));
              break;
            case changeHiddenPinScreenRoute:
              drawerStateProvider.pushReplacement(PageConfigList.getChangeHiddenPinScreen(uri.pathSegments[2]));
              break;
            default:
              show404 = true;
              break;
          }
          break;
        case createNovelListItemScreenRoute:
          tempConfig.add(PageConfigList.getCreateNovelListItemScreen(uri.pathSegments[1]));
          break;
        case createNovelWishListItemScreenRoute:
          tempConfig.add(PageConfigList.getCreateNovelWishListItemScreen(uri.pathSegments[1]));
          break;
        case createNovelHiddenListItemScreenRoute:
          tempConfig.add(PageConfigList.getCreateNovelHiddenListItemScreen(uri.pathSegments[1]));
          break;
        default:
          show404 = true;
          break;
      }
    }
    if (show404) {
      return [PageConfigList.getSplashScreen()];
    } else {
      pageStateProvider.addAllPages(tempConfig);
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
          url += '$createNovelListItemScreenRoute/${configuration[configuration.length - 1].arguments}';
          break;
        case createNovelWishListItemScreenRoute:
          url += '$createNovelWishListItemScreenRoute/${configuration[configuration.length - 1].arguments}';
          break;
        case createNovelHiddenListItemScreenRoute:
          url += '$createNovelHiddenListItemScreenRoute/${configuration[configuration.length - 1].arguments}';
          break;
        default:
          return const RouteInformation(location: '/');
      }
    }
    return RouteInformation(location: url);
  }

//end of file
}
