import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pace_up/domain/entities/cart_item.dart';

import '../../configs/images.dart';
import '../../domain/entities/item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final void Function(Item item, CartItem cartItem)? decreaseQuantity;
  final void Function(Item item, CartItem cartItem)? increaseQuantity;

  const CartItemCard(this.cartItem,
      {super.key, this.decreaseQuantity, this.increaseQuantity});

  @override
  Widget build(BuildContext context){
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
                    child: Image.asset(
                      cartItem.item?.image ?? "${AppImages.model_1}",
                      width: 140,
                    )))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.item?.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                NumberFormat.simpleCurrency().format(cartItem.item?.cost ?? 0),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24),
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
                      onPressed: () => decreaseQuantity,
                      clipBehavior: Clip.antiAlias,
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${cartItem.quantity}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 40,
                    height: 32,
                    child: OutlinedButton(
                      onPressed: () => increaseQuantity,
                      child: Icon(Icons.add),
                      clipBehavior: Clip.antiAlias,
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