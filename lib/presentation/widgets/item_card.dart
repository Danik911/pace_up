import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../../domain/entities/item.dart';
import 'item_image.dart';

class ItemCard extends StatelessWidget {
  static const double _circleFraction = 0.75;
  static const double _itemFraction = 0.76;

  final Item item;
  final void Function()? onItemPress;
  final void Function()? onCartPress;

  const ItemCard(
    this.item, {
    super.key,
    this.onItemPress,
    this.onCartPress,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemWidth = constrains.maxWidth;

        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            color: AppColors.whiteGrey,
            child: InkWell(
                onTap: onItemPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildItem(width: itemWidth),
                    Positioned(left: 120, top: 35, child: _CardContent(item)),
                    Positioned(
                        right: 15,
                        top: 15,
                        child: _CartIcon(
                          onCartPress: () => print("onCard Pressed"),
                        )),
                  ],
                )),
          ),
        );
      },
    );
  }

  Widget _buildItem({required double width}) {
    final itemWidth = width;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ItemImage(
        size: Size.square(itemWidth * 0.4),
        item: item,
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final Item item;

  const _CardContent(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: item.id,
        child: Padding(
          padding: EdgeInsets.all(18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              item.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
                height: 0.7,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 12)),
            Text(
              "Price: ${item.cost}",
              style: TextStyle(
                fontSize: 14,
                height: 0.7,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ]),
        ));
  }
}

class _CartIcon extends StatelessWidget {
  final void Function() onCartPress;

  const _CartIcon({required this.onCartPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 10, end: 5),
      showBadge: true,
      ignorePointer: false,
      onTap: onCartPress,
      badgeContent: Icon(Icons.shopping_cart, size: 25),
      badgeAnimation: badges.BadgeAnimation.rotation(
        animationDuration: Duration(milliseconds: 1000),
        colorChangeAnimationDuration: Duration(milliseconds: 500),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.bounceIn,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.instagram,
        badgeColor: Colors.blue,
        padding: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderGradient: badges.BadgeGradient.linear(
            colors: [Colors.lightBlue, Colors.black]),
        badgeGradient: badges.BadgeGradient.linear(
          colors: [Colors.greenAccent, Colors.indigo],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Text(
        "34",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
