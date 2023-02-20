/*
* Created by Shrikunj Patel on 2/20/2023.
*/

import 'package:get/get.dart';

class HiddenPinController extends GetxController {
  bool hasEnteredPassword = false;

  updateValue(bool value) {
    hasEnteredPassword = value;
    update();
  }
}
