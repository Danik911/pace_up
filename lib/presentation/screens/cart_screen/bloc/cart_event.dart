part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object> get props => [];
}

class CartItemLoadStarted extends CartEvent {
  final bool loadAll;

  const CartItemLoadStarted({this.loadAll = false});
}

class CartLoadMoreStarted extends CartEvent {}

class CartItemAddToCart extends CartEvent{
  final CartItem cartItem;

  const CartItemAddToCart({required this.cartItem});
}

class CartItemIncrease extends CartEvent {
  final String? cartItemId;

  const CartItemIncrease({this.cartItemId});
}

class CartItemDecrease extends CartEvent {
  final String? cartItemId;

  const CartItemDecrease({ this.cartItemId});
}


class CartItemUpdated extends CartEvent {
  final List<CartItem> cartItems;

  CartItemUpdated(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class CartLoadingEvent extends CartEvent {
}
class RemoveCartItem extends CartEvent {
  final String cartItemId;

  RemoveCartItem(this.cartItemId);


}

class ChangeQuantityCartItem extends CartEvent {
  final int quantity;
  final CartItem cartItem;

  ChangeQuantityCartItem(this.quantity, this.cartItem);

  @override
  List<Object> get props => [quantity, cartItem];
}

