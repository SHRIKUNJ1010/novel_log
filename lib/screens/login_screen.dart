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
            const TextView(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              label: 'Login',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: mBlack,
            ),
          ],
        ),
      ),
    );
  }
}
