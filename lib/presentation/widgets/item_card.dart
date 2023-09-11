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
      this.item, {super.key,
        this.onPress,
      });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.darkBrown,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.beige.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: AppColors.purple,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildItem(height: itemHeight),
                    _buildItemNumber(),
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



  Widget _buildItem({required double height}) {
    final itemSize = height * _itemFraction;

    return Positioned(
      bottom: -2,
      right: 2,
      child: ItemImage(
        size: Size.square(itemSize),
        item: item,
      ),
    );
  }

  Widget _buildItemNumber() {
    return Positioned(
      top: 10,
      right: 14,
      child: Text(
        item.id,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.amber,
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final Item item;

  const _CardContent(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Hero(
              tag: item.id + item.name,
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 14,
                  height: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

}