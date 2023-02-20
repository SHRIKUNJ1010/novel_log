/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/page_and_transition_services/page_routes.dart';

class PageConfigList {
  static PageConfiguration getSplashScreen() {
    return PageConfiguration(
      key: 'splash_screen${DateTime.now().microsecondsSinceEpoch}',
      path: splashScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getLoginScreen() {
    return PageConfiguration(
      key: 'login_screen${DateTime.now().microsecondsSinceEpoch}',
      path: loginScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getSignUpScreen() {
    return PageConfiguration(
      key: 'sign_up_screen${DateTime.now().microsecondsSinceEpoch}',
      path: signUpScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getForgetPasswordScreen() {
    return PageConfiguration(
      key: 'forget_password_screen${DateTime.now().microsecondsSinceEpoch}',
      path: forgetPasswordScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getDrawerScreen() {
    return PageConfiguration(
      key: 'drawer_screen${DateTime.now().microsecondsSinceEpoch}',
      path: drawerScreenRoute,
      arguments: null,
    );
  }

  static PageConfiguration getYourNovelListScreen(String userId) {
    return PageConfiguration(
      key: 'your_novel_list_screen${DateTime.now().microsecondsSinceEpoch}',
      path: yourNovelListScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getProfileScreen(String userId) {
    return PageConfiguration(
      key: 'profile_screen${DateTime.now().microsecondsSinceEpoch}',
      path: profileScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getNovelWishListScreen(String userId) {
    return PageConfiguration(
      key: 'novel_wish_list_screen${DateTime.now().microsecondsSinceEpoch}',
      path: novelWishListScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getNovelHiddenListScreen(String userId) {
    return PageConfiguration(
      key: 'novel_hidden_list_screen${DateTime.now().microsecondsSinceEpoch}',
      path: novelHiddenListScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getEnterPinScreen(String userId) {
    return PageConfiguration(
      key: 'enter_hidden_pin_screen${DateTime.now().microsecondsSinceEpoch}',
      path: enterPinScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getChangePasswordScreen(String userId) {
    return PageConfiguration(
      key: 'change_password_screen${DateTime.now().microsecondsSinceEpoch}',
      path: changePasswordScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getChangeHiddenPinScreen(String userId) {
    return PageConfiguration(
      key: 'change_hidden_pin_screen${DateTime.now().microsecondsSinceEpoch}',
      path: changeHiddenPinScreenRoute,
      arguments: userId,
    );
  }

  static PageConfiguration getCreateNovelListItemScreen(String? userId, [String? novelId]) {
    return PageConfiguration(
      key: 'create_novel_list_item_screen${DateTime.now().microsecondsSinceEpoch}',
      path: novelId != null ? editNovelListItemScreenRoute : createNovelListItemScreenRoute,
      arguments: {
        'user_id': userId,
        'novel_id': novelId,
      },
    );
  }

  static PageConfiguration getCreateNovelWishListItemScreen(String? userId, [String? novelId]) {
    return PageConfiguration(
      key: 'create_novel_wish_list_item_screen${DateTime.now().microsecondsSinceEpoch}',
      path: novelId != null ? editNovelWishListItemScreenRoute : createNovelWishListItemScreenRoute,
      arguments: {
        'user_id': userId,
        'novel_id': novelId,
      },
    );
  }

  static PageConfiguration getCreateNovelHiddenListItemScreen(String? userId, [String? novelId]) {
    return PageConfiguration(
      key: 'create_novel_hidden_list_item_screen${DateTime.now().microsecondsSinceEpoch}',
      path: novelId != null ? editNovelHiddenListItemScreenRoute : createNovelHiddenListItemScreenRoute,
      arguments: {
        'user_id': userId,
        'novel_id': novelId,
      },
    );
  }

//end of file
}
