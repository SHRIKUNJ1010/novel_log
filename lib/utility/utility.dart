/*
* Created by Shrikunj Patel on 1/6/2023.
*/

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/widgets/common_widgets/logout_alert_dialog.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Utility {
  //printing log when app is in debug mode
  static void printLog(var log) {
    if (kDebugMode) {
      debugPrint('$log');
    }
  }

  //validate email address by regular expression
  static bool validateEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  //checking if internet connection is available by lookup google.com
  static Future<bool> checkInterNetConnection() async {
    if (kIsWeb) {
      try {
        final result = await http.get(Uri.parse('www.google.com'));
        if (result.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Utility.printLog('connected');
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        Utility.printLog('not connected');
        return false;
      }
    }
  }

  //getting random color
  static Color getRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt());
  }

  //getting circular progress indicator when isLoading true
  static Widget getLoadingView({bool isLoading = true}) {
    return isLoading
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          )
        : const SizedBox();
  }

  static Widget noDataLoadedText() {
    return const Center(
      child: TextView(
        label: 'No Data loaded',
        color: mBlack,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      ),
    );
  }

  static TextStyle getRichTextStyle({
    color = mBlack,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    fontFamily = fontProxima,
    double letterSpacing = 0,
    TextDecoration? textDecoration = TextDecoration.none,
    Color decorationColor = Colors.transparent,
    double decorationThickness = 0,
    TextDecorationStyle textDecorationStyle = TextDecorationStyle.solid,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      decoration: textDecoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      decorationStyle: textDecorationStyle,
    );
  }

  //loading dialog widget used when showing that app is loading data
  static Future<void> showLoadingDialog(BuildContext context) async {
    double padding = MediaQuery.of(context).size.width / 4.2;
    return showDialog<void>(
      context: context,
      barrierDismissible: kDebugMode,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: WillPopScope(
            onWillPop: () async => kDebugMode,
            child: SimpleDialog(
              backgroundColor: Colors.white,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 30),
                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(appPrimaryColor)),
                    TextView(
                      label: 'Please wait',
                      textAlign: TextAlign.center,
                      color: m777777,
                      fontSize: 14,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void toastMessage(Color color, String title, String message) async {
    try {
      if (flashController != null) {
        flashController?.dismiss();
      }
    } catch (e) {
      //do nothing
    }
    try {
      showFlash(
        context: navigateKey.currentContext!,
        duration: const Duration(seconds: 5),
        persistent: true,
        builder: (_, controller) {
          flashController = controller;
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            behavior: FlashBehavior.fixed,
            backgroundColor: color,
            child: FlashBar(
              title: TextView(label: title, color: mWhite, fontSize: 16, fontWeight: FontWeight.w600),
              content: TextView(label: message, color: mWhite),
            ),
          );
        },
      );
    } catch (e) {
      showFlash(
        context: navigateKey.currentContext!,
        duration: const Duration(seconds: 5),
        persistent: true,
        builder: (_, controller) {
          flashController = controller;
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            behavior: FlashBehavior.fixed,
            backgroundColor: color,
            child: FlashBar(
              title: TextView(label: title, color: mWhite, fontSize: 16, fontWeight: FontWeight.w600),
              content: TextView(label: message, color: mWhite),
            ),
          );
        },
      );
    }
  }

  //drawer default icon
  static Widget getDefaultDrawerItemIcon({required IconData icon, double iconSize = 35}) {
    return Icon(
      icon,
      size: iconSize,
      color: mWhite,
    );
  }

  //drawer selected item icon
  static Widget getSelectedDrawerItemIcon({required IconData icon, double iconSize = 35}) {
    return Icon(
      icon,
      size: iconSize,
      color: mBlack,
    );
  }

  static Future<bool> userLogoutAlert() async {
    bool value = await showDialog(
      context: navigateKey.currentContext!,
      builder: (BuildContext context) {
        return const LogoutAlertDialog(
          title: "Confirmation",
          message: "Are you sure you want to logout?",
          positiveBtnText: 'Yes',
          negativeBtnText: 'No',
        );
      },
    );
    return value;
  }

  static int widthToGridCount(double width) {
    int gridCount = 0;
    if (width > 600) {
      gridCount = 1;
      if (width > 840) {
        gridCount = 2;
        if (width > 1110) {
          gridCount = 3;
          if (width > 1380) {
            gridCount = 4;
            if (width > 1650) {
              gridCount = 5;
            }
          }
        }
      }
    }
    return gridCount;
  }

  static double widthToGridCrossAxisSpacing(double width) {
    double crossAxisSpacing = 0;
    if (width > 600) {
      crossAxisSpacing = width - 570;
      if (width > 840) {
        crossAxisSpacing = width - 840;
        if (width > 1110) {
          crossAxisSpacing = width - 1110;
          if (width > 1380) {
            crossAxisSpacing = width - 1380;
            if (width > 1650) {
              crossAxisSpacing = width - 1650;
            }
          }
        }
      }
    }
    return crossAxisSpacing;
  }

  static String novelReadingStatusLabel(NovelReadingStatus status) {
    switch (status) {
      case NovelReadingStatus.notStarted:
        return 'Not Started';
      case NovelReadingStatus.reading:
        return 'Reading';
      case NovelReadingStatus.hiatusCompleted:
        return 'Partial';
      case NovelReadingStatus.completed:
        return 'Completed';
    }
  }

  static Color novelReadingStatusColor(NovelReadingStatus status) {
    switch (status) {
      case NovelReadingStatus.notStarted:
        return mPurpleLight;
      case NovelReadingStatus.reading:
        return mGreen;
      case NovelReadingStatus.hiatusCompleted:
        return m747474;
      case NovelReadingStatus.completed:
        return kYankeesBlue;
    }
  }

  static String getFirstLetterCapital(String value) {
    return (value.substring(0, 1).toUpperCase() + value.substring(1));
  }

  static Future<void> launchInBrowser(String url) async {
    if (kIsWeb) {
      await launchUrl(Uri.parse(url));
    } else {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

//end of file
}
