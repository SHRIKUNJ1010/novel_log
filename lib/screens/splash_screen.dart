/*
* Created by Shrikunj Patel on 1/6/2023.
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/page_config_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  void manageHomeNavigation() async {
    if (isLoggedIn) {
      Timer(const Duration(milliseconds: 100), () {
        pageStateProvider.pushReplacement(PageConfigList.getHomeScreen());
      });
    } else {
      Timer(const Duration(milliseconds: 3000), () {
        isLoggedIn = true;
        pageStateProvider.pushReplacement(PageConfigList.getLoginScreen());
      });
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
}
