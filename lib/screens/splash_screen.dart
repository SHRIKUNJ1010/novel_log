/*
* Created by Shrikunj Patel on 1/6/2023.
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/data_models/user_profile_model.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/firebase_services/database_services/user_services.dart';
import 'package:novel_log/utility/firebase_services/firebase_auth_service.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  void manageHomeNavigation() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = await FirebaseAuthService.isAlreadyLoggedIn();
    Preference.setIsUserLoggedIn(isLoggedIn);
    if (isLoggedIn) {
      Timer(const Duration(milliseconds: 100), () async {
        String tempUserId = Preference.getUserId();
        if (tempUserId != '') {
          drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getYourNovelListScreen(tempUserId));
          UserProfileModel tempUser = await UserServices.getUserData(tempUserId);
          Utility.printLog(tempUser.toJson());
          pageStateProvider.pushReplacement(PageConfigList.getDrawerScreen(), TransitionType.slideDownTransition);
        } else {
          pageStateProvider.pushReplacement(PageConfigList.getLoginScreen(), TransitionType.slideDownTransition);
        }
      });
    } else {
      Timer(
        const Duration(milliseconds: 3000),
        () {
          pageStateProvider.pushReplacement(PageConfigList.getLoginScreen(), TransitionType.slideDownTransition);
        },
      );
    }
  }

  @override
  void initState() {
    manageHomeNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appPrimaryColor,
      alignment: Alignment.center,
      child: Image.asset(nlIconImage),
    );
  }

//end of file
}
