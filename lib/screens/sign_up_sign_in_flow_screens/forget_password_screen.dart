import 'dart:async';
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
  StreamController<bool> validateFieldController = StreamController<bool>.broadcast();
  TextEditingController emailEditingController = TextEditingController();
  late Image smallBackgroundImage;
  late Image bigBackgroundImage;

  bool verifyFields() {
    return emailEditingController.text.isNotEmpty && Utility.validateEmail(emailEditingController.text);
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
    //TODO: check how to do forget password activity
    Utility.toastMessage(
      mFA5D5D,
      'Not Implemented',
      'This function is not implemented yet.',
    );
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
    emailEditingController.addListener(() {
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
    emailEditingController.dispose();
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
                placeholder: smallBackgroundImage.image,
                image: bigBackgroundImage.image,
                fit: BoxFit.cover,
              )
            : FadeInImage(
                width: width,
                height: height,
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
                            child: StreamBuilder<bool>(
                                stream: validateFieldController.stream,
                                builder: (context, snapshot) {
                                  return CommonRoundedButton(
                                    onTap: checkValidation,
                                    height: 50,
                                    text: 'Submit Request',
                                    textColor: mWhite,
                                    buttonColor: (snapshot.data ?? false) ? appPrimaryColor : appPrimaryColor.withOpacity(0.2),
                                    fontSize: 20,
                                  );
                                }),
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
