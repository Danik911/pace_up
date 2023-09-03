import 'package:flutter/cupertino.dart';

Size getTextSize(BuildContext context, String text, TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: style,
    ),
    maxLines: 1,
    textScaleFactor: MediaQuery.of(context).textScaleFactor,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.size;
}
