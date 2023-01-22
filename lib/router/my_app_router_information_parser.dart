/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/cupertino.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';

class MyAppRouterInformationParser
    extends RouteInformationParser<List<PageConfiguration>> {
  @override
  Future<List<PageConfiguration>> parseRouteInformation(
      RouteInformation routeInformation) async {
    final Uri uri = Uri.parse(routeInformation.location!);
    List<PageConfiguration> tempConfig = [];
    bool show404 = false;
    int i = 0;
    while (i < uri.pathSegments.length) {
      switch (uri.pathSegments[i]) {
        case splashScreenRoute:
          tempConfig.add(PageConfigList.getSplashScreen());
          i++;
          break;
        case loginScreenRoute:
          tempConfig.add(PageConfigList.getLoginScreen());
          i++;
          break;
        case signUpScreenRoute:
          tempConfig.add(PageConfigList.getSignUpScreen());
          i++;
          break;
        case homeScreenRoute:
          tempConfig.add(PageConfigList.getHomeScreen());
          i++;
          break;
        case forgetPasswordScreenRoute:
          tempConfig.add(PageConfigList.getForgetPasswordScreen());
          i++;
          break;
        default:
          show404 = true;
          break;
      }
      if (show404) break;
    }
    if (show404) {
      return [PageConfigList.getSplashScreen()];
    } else {
      return tempConfig;
    }
  }

  @override
  RouteInformation? restoreRouteInformation(
      List<PageConfiguration> configuration) {
    String url = '/';
    for (int i = 0; i < configuration.length; i++) {
      if (i == 0) {
        switch (configuration[i].path) {
          case splashScreenRoute:
            url += splashScreenRoute;
            break;
          case loginScreenRoute:
            url += loginScreenRoute;
            break;
          case signUpScreenRoute:
            url += signUpScreenRoute;
            break;
          case homeScreenRoute:
            url += homeScreenRoute;
            break;
          case forgetPasswordScreenRoute:
            url += forgetPasswordScreenRoute;
            break;
          default:
            return const RouteInformation(location: '');
        }
      } else {
        switch (configuration[i].path) {
          case splashScreenRoute:
            url += splashScreenRoute;
            break;
          case loginScreenRoute:
            url += '/$loginScreenRoute';
            break;
          case signUpScreenRoute:
            url += '/$signUpScreenRoute';
            break;
          case homeScreenRoute:
            url += '/$homeScreenRoute';
            break;
          case forgetPasswordScreenRoute:
            url += '/$forgetPasswordScreenRoute';
            break;
          default:
            return const RouteInformation(location: '');
        }
      }
    }
    return RouteInformation(location: url);
  }

//end of file
}
