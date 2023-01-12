/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:novel_log/models/page_config.dart';
import 'package:novel_log/utility/page_routes.dart';

class PageConfigList {
  static PageConfiguration getSplashScreen() {
    return PageConfiguration(
      key: 'splash_screen',
      path: splashScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getLoginScreen() {
    return PageConfiguration(
      key: 'login_screen',
      path: loginScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getSignUpScreen() {
    return PageConfiguration(
      key: 'sign_up_screen',
      path: signUpScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getHomeScreen() {
    return PageConfiguration(
      key: 'home_screen',
      path: homeScreenRoute,
      arguments: null,
    );
  }
}
