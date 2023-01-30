/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class NovelWishListScreen extends StatefulWidget {
  final String userId;

  const NovelWishListScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<NovelWishListScreen> createState() => _NovelWishListScreenState();
}

class _NovelWishListScreenState extends State<NovelWishListScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width > 600) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextView(label: 'Wish List'),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Utility.printLog('tapped on floating action button');
          },
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(color: appPrimaryColor, borderRadius: BorderRadius.circular(27.5)),
            child: const Icon(color: mWhite, size: 30, Icons.add),
          ),
        ),
        body: Container(
          color: Colors.red,
        ),
      );
    } else {
      return Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            Utility.printLog('tapped on floating action button');
          },
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(color: appPrimaryColor, borderRadius: BorderRadius.circular(27.5)),
            child: const Icon(color: mWhite, size: 30, Icons.add),
          ),
        ),
        body: Container(
          color: Colors.red,
        ),
      );
    }
  }
}
