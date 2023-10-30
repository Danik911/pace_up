import 'package:flutter/material.dart';
import 'package:pace_up/domain/entities/cart_item.dart';
import 'item_image.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;
  final void Function()? decreaseQuantity;
  final void Function() increaseQuantity;
  final String? heroTag;

  // final int index;

  const CartItemCard(
    this.cartItem, {
    super.key,
    this.decreaseQuantity,
    required this.increaseQuantity,
    this.heroTag,

  });

  @override
  State<CartItemCard> createState() => _CartItemState();
}

class _CartItemState extends State<CartItemCard> {
  late CartItem _cartItem;

  @override
  Widget build(BuildContext context) {
    _cartItem = widget.cartItem;
    return Row(
      children: [
        //Flexible(child: )
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(24),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.greenAccent[200],
                  borderRadius: BorderRadius.circular(26)),
              child: Center(
                  child: ItemImage(
                clipCorners: 24,
                heroTag: widget.heroTag,
                item: _cartItem.item,
                size: Size(120, 120),
              )),
            ),
          ],
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _cartItem.item?.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _cartItem.item?.cost ?? "0",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 30,
                    child: OutlinedButton(
                      onPressed: widget.decreaseQuantity,
                      clipBehavior: Clip.antiAlias,
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${_cartItem.quantity}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 40,
                    height: 32,
                    child: OutlinedButton(
                      onPressed: widget.increaseQuantity,
                      clipBehavior: Clip.antiAlias,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
