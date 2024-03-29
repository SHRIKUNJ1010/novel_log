/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/models/getx_controller_model/user_data_controller.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/enter_pin_widget.dart';

class ChangeHiddenPinScreen extends StatefulWidget {
  final String userId;

  const ChangeHiddenPinScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ChangeHiddenPinScreen> createState() => _ChangeHiddenPinScreenState();
}

class _ChangeHiddenPinScreenState extends State<ChangeHiddenPinScreen> {
  int currentPage = 0;
  UserDataController userController = UserDataController();
  String oldPin = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (userController.userData.userHiddenPin == '') {
        currentPage = 1;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: Utility.getCommonAppBarWithoutIcon(width, 'Change Pin'),
      body: IndexedStack(
        index: currentPage,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EnterPinWidget(
                width: width < 500 ? width : 500,
                title: 'Enter Your Current Pin',
                onPositiveTap: (value) {
                  oldPin = value;
                  currentPage = 1;
                  setState(() {});
                },
                onNegativeTap: () {
                  //negative tap
                },
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EnterPinWidget(
                width: width < 500 ? width : 500,
                title: 'Enter New Pin',
                onPositiveTap: (value) {
                  if (oldPin != '') {
                    userController.changeUserPin(userController.userData.userId!, value, oldPin);
                  } else {
                    userController.createNewUserPin(userController.userData.userId!, value);
                  }
                  currentPage = 0;
                  setState(() {});
                },
                onNegativeTap: () {
                  currentPage = 0;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
