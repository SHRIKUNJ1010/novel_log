/*
* Created by Shrikunj Patel on 2/9/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/screens/app_drawer_screens/change_hidden_pin_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/change_password_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/drawer_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/enter_pin_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/novel_hidden_list_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/novel_wish_list_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/profile_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/your_novel_list_screen.dart';
import 'package:novel_log/screens/create_edit_screens/create_novel_hidden_list_item_screen.dart';
import 'package:novel_log/screens/create_edit_screens/create_novel_list_item_screen.dart';
import 'package:novel_log/screens/create_edit_screens/create_novel_wish_list_item_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/forget_password_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/login_screen.dart';
import 'package:novel_log/screens/sign_up_sign_in_flow_screens/sign_up_screen.dart';
import 'package:novel_log/screens/splash_screen.dart';
import 'package:novel_log/utility/page_and_transition_services/page_routes.dart';

class PageConfigToWidget {
  static Widget getWidget(PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        return const SplashScreen();
      case loginScreenRoute:
        return const LoginScreen();
      case signUpScreenRoute:
        return const SignUpScreen();
      case forgetPasswordScreenRoute:
        return const ForgetPasswordScreen();
      case drawerScreenRoute:
        return const DrawerScreen();
      case createNovelListItemScreenRoute:
      case editNovelListItemScreenRoute:
        return CreateNovelListItemScreen(
          userId: (pageConfig.arguments as Map)['user_id'],
          novelId: (pageConfig.arguments as Map)['novel_id'],
        );
      case createNovelWishListItemScreenRoute:
      case editNovelWishListItemScreenRoute:
        return CreateNovelWishListItemScreen(
          userId: (pageConfig.arguments as Map)['user_id'],
          novelId: (pageConfig.arguments as Map)['novel_id'],
        );
      case createNovelHiddenListItemScreenRoute:
      case editNovelHiddenListItemScreenRoute:
        return CreateNovelHiddenListItemScreen(
          userId: (pageConfig.arguments as Map)['user_id'],
          novelId: (pageConfig.arguments as Map)['novel_id'],
        );
      case yourNovelListScreenRoute:
        return YourNovelListScreen(
          userId: pageConfig.arguments as String,
        );
      case novelWishListScreenRoute:
        return NovelWishListScreen(
          userId: pageConfig.arguments as String,
        );
      case novelHiddenListScreenRoute:
        return NovelHiddenListScreen(
          userId: pageConfig.arguments as String,
        );
      case enterPinScreenRoute:
        return const EnterPinScreen();
      case profileScreenRoute:
        return ProfileScreen(
          userId: pageConfig.arguments as String,
        );
      case changePasswordScreenRoute:
        return ChangePasswordScreen(
          userId: pageConfig.arguments as String,
        );
      case changeHiddenPinScreenRoute:
        return ChangeHiddenPinScreen(
          userId: pageConfig.arguments as String,
        );
      default:
        return const SplashScreen();
    }
  }
}
