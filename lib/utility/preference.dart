/*
* Created by Shrikunj Patel on 1/6/2023.
*/

import 'package:novel_log/main.dart';
import 'package:novel_log/utility/constants.dart';

class Preference {
  static clearPreference() {
    prefs.clear();
  }

  static String getUserId() {
    return prefs.getString(prefUserId) ?? '';
  }

  static bool getIsUserLoggedIn() {
    return prefs.getBool(prefIsUserLoggedIn) ?? false;
  }

  static setIsUserLoggedIn(bool isUserLoggedIn) {
    prefs.setBool(prefIsUserLoggedIn, isUserLoggedIn);
  }

  static setUserId(String userId) {
    prefs.setString(prefUserId, userId);
  }

//end of file
}
