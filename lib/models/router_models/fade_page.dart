import 'package:flutter/material.dart';

class FadePage extends Page {
  final Widget child;

  const FadePage({
    required this.child,
    super.key,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      maintainState: true,
    );
  }
}
