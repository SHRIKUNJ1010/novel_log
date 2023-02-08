/*
* Created by Shrikunj Patel on 2/8/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/models/router_models/transition_pages/fade_page.dart';
import 'package:novel_log/models/router_models/transition_pages/slide_down_page.dart';

class TransitionList {
  static MaterialPage createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  static FadePage createFadePage(Widget child, PageConfiguration pageConfig) {
    return FadePage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  static SlideDownPage createSlidePage(Widget child, PageConfiguration pageConfig) {
    return SlideDownPage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }
}
