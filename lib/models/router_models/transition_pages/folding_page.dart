/*
* Created by Shrikunj Patel on 2/14/2023.
*/

import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/transition_pages/fold_clipper.dart';
import 'package:novel_log/models/router_models/transition_pages/fold_painter.dart';
import 'package:novel_log/utility/color.dart';

class FoldingPage extends Page {
  final Widget child;

  const FoldingPage({
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
        const begin = Offset(0.0, 0.0);
        const end = Offset(1.0, 1.0);
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        /*final offsetAnimation = animation.drive(tween);*/

        return AnimatedBuilder(
          animation: offsetAnimation,
          builder: (context, children) {
            if (offsetAnimation.isCompleted) {
              return child;
            } else {
              return CustomPaint(
                foregroundPainter: FoldPainter(
                  context: context,
                  offset: offsetAnimation.value,
                ),
                child: ClipPath(
                  clipper: FoldClipper(
                    context: context,
                    offset: offsetAnimation.value,
                  ),
                  child: Stack(
                    children: [
                      child,
                      Container(color: mBlack.withOpacity(0.5)),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
      transitionDuration: const Duration(milliseconds: 1500),
      maintainState: true,
    );
  }
}
