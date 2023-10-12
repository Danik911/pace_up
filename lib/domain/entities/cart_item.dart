import 'item.dart';

class CartItem {
  final String? id;
  int? quantity;
  Item? item;

  CartItem({this.id, this.quantity, this.item});

  CartItem copyWith({String? id, int? quantity, Item? item}) {
    return CartItem(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        item: item ?? this.item);
  }

  Map<String, dynamic> toMap() {
    return {'quantity': quantity, 'product_id': item?.id};
  }
}
