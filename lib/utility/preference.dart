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

  static setUserId(String userId) {
    prefs.setString(prefUserId, userId);
  }

}
