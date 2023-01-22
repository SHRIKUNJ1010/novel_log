import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/common_rounded_button.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailEditingController = TextEditingController();

  checkValidation() async {
    if (emailEditingController.text.trim().isEmpty) {
      Utility.toastMessage(mFA5D5D, 'Email Address Field',
          "Email Address field can't be left empty!");
      return;
    }
    if (!Utility.validateEmail(emailEditingController.text.trim())) {
      Utility.toastMessage(
          mFA5D5D, 'Email Address Field', "Invalid Email Address!");
      return;
    }
    //TODO: check how to do forget password activity
    Utility.toastMessage(
      mFA5D5D,
      'Not Implemented',
      'This function is not implemented yet.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(libraryBackgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!kIsWeb)
                  Platform.isIOS || Platform.isAndroid
                      ? const SizedBox(height: 100)
                      : const SizedBox(height: 30),
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
                if (!kIsWeb)
                  Platform.isIOS || Platform.isAndroid
                      ? const SizedBox(height: 15)
                      : const SizedBox(height: 30),
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
                              label: 'Forgot Password',
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
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CommonRoundedButton(
                            onTap: checkValidation,
                            height: 50,
                            text: 'Submit Request',
                            textColor: mWhite,
                            buttonColor: appPrimaryColor,
                            fontSize: 20,
                          ),
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
    );
  }

//end of file
}
