import 'cart_item.dart';

class Item {
  final String id;
  final String name;
  final String description;
  final String image;
  final String cost;

  const Item(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.cost});
}

extension CartOnItemX on Item {
  CartItem toCartItem() => CartItem(
        id: id ?? '',
        item: this,
      );
}
