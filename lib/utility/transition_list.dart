/*
* Created by Shrikunj Patel on 2/8/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/models/router_models/transition_pages/fade_page.dart';
import 'package:novel_log/models/router_models/transition_pages/slide_down_page.dart';
import 'package:novel_log/utility/page_config_to_widget.dart';

class TransitionList {
  static MaterialPage createPage(PageConfiguration pageConfig) {
    return MaterialPage(
      child: PageConfigToWidget.getWidget(pageConfig),
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  static FadePage createFadePage(PageConfiguration pageConfig) {
    return FadePage(
      child: PageConfigToWidget.getWidget(pageConfig),
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  static SlideDownPage createSlidePage(PageConfiguration pageConfig) {
    return SlideDownPage(
      child: PageConfigToWidget.getWidget(pageConfig),
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }
}
