/*
* Created by Shrikunj Patel on 2/20/2023.
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/hidden_pin_controller.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/preference.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/enter_pin_widget.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({Key? key}) : super(key: key);

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: width > 600
          ? AppBar(
              centerTitle: true,
              title: const TextView(label: 'Enter Pin'),
            )
          : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EnterPinWidget(
            width: width < 500 ? width : 500,
            title: 'Enter Your Pin',
            onPositiveTap: (value) async {
              HiddenPinController pinController = Get.put(HiddenPinController());
              final temp = await pinController.comparePinHash(Preference.getUserId(), value);
              if (temp) {
                pinController.updateValue(true);
                drawerStateProvider.pushReplacement(PageConfigList.getNovelHiddenListScreen(Preference.getUserId()), TransitionType.foldTransition);
              } else {
                Utility.toastMessage(mFA5D5D, 'Wrong Pin', 'Given pin does not match database pin. Please check your pin again');
              }
            },
            onNegativeTap: () {
              Utility.printLog('Negative button called');
            },
          ),
        ],
      ),
    );
  }
}
