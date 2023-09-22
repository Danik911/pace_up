import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../domain/entities/item.dart';
import 'item_image.dart';

class ItemCard extends StatelessWidget {
  static const double _circleFraction = 0.75;
  static const double _itemFraction = 0.76;

  final Item item;
  final void Function()? onPress;

  const ItemCard(
    this.item, {
    super.key,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemWidth = constrains.maxWidth;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.blue.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: AppColors.whiteGrey,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildItem(width: itemWidth),
                    _CardContent(item),
                  ],
                ),
              ),
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
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ItemImage(
        size: Size.square(itemWidth * 0.65),
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
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Hero(
          tag: item.name,
          child: Text(
            item.name,
            style: TextStyle(
              fontSize: 14,
              height: 0.7,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ));
  }
}
