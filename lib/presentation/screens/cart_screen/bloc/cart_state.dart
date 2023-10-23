part of 'cart_bloc.dart';

enum CartStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  loadingMore,
  loadMoreSuccess,
  loadMoreFailure,
  deleteItem,
  deleteItemSuccess,
  addItem,
  addItemSuccess,
  increaseQuantitySuccess,
  decreaseQuantitySuccess,
  changeQuantityFailure,
  canLoadMore,
}

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartStateDefault extends CartState {
  final CartStateStatus status;
  final List<CartItem> cartItems;
  final int selectedCartItemIndex;
  final Exception? error;
  final bool canLoadMore;
  final int page;
  final Map<String, int> quantity;

  CartItem get selectedCartItem => cartItems[selectedCartItemIndex];

  CartStateDefault._(
      {this.status = CartStateStatus.initial,
      required this.cartItems,
      this.selectedCartItemIndex = 0,
      this.error,
      this.canLoadMore = true,
      this.page = 1,
      this.quantity = const {}});

  CartStateDefault.initial() : this._(cartItems: []);

  CartStateDefault asLoading() {
    return copyWith(
      status: CartStateStatus.loading,
    );
  }

  CartStateDefault asLoadSuccess(List<CartItem> cartItems) {
    return copyWith(
      status: CartStateStatus.loadSuccess,
      cartItems: cartItems,
    );
  }

  CartStateDefault asIncreaseQuantitySuccess(Map<String, int> quantity) {
    return copyWith(
        status: CartStateStatus.increaseQuantitySuccess, quantity: quantity);
  }

  CartStateDefault asDecreaseQuantitySuccess(Map<String, int> quantity) {
    return copyWith(
        status: CartStateStatus.decreaseQuantitySuccess, quantity: quantity);
  }

  CartStateDefault asLoadFailure(Exception e) {
    return copyWith(
      status: CartStateStatus.loadFailure,
      error: e,
    );
  }

  CartStateDefault asUpdateCartItems(List<CartItem> cartItems) {
    return copyWith(
      status: CartStateStatus.addItemSuccess,
      cartItems: cartItems,
    );
  }

  CartStateDefault asChangeQuantityFailure(Exception e) {
    return copyWith(
      status: CartStateStatus.changeQuantityFailure,
      error: e,
    );
  }

  CartStateDefault asLoadingMore() {
    return copyWith(status: CartStateStatus.loadingMore);
  }

  CartStateDefault asLoadMoreSuccess(List<CartItem> newItems) {
    return copyWith(
      status: CartStateStatus.loadMoreSuccess,
      cartItems: [...cartItems, ...newItems],
    );
  }

  CartStateDefault copyWith(
      {CartStateStatus? status,
      List<CartItem>? cartItems,
      int? selectedCartItemIndex,
      Exception? error,
      Map<String, int>? quantity}) {
    return CartStateDefault._(
        status: status ?? this.status,
        cartItems: cartItems ?? this.cartItems,
        selectedCartItemIndex:
            selectedCartItemIndex ?? this.selectedCartItemIndex,
        error: error ?? this.error,
        quantity: quantity ?? this.quantity);
  }

  @override
  List<Object> get props => [status, cartItems, quantity];
}

/*
abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInit extends CartState {}

class CartLoadFinished extends CartState {
  final List<CartItem> cart;

  CartLoadFinished(this.cart);

  @override
  List<Object> get props => [cart];
}*/
