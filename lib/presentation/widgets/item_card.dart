import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configs/colors.dart';
import '../../domain/entities/item.dart';
import 'item_image.dart';

class ItemCard extends StatelessWidget {
  static const double _circleFraction = 0.75;
  static const double _itemFraction = 0.76;

  final Item item;
  final void Function()? onItemPress;
  final void Function()? onCartPress;

  const ItemCard(this.item, {
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
            child: Stack(
              fit: StackFit.values.last,
              children: [
                InkWell(
                    onTap: onItemPress,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildItem(width: itemWidth),
                        _CardContent(item),
                      ],
                    )),
                CartIcon(
                  onCartPress: onCartPress,
                ),
              ],
            ),
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
          padding: EdgeInsets.only(top: 40, left: 12),
          child: SizedBox(
            width: 150,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                item.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .background,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 12)),
              Text(
                "Price: ${item.cost}",
                style: TextStyle(
                  fontSize: 14,
                  height: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .background,
                ),
              ),
            ]),
          ),
        ));
  }
}

class CartIcon extends StatefulWidget {


  const CartIcon({
    super.key,
    this.onCartPress,
  });

  final void Function()? onCartPress;



  @override
  CartIconState createState() => CartIconState();
}

class CartIconState extends State<CartIcon> with AutomaticKeepAliveClientMixin<CartIcon> {

  int _cartBadgeAmount = 0;
  late bool _showCartBadge;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _showCartBadge = _cartBadgeAmount > 0;
    return Stack(
      children: [
        Positioned(
          top: 15,
          right: 15,
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(top: 10, end: 8),
            showBadge: true,
            ignorePointer: false,
            onTap: () => setState(() {_cartBadgeAmount++;}),
            badgeContent: const Icon(Icons.shopping_cart, size: 22),
            badgeAnimation: const badges.BadgeAnimation.rotation(
              animationDuration: Duration(milliseconds: 1000),
              colorChangeAnimationDuration: Duration(milliseconds: 500),
              loopAnimation: false,
              curve: Curves.fastOutSlowIn,
              colorChangeAnimationCurve: Curves.bounceIn,
            ),
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.instagram,
              badgeColor: Colors.blue,
              padding: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.white, width: 2),
              borderGradient: const badges.BadgeGradient.linear(
                  colors: [Colors.lightBlue, Colors.black]),
              badgeGradient: const badges.BadgeGradient.linear(
                colors: [Colors.greenAccent, Colors.indigo],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 10,
          child: Visibility(
              visible: _showCartBadge,
              child: Text(
                "$_cartBadgeAmount",
                style: const TextStyle(color: Colors.blueAccent),
              )),
        )
      ],
    );
  }
}







