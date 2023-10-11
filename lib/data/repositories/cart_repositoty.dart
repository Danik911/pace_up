
import 'package:pace_up/data/source/mappers/ext_on_hive_model.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/item.dart';
import '../source/local/local_data_source.dart';

abstract class CartRepository {
  List<CartItem> getAllCartItems();
  void deleteCartItem(String id);
  void addCartItem(Item item);
}

class CartDefaultRepository extends CartRepository {
  CartDefaultRepository(
      {required this.localDataSource});

  final LocalDataSource localDataSource;

  @override
  List<CartItem> getAllCartItems()  {

    final itemEntities = localDataSource.cart;
    return itemEntities;

  }

  @override
  void deleteCartItem(String id) async {
    localDataSource.deleteCartItem(id);
  }

  @override
  void addCartItem(Item item) {
    localDataSource.addCartItem(item.toCartItem());
  }
}
