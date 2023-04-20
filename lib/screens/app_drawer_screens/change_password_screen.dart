/*
* Created by Shrikunj Patel on 1/23/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/utility.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String userId;

  const ChangePasswordScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: Utility.getCommonAppBarWithoutIcon(width, 'Change Password'),
      body: Container(
        color: Colors.cyanAccent,
      ),
    );
  }
}
