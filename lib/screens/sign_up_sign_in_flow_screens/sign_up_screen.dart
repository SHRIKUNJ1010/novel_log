/*
* Created by Shrikunj Patel on 1/12/2023.
*/
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/data_models/user_profile_model.dart';
import 'package:novel_log/models/getx_controller_model/user_data_controller.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/firebase_services/database_services/user_services.dart';
import 'package:novel_log/utility/firebase_services/firebase_auth_service.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/common_rounded_button.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'dart:io' show Platform;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  StreamController<bool> validateFieldController = StreamController<bool>.broadcast();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController repeatPasswordEditingController = TextEditingController();
  late Image smallBackgroundImage;
  late Image bigBackgroundImage;

  UserDataController userController = Get.put(UserDataController());

  bool verifyFields() {
    return nameEditingController.text.isNotEmpty &&
        emailEditingController.text.isNotEmpty &&
        Utility.validateEmail(emailEditingController.text) &&
        passwordEditingController.text.isNotEmpty &&
        passwordEditingController.text.length < 6 &&
        repeatPasswordEditingController.text.isNotEmpty &&
        repeatPasswordEditingController.text != passwordEditingController.text;
  }

  checkValidation() async {
    if (nameEditingController.text.trim().isEmpty) {
      Utility.toastMessage(mFA5D5D, 'Name Field', "Name field can't be left empty!");
    }
    if (emailEditingController.text.trim().isEmpty) {
      Utility.toastMessage(mFA5D5D, 'Email Address Field', "Email Address field can't be left empty!");
      return;
    }
    if (!Utility.validateEmail(emailEditingController.text.trim())) {
      Utility.toastMessage(mFA5D5D, 'Email Address Field', "Invalid Email Address!");
      return;
    }
    if (passwordEditingController.text.trim().isEmpty) {
      Utility.toastMessage(mFA5D5D, 'Password Field', "Password field can't be left empty!");
      return;
    }
    if (passwordEditingController.text.trim().length < 6) {
      Utility.toastMessage(mFA5D5D, 'Password Field', "There must be minimum 6 characters!");
      return;
    }
    if (repeatPasswordEditingController.text.trim().isEmpty) {
      Utility.toastMessage(mFA5D5D, 'Repeat Password Field', "Repeat Password field can't be left empty!");
      return;
    }
    if (repeatPasswordEditingController.text.trim() != passwordEditingController.text.trim()) {
      Utility.toastMessage(mFA5D5D, 'Error', "Password and Confirm password mismatch!");
      return;
    }
    String tempUserId = await FirebaseAuthService.signUpWithEmail(
      emailEditingController.text,
      passwordEditingController.text,
    );
    if (tempUserId != '') {
      Preference.setUserId(tempUserId);
      Preference.setIsUserLoggedIn(true);
      final tempUser = UserProfileModel.create(
        userId: tempUserId,
        userName: nameEditingController.text,
        email: emailEditingController.text,
      );
      await UserServices.createUser(tempUserId, tempUser.toJson());
      if (!kIsWeb) {
        await userController.storeDataInLocalDatabase(tempUserId, localDb.database);
      } else {
        await userController.getUserData(tempUserId);
      }
      drawerStateProvider.pushReplacement(PageConfigList.getYourNovelListScreen(tempUserId), TransitionType.foldTransition);
      pageStateProvider.popUntil(PageConfigList.getLoginScreen());
      pageStateProvider.pushReplacement(PageConfigList.getDrawerScreen(), TransitionType.foldTransition);
      emailEditingController.clear();
      nameEditingController.clear();
      passwordEditingController.clear();
      repeatPasswordEditingController.clear();
    }
  }

  @override
  void initState() {
    bigBackgroundImage = Image.asset(
      libraryBackgroundImageForBigScreen,
      gaplessPlayback: true,
    );
    smallBackgroundImage = Image.asset(
      libraryBackgroundImage,
      gaplessPlayback: true,
    );
    nameEditingController.addListener(() {
      validateFieldController.add(verifyFields());
    });
    emailEditingController.addListener(() {
      validateFieldController.add(verifyFields());
    });
    passwordEditingController.addListener(() {
      validateFieldController.add(verifyFields());
    });
    repeatPasswordEditingController.addListener(() {
      validateFieldController.add(verifyFields());
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(bigBackgroundImage.image, context);
    precacheImage(smallBackgroundImage.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    validateFieldController.close();
    nameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    repeatPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        width > 600
            ? FadeInImage(
                width: width,
                height: height,
                fadeInDuration: const Duration(milliseconds: 10),
                fadeOutDuration: const Duration(milliseconds: 10),
                placeholder: smallBackgroundImage.image,
                image: bigBackgroundImage.image,
                fit: BoxFit.cover,
              )
            : FadeInImage(
                width: width,
                height: height,
                fadeInDuration: const Duration(milliseconds: 10),
                fadeOutDuration: const Duration(milliseconds: 10),
                placeholder: bigBackgroundImage.image,
                image: smallBackgroundImage.image,
                fit: BoxFit.cover,
              ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!kIsWeb) Platform.isIOS || Platform.isAndroid ? const SizedBox(height: 100) : const SizedBox(height: 30),
                  if (!kIsWeb)
                    Platform.isAndroid || Platform.isIOS
                        ? Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                nlIconImage,
                                width: width / 4,
                                height: width / 4,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                nlIconImage,
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                  if (!kIsWeb) Platform.isIOS || Platform.isAndroid ? const SizedBox(height: 15) : const SizedBox(height: 30),
                  if (kIsWeb)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          nlIconImage,
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: appThemeColor[100],
                    child: SizedBox(
                      width: width > 1500
                          ? width / 3
                          : width > 580
                              ? 500
                              : width - 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              TextView(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                label: 'Create Account',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: mWhite,
                              ),
                            ],
                          ),
                          const TextView(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            label: 'Name',
                            color: mWhite,
                            fontSize: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                            child: TextField(
                              controller: nameEditingController,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const TextView(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            label: 'Email',
                            color: mWhite,
                            fontSize: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                            child: TextField(
                              controller: emailEditingController,
                              textInputAction: TextInputAction.next,
                              onTapOutside: (down) {
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                }
                              },
                            ),
                          ),
                          const TextView(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            label: 'Password',
                            color: mWhite,
                            fontSize: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                            child: TextField(
                              controller: passwordEditingController,
                              textInputAction: TextInputAction.next,
                              onTapOutside: (down) {
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                }
                              },
                              obscureText: true,
                            ),
                          ),
                          const TextView(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            label: 'Confirm Password',
                            color: mWhite,
                            fontSize: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                            child: TextField(
                              controller: repeatPasswordEditingController,
                              onTapOutside: (down) {
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                }
                              },
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              onSubmitted: (value) {
                                if (kIsWeb) {
                                  checkValidation();
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StreamBuilder<bool>(
                                stream: validateFieldController.stream,
                                builder: (context, snapshot) {
                                  return CommonRoundedButton(
                                    onTap: checkValidation,
                                    height: 50,
                                    text: 'Create Account',
                                    textColor: mWhite,
                                    buttonColor: (snapshot.data ?? false) ? appPrimaryColor : appPrimaryColor.withOpacity(0.2),
                                    fontSize: 20,
                                  );
                                }),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () {
                                  pageStateProvider.pushReplacement(PageConfigList.getLoginScreen(), TransitionType.foldTransition);
                                },
                                child: const TextView(
                                  label: 'have an account? login here.',
                                  color: appPrimaryColor,
                                  fontSize: 18,
                                  textDecoration: TextDecoration.underline,
                                  decorationColor: appPrimaryColor,
                                  decorationThickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  if (!kIsWeb) Platform.isIOS || Platform.isAndroid ? const SizedBox(height: 100) : const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//end of file
}
