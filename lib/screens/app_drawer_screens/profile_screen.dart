/*
* Created by Shrikunj Patel on 1/23/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  final bool showAppBar;
  final String userId;

  const ProfileScreen({
    Key? key,
    required this.userId,
    this.showAppBar = false,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextView(label: 'Profile'),
        ),
        body: Container(
          color: Colors.purple,
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: Colors.purple,
        ),
      );
    }
  }
}
