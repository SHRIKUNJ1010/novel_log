/*
* Created by Shrikunj Patel on 2/20/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class EnterPinWidget extends StatefulWidget {
  final double width;
  final String title;
  final Function onPositiveTap;
  final Function onNegativeTap;

  const EnterPinWidget({
    Key? key,
    required this.width,
    required this.title,
    required this.onPositiveTap,
    required this.onNegativeTap,
  }) : super(key: key);

  @override
  State<EnterPinWidget> createState() => _EnterPinWidgetState();
}

class _EnterPinWidgetState extends State<EnterPinWidget> {
  final TextEditingController pinEditingField = TextEditingController();
  int filledPin = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pinEditingField.addListener(() {
        filledPin = pinEditingField.text.length;
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          TextView(
            label: widget.title,
            color: appPrimaryColor,
            fontSize: 26,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 70),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < filledPin; i++) ...[
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appPrimaryColor,
                    ),
                  ),
                ],
                for (int i = 0; i < (6 - filledPin); i++) ...[
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appThemeColor[50],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 0, 70, 10),
            child: Column(
              children: [
                for (int i = 0; i < 4; i++) ...[
                  i == 3
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () {
                                String temp = pinEditingField.text;
                                if (filledPin == 0) {
                                  widget.onNegativeTap.call();
                                } else {
                                  pinEditingField.text = temp.substring(0, temp.length - 1);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: (widget.width - 200) / 3,
                                height: (widget.width - 200) / 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((widget.width - 200) / 6),
                                  color: mFA5D5D,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: mWhite,
                                  size: 18,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (filledPin != 6) {
                                  pinEditingField.text += '0';
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: (widget.width - 200) / 3,
                                height: (widget.width - 200) / 3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((widget.width - 200) / 6),
                                  color: appThemeColor[100]!.withOpacity(0.6),
                                ),
                                child: const TextView(
                                  label: '0',
                                  color: mWhite,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (filledPin == 6) {
                                  widget.onPositiveTap.call();
                                } else {
                                  Utility.toastMessage(mFA5D5D, 'Invalid field', 'Your pin is invalid. Please enter valid pin.');
                                }
                              },
                              child: Container(
                                width: (widget.width - 200) / 3,
                                height: (widget.width - 200) / 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((widget.width - 200) / 6),
                                  color: mGreen,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: mWhite,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            for (int j = 1; j < 4; j++) ...[
                              InkWell(
                                onTap: () {
                                  if (filledPin != 6) {
                                    pinEditingField.text += '${(3 * i) + j}';
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  width: (widget.width - 200) / 3,
                                  height: (widget.width - 200) / 3,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((widget.width - 200) / 6),
                                    color: appThemeColor[100]!.withOpacity(0.6),
                                  ),
                                  child: TextView(
                                    label: '${(3 * i) + j}',
                                    fontSize: 20,
                                    color: mWhite,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                  const SizedBox(height: 15),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
