/*
* Created by Shrikunj Patel on 1/12/2023.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
            if (kIsWeb) const SizedBox(height: 30),
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
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: appPrimaryColor,
                              ),
                              child: const TextView(
                                label: 'Sign Up',
                                color: mWhite,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: appPrimaryColor,
                              ),
                              child: const TextView(
                                label: 'Login',
                                color: mWhite,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
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
    );
  }
}
