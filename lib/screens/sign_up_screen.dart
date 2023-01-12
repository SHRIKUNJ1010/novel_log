/*
* Created by Shrikunj Patel on 1/12/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const TextView(label: 'Sing Up Screen'),
      ),
      body: Container(
        color: appPrimaryColor,
      ),
    );
  }
}
