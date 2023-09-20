import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const model_1 = _Image('1.jpg');
  static const model_2 = _Image('2.jpg');
  static const model_3 = _Image('3.jpg');
  static const model_4 = _Image('4.jpg');
  static const model_6 = _Image('6.jpg');
  static const model_7 = _Image('7.jpg');
  static const model_8 = _Image('8.jpg');
  static const model_9 = _Image('9.jpg');
  static const pokeball = _Image('pokeball.png');
  static const dotted = _Image('dotted.png');

  static Future precacheAssets(BuildContext context) async {
    await precacheImage(model_1, context);
    await precacheImage(model_2, context);
    await precacheImage(model_3, context);
    await precacheImage(model_4, context);
    await precacheImage(model_6, context);
    await precacheImage(model_7, context);
    await precacheImage(model_8, context);
    await precacheImage(model_9, context);
    await precacheImage(dotted, context);
    await precacheImage(pokeball, context);
  }
}
