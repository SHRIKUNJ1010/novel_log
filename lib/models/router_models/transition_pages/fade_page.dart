import 'package:flutter/material.dart';

class FadePage extends Page {
  final Widget child;

  const FadePage({
    required this.child,
    super.key,
    super.name,
    super.arguments,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      maintainState: true,
    );
  }
}
