import 'package:flutter/cupertino.dart';

class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.page})
      : super(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );

  final Widget page;
}
