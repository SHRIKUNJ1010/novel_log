/*
* Created by Shrikunj Patel on 2/7/2023.
*/

import 'package:flutter/material.dart';

class SlideDownPage extends Page {
  final Widget child;

  const SlideDownPage({
    required this.child,
    super.key,
    super.name,
    super.arguments,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        /*final offsetAnimation = animation.drive(tween);*/

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      maintainState: true,
    );
  }
}
