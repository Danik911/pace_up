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

class CartItemAddToCart extends CartEvent {
  final CartItem cartItem;

  const CartItemAddToCart({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

class CartItemIncrease extends CartEvent {
  final CartItem cartItem;

  const CartItemIncrease(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class CartItemDecrease extends CartEvent {
  final CartItem cartItem;

  const CartItemDecrease(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class CartLoadingEvent extends CartEvent {}

class RemoveCartItem extends CartEvent {
  final String cartItemId;

  RemoveCartItem(this.cartItemId);
}

class CartItemSelectChanged extends CartEvent {
  final String cartItemId;

  const CartItemSelectChanged({required this.cartItemId});
}

class CartItemChangeSum extends CartEvent {
  const CartItemChangeSum();

  @override
  List<Object> get props => [];
}
