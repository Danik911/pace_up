
import 'package:pace_up/data/source/mappers/ext_on_hive_model.dart';

import '../../domain/entities/cart_item.dart';
import '../source/local/local_data_source.dart';

abstract class CartRepository {
  List<CartItem> getAllCartItems();
  //void decreaseCartItems(String cartItemId);
  //void increaseCartItems(String cartItemId);
  void addCartItem(CartItem cartItem);
  void deleteCartItem(String? cartItemId);
  CartItem? getCartItem(String? cartItemId);
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
  void addCartItem(CartItem cartItem) {
    localDataSource.addCartItem(cartItem);
  }

  @override
  void deleteCartItem(String? cartItemId) {
    localDataSource.deleteCartItem(cartItemId);
  }

  @override
  CartItem? getCartItem(String? cartItemId) {
    return localDataSource.getCartItem(cartItemId);
  }
}
