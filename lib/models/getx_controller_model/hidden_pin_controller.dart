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

  Future<bool> comparePinHash(String userId, String userPin) async {
    /*final tempHash = await UserServices.getUserPinHash(userId);
    final givenPinHash = Password.hash(userPin, PBKDF2());
    return tempHash == givenPinHash;*/
    return true;
  }
}
