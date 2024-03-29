/*
* Created by Shrikunj Patel on 1/6/2023.
*/

import 'dart:io';
import 'dart:math' as math;

import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:novel_log/main.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/firebase_services/database_services/novel_services.dart';
import 'package:novel_log/utility/firebase_services/database_services/user_services.dart';
import 'package:novel_log/utility/local_database_services/novel_local_services.dart';
import 'package:novel_log/utility/local_database_services/user_local_services.dart';
import 'package:novel_log/widgets/common_widgets/logout_alert_dialog.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static AppBar? getCommonAppBarWithoutIcon(double width, String title) {
    if (kIsWeb) {
      if (width > 700) {
        return AppBar(
          centerTitle: true,
          title: TextView(label: title),
        );
      } else {
        return null;
      }
    } else {
      if (width > 900) {
        return AppBar(
          centerTitle: true,
          title: TextView(label: title),
        );
      } else {
        return null;
      }
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

  static Future<String> addGenreDialog(BuildContext context) async {
    TextEditingController genreController = TextEditingController();
    String genre = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop('');
                      },
                      child: const Icon(
                        Icons.close,
                        size: 30,
                        color: appThemeColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const TextView(
                          label: 'Add Genre',
                          color: mBlack,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(genreController.text);
                      },
                      child: const Icon(
                        Icons.check,
                        size: 30,
                        color: appThemeColor,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: genreController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Genre',
                    hintStyle: Utility.getRichTextStyle(
                      fontSize: 16,
                      color: mBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return genre;
  }

  static int widthToGridCount(double width) {
    printLog("width: ------------------------ $width");
    int gridCount = 1;
    if (kIsWeb) {
      if (width > 470) {
        gridCount = 2;
        if (width > 700) {
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
      }
    } else {
      if (width > 400) {
        gridCount = 2;
        if (width > 700) {
          gridCount = 3;
          if (width > 900) {
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
      }
    }
    return gridCount;
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

  static String novelStatusLabel(NovelStatus status) {
    switch (status) {
      case NovelStatus.production:
        return 'Production';
      case NovelStatus.hiatus:
        return 'Hiatus';
      case NovelStatus.completed:
        return 'Completed';
    }
  }

  static Color novelStatusColor(NovelStatus status) {
    switch (status) {
      case NovelStatus.production:
        return mGreen;
      case NovelStatus.hiatus:
        return m747474;
      case NovelStatus.completed:
        return kYankeesBlue;
    }
  }

  static String novelReadingStatusToString(NovelReadingStatus status) {
    switch (status) {
      case NovelReadingStatus.notStarted:
        return 'not_started';
      case NovelReadingStatus.reading:
        return 'reading';
      case NovelReadingStatus.hiatusCompleted:
        return 'hiatus_completed';
      case NovelReadingStatus.completed:
        return 'completed';
      default:
        return 'reading';
    }
  }

  static NovelReadingStatus stringToNovelReadingStatus(String status) {
    switch (status) {
      case 'not_started':
        return NovelReadingStatus.notStarted;
      case 'reading':
        return NovelReadingStatus.reading;
      case 'hiatus_completed':
        return NovelReadingStatus.hiatusCompleted;
      case 'completed':
        return NovelReadingStatus.completed;
      default:
        return NovelReadingStatus.reading;
    }
  }

  static NovelStatus stringToNovelStatus(String status) {
    switch (status) {
      case 'production':
        return NovelStatus.production;
      case 'hiatus':
        return NovelStatus.hiatus;
      case 'completed':
        return NovelStatus.completed;
      default:
        return NovelStatus.production;
    }
  }

  static String novelStatusToString(NovelStatus status) {
    switch (status) {
      case NovelStatus.production:
        return 'production';
      case NovelStatus.hiatus:
        return 'hiatus';
      case NovelStatus.completed:
        return 'completed';
      default:
        return 'production';
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

  static String listToCommaSeparatedString(List<dynamic> list) {
    return list.join(',');
  }

  static List<T> commaSeparatedStringToList<T extends Object>(String commaSeparatedString) {
    List<dynamic> temp = commaSeparatedString.split(',');
    List<T> value = temp.map((e) => e as T).toList();
    return value;
  }

  static Future<void> getUserDataFromFirebaseAndInsertIntoLocalDatabase(String userId, Database db) async {
    final temp = await UserServices.getUserData(userId);
    await UserLocalServices.insertUserData(db, temp);
    return;
  }

  static Future<void> getNovelDataFromFirebaseAndInsertIntoLocalDatabase(String userId, Database db) async {
    final temp = await NovelServices.getAllNovelListForUser(userId);
    for (var element in temp) {
      await NovelLocalServices.insertNovelData(db, element);
    }
    return;
  }

  static Future<void> uploadUserDataToFirebaseFromLocalDatabase(String userId, Database db) async {
    final temp = await UserLocalServices.getUserData(db);
    await UserServices.createUser(userId, temp.toJson());
    return;
  }

  static Future<void> uploadNovelAllListDataToFirebaseFromLocalDatabase(String userId, Database db) async {
    final temp = await NovelLocalServices.getAllNovelList(db, userId);
    for (var element in temp) {
      await NovelServices.editNovel(element.novelId!, element.toJson());
    }
    return;
  }

//end of file
}
