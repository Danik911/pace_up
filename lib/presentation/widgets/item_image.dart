import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/item.dart';
import '../../configs/images.dart';

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
          child: CachedNetworkImage(
            imageUrl: item.image,
            useOldImageOnUrlChange: true,
            maxWidthDiskCache: _cacheMaxSize.width.toInt(),
            maxHeightDiskCache: _cacheMaxSize.height.toInt(),
            fadeInDuration: const Duration(milliseconds: 120),
            fadeOutDuration: const Duration(milliseconds: 120),
            imageBuilder: (_, image) => Image(
              image: image,
              width: size.width,
              height: size.height,
              alignment: Alignment.bottomCenter,
              color: tintColor,
              fit: BoxFit.contain,
            ),
            placeholder: (_, __) => Image(
              image: placeholder,
              width: size.width,
              height: size.height,
              alignment: Alignment.bottomCenter,
              color: Colors.black12,
              fit: BoxFit.contain,
            ),
            errorWidget: (_, __, ___) => Stack(
              alignment: Alignment.center,
              children: [
                Image(
                  image: placeholder,
                  width: size.width,
                  height: size.height,
                  color: Colors.black12,
                ),
                Icon(
                  Icons.warning_amber_rounded,
                  size: size.width * 0.3,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
