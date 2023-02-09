/*
* Created by Shrikunj Patel on 1/12/2023.
*/
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/data_models/user_profile_model.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamController<bool> validateFieldController = StreamController<bool>.broadcast();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  late Image smallBackgroundImage;
  late Image bigBackgroundImage;

  bool verifyFields() {
    return emailEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty && Utility.validateEmail(emailEditingController.text);
  }

  checkValidation() async {
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
    String tempUserId = await FirebaseAuthService.signInWithEmail(
      emailEditingController.text,
      passwordEditingController.text,
    );
    if (tempUserId != '') {
      UserProfileModel tempUser = await UserServices.getUserData(tempUserId);
      Utility.printLog(tempUser.toJson());
      drawerStateProvider.pushReplacement(PageConfigList.getYourNovelListScreen(tempUserId), TransitionType.slideDownTransition);
      Preference.setUserId(tempUserId);
      Preference.setIsUserLoggedIn(true);
      pageStateProvider.popUntil(PageConfigList.getLoginScreen());
      pageStateProvider.pushReplacement(PageConfigList.getDrawerScreen(), TransitionType.slideDownTransition);
      emailEditingController.clear();
      passwordEditingController.clear();
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      emailEditingController.addListener(() {
        validateFieldController.add(verifyFields());
      });
      passwordEditingController.addListener(() {
        validateFieldController.add(verifyFields());
      });
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
    emailEditingController.dispose();
    passwordEditingController.dispose();
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
                                label: 'Login',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: mWhite,
                              ),
                            ],
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
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (value) {
                                checkValidation();
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          width > 500
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: CommonRoundedButton(
                                          onTap: () {
                                            pageStateProvider.pushReplacement(PageConfigList.getSignUpScreen(), TransitionType.slideDownTransition);
                                          },
                                          height: 50,
                                          text: 'Sign Up',
                                          textColor: mWhite,
                                          buttonColor: appPrimaryColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        flex: 1,
                                        child: StreamBuilder<bool>(
                                          stream: validateFieldController.stream,
                                          builder: (context, snapshot) {
                                            return CommonRoundedButton(
                                              onTap: checkValidation,
                                              height: 50,
                                              text: 'Login',
                                              textColor: mWhite,
                                              buttonColor: (snapshot.data ?? false) ? appPrimaryColor : appPrimaryColor.withOpacity(0.2),
                                              fontSize: 20,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      StreamBuilder<bool>(
                                        stream: validateFieldController.stream,
                                        builder: (context, snapshot) {
                                          return CommonRoundedButton(
                                            onTap: checkValidation,
                                            height: 50,
                                            text: 'Login',
                                            textColor: mWhite,
                                            buttonColor: (snapshot.data ?? false) ? appPrimaryColor : appPrimaryColor.withOpacity(0.2),
                                            fontSize: 20,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      CommonRoundedButton(
                                        onTap: () {
                                          pageStateProvider.pushReplacement(PageConfigList.getSignUpScreen(), TransitionType.slideDownTransition);
                                        },
                                        height: 50,
                                        text: 'Sign Up',
                                        textColor: mWhite,
                                        buttonColor: appPrimaryColor,
                                        fontSize: 20,
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () {
                                  pageStateProvider.push(PageConfigList.getForgetPasswordScreen(), TransitionType.slideDownTransition);
                                },
                                child: const TextView(
                                  label: 'forgot password?',
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
                  )
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
