/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
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
        body: Container(
          color: Colors.red,
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: Colors.red,
        ),
      );
    }
  }
}
