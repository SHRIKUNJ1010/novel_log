/*
* Created by Shrikunj Patel on 1/6/2023.
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/hidden_pin_controller.dart';
import 'package:novel_log/models/getx_controller_model/user_data_controller.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/firebase_services/firebase_auth_service.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  UserDataController userController = Get.put(UserDataController());
  HiddenPinController pinController = Get.put(HiddenPinController());

  void manageHomeNavigation() async {
    var temp = '1,2,3,4';
    var tempString = 'genre1,genre2,genre3,genre4';
    Utility.printLog(Utility.commaSeparatedStringToList<int>(temp));
    Utility.printLog(Utility.commaSeparatedStringToList<String>(tempString));
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = await FirebaseAuthService.isAlreadyLoggedIn();
    Preference.setIsUserLoggedIn(isLoggedIn);
    pinController.updateValue(false);
    if (isLoggedIn) {
      Timer(const Duration(milliseconds: 100), () async {
        String tempUserId = Preference.getUserId();
        if (tempUserId != '') {
          userController.getUserData(tempUserId);
          pageStateProvider.pushReplacement(PageConfigList.getDrawerScreen(), TransitionType.foldTransition);
          drawerStateProvider.pushReplacement(PageConfigList.getYourNovelListScreen(tempUserId), TransitionType.foldTransition);
        } else {
          pageStateProvider.pushReplacement(PageConfigList.getLoginScreen(), TransitionType.foldTransition);
        }
      });
    } else {
      Timer(
        const Duration(milliseconds: 3000),
        () {
          pageStateProvider.pushReplacement(PageConfigList.getLoginScreen(), TransitionType.foldTransition);
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
