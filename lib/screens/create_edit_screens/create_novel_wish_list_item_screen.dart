/*
* Created by Shrikunj Patel on 1/30/2023.
*/
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';

class CreateNovelWishListItemScreen extends StatefulWidget {
  const CreateNovelWishListItemScreen({Key? key}) : super(key: key);

  @override
  State<CreateNovelWishListItemScreen> createState() => _CreateNovelWishListItemScreenState();
}

class _CreateNovelWishListItemScreenState extends State<CreateNovelWishListItemScreen> {
  late Image smallBackgroundImage;
  late Image bigBackgroundImage;

  @override
  void initState() {
    bigBackgroundImage = Image.asset(
      libraryBackgroundImageForBigScreen,
      gaplessPlayback: true,
    );
    smallBackgroundImage = Image.asset(
      libraryBackgroundImage,
      gaplessPlayback: true,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(bigBackgroundImage.image, context);
    precacheImage(smallBackgroundImage.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        width > 600
            ? FadeInImage(
                width: width,
                height: height,
                fadeInDuration: const Duration(milliseconds: 10),
                fadeOutDuration: const Duration(milliseconds: 10),
                placeholder: smallBackgroundImage.image,
                image: bigBackgroundImage.image,
                fit: BoxFit.cover,
              )
            : FadeInImage(
                width: width,
                height: height,
                fadeInDuration: const Duration(milliseconds: 10),
                fadeOutDuration: const Duration(milliseconds: 10),
                placeholder: bigBackgroundImage.image,
                image: smallBackgroundImage.image,
                fit: BoxFit.cover,
              ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
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
                  if (!kIsWeb) Platform.isIOS || Platform.isAndroid ? const SizedBox(height: 15) : const SizedBox(height: 30),
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
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: appThemeColor[100],
                    child: SizedBox(
                      width: width > 840
                          ? width * (3 / 4)
                          : width < 600
                              ? width - 40
                              : width - 80,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              TextView(
                                label: 'Create Wish Novel',
                                color: mWhite,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 800,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
