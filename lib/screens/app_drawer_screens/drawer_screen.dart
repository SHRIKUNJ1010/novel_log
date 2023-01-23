/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const TextView(label: 'Drawer Screen'),
      ),
      body: Container(
        color: mWhite,
      ),
    );
  }
}
