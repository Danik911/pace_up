import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const bulbasaur = _Image('1.png');
  static const charmander = _Image('2.png');
  static const squirtle = _Image('3.png');
  static const pokeball = _Image('3.png');
  static const male = _Image('4.png');
  static const female = _Image('5.png');
  static const dotted = _Image('6.png');
  static const thumbnail = _Image('7.png');
  static const pikloader = _Image('8.gif');

  static Future precacheAssets(BuildContext context) async {
    await precacheImage(bulbasaur, context);
    await precacheImage(charmander, context);
    await precacheImage(squirtle, context);
    await precacheImage(pokeball, context);
    await precacheImage(male, context);
    await precacheImage(female, context);
    await precacheImage(dotted, context);
    await precacheImage(thumbnail, context);
    await precacheImage(pikloader, context);
  }
}
