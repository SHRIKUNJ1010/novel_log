/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:flutter/cupertino.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';

class MyAppRouterInformationParser extends RouteInformationParser<List<PageConfiguration>> {
  @override
  Future<List<PageConfiguration>> parseRouteInformation(RouteInformation routeInformation) async {
    final Uri uri = Uri.parse(routeInformation.location!);
    List<PageConfiguration> tempConfig = [];
    bool show404 = false;
    switch (uri.pathSegments[0]) {
      case splashScreenRoute:
        tempConfig.add(PageConfigList.getSplashScreen());
        break;
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
        tempConfig.add(PageConfigList.getLoginScreen());
        tempConfig.add(PageConfigList.getForgetPasswordScreen());
        break;
      case drawerScreenRoute:
        tempConfig.add(PageConfigList.getDrawerScreen());
        switch (uri.pathSegments[1]) {
          case yourNovelListScreenRoute:
            drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getYourNovelListScreen(uri.pathSegments[2]));
            break;
          case novelWishListScreenRoute:
            drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getNovelWishListScreen(uri.pathSegments[2]));
            break;
          case novelHiddenListScreenRoute:
            drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getNovelHiddenListScreen(uri.pathSegments[2]));
            break;
          case profileScreenRoute:
            drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getProfileScreen(uri.pathSegments[2]));
            break;
          case changePasswordScreenRoute:
            drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getChangePasswordScreen(uri.pathSegments[2]));
            break;
          case changeHiddenPinScreenRoute:
            drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getChangeHiddenPinScreen(uri.pathSegments[2]));
            break;
          default:
            show404 = true;
            break;
        }
        break;
      default:
        show404 = true;
        break;
    }
    if (show404) {
      return [PageConfigList.getSplashScreen()];
    } else {
      return tempConfig;
    }
  }

  @override
  RouteInformation? restoreRouteInformation(List<PageConfiguration> configuration) {
    String url = '/';

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
        switch (drawerStateProvider.selectedPageConfig.path) {
          case yourNovelListScreenRoute:
            url += "/$yourNovelListScreenRoute/${drawerStateProvider.selectedPageConfig.arguments}";
            break;
          case novelWishListScreenRoute:
            url += "/$novelWishListScreenRoute/${drawerStateProvider.selectedPageConfig.arguments}";
            break;
          case novelHiddenListScreenRoute:
            url += "/$novelHiddenListScreenRoute/${drawerStateProvider.selectedPageConfig.arguments}";
            break;
          case profileScreenRoute:
            url += "/$profileScreenRoute/${drawerStateProvider.selectedPageConfig.arguments}";
            break;
          case changePasswordScreenRoute:
            url += "/$changePasswordScreenRoute/${drawerStateProvider.selectedPageConfig.arguments}";
            break;
          case changeHiddenPinScreenRoute:
            url += "/$changeHiddenPinScreenRoute/${drawerStateProvider.selectedPageConfig.arguments}";
            break;
        }
        break;
      default:
        return const RouteInformation(location: '');
    }

    return RouteInformation(location: url);
  }

//end of file
}
