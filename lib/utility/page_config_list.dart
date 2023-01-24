/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:novel_log/models/router_models/page_config.dart';
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

  static PageConfiguration getForgetPasswordScreen() {
    return PageConfiguration(
      key: 'forget_password_screen',
      path: forgetPasswordScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getDrawerScreen() {
    return PageConfiguration(
      key: 'drawer_screen',
      path: drawerScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getYourNovelListScreen(String userId) {
    return PageConfiguration(
      key: 'your_novel_list_screen',
      path: yourNovelListScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getProfileScreen(String userId) {
    return PageConfiguration(
      key: 'profile_screen',
      path: profileScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getNovelWishListScreen(String userId) {
    return PageConfiguration(
      key: 'novel_wish_list_screen',
      path: novelWishListScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getNovelHiddenListScreen(String userId) {
    return PageConfiguration(
      key: 'novel_hidden_list_screen',
      path: novelHiddenListScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getChangePasswordScreen(String userId) {
    return PageConfiguration(
      key: 'change_password_screen',
      path: changePasswordScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getChangeHiddenPinScreen(String userId) {
    return PageConfiguration(
      key: 'change_hidden_pin_screen',
      path: changeHiddenPinScreenRoute,
      arguments: userId,
    );
  }

//end of file
}
