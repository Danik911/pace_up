import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'item.dart';

class CartItem {
  final String? id;
  int quantity;
  final Item? item;

  CartItem({this.id, this.quantity = 0, this.item});

  CartItem copyWith({String? id, int? quantity, Item? item}) {
    return CartItem(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        item: item ?? this.item);
  }

  @override
  bool operator ==(Object other) => other is CartItem && other.id == id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    return {'quantity': quantity, 'product_id': item?.id};
  }
}
