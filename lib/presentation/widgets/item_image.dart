import 'package:flutter/material.dart';

import '../../configs/images.dart';
import '../../domain/entities/item.dart';

class ItemImage extends StatelessWidget {
  static const Size _cacheMaxSize = Size(700, 700);

  final Item item;
  final EdgeInsets padding;
  final bool useItem;
  final Size size;
  final ImageProvider placeholder;
  final Color? tintColor;

  const ItemImage({
    Key? key,
    required this.item,
    required this.size,
    this.padding = EdgeInsets.zero,
    this.useItem = true,
    this.placeholder = AppImages.model_1,
    this.tintColor,
  }) : super(key: key);

  //TODO("Later you'll need to change Image.asset to CachedNetworkImage")
  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: useItem,
      child: Hero(
        tag: item.image,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuint,
          padding: padding,
          child: Image.asset(
            item.image,
            width: size.width,
            height: size.height,
            alignment: Alignment.bottomCenter,
            color: tintColor,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
