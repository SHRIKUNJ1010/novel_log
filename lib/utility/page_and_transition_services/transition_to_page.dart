/*
* Created by Shrikunj Patel on 2/9/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/page_config.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/page_and_transition_services/transition_list.dart';

class TransitionToPage {
  static Page getPage(TransitionType transitionType, PageConfiguration pageConfiguration) {
    switch (transitionType) {
      case TransitionType.defaultTransition:
        return TransitionList.createPage(pageConfiguration);
      case TransitionType.fadeTransition:
        return TransitionList.createFadePage(pageConfiguration);
      case TransitionType.slideDownTransition:
        return TransitionList.createSlidePage(pageConfiguration);
    }
  }
}
