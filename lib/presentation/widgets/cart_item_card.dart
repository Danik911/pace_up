import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_up/domain/entities/cart_item.dart';
import 'item_image.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;
  final void Function()? decreaseQuantity;
  final void Function() increaseQuantity;
  final String? heroTag;

  const CartItemCard(this.cartItem,
      {super.key, this.decreaseQuantity, required this.increaseQuantity, this.heroTag});



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
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(24),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(26)),
            ),
            Positioned(
                right: 0,
                bottom: 40,
                child: Center(
                    child: ItemImage(
                  heroTag: widget.heroTag,
                  item: _cartItem.item,
                  size: Size(25, 25),
                )))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
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
