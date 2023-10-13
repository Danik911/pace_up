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
  changeQuantityFailure,
  canLoadMore
}
class CartState {
  final CartStateStatus status;
  final List<CartItem> cartItems;
  final int selectedCartItemIndex;
  final Exception? error;
  final bool canLoadMore;
  final int page;


  CartItem get selectedCartItem => cartItems[selectedCartItemIndex];

  const CartState._({
    this.status = CartStateStatus.initial,
    this.cartItems = const [],
    this.selectedCartItemIndex = 0,
    this.error,
    this.canLoadMore = true,
    this.page = 1,
  });

  const CartState.initial() : this._();

  CartState asLoading() {
    return copyWith(
      status: CartStateStatus.loading,
    );
  }

  CartState asLoadSuccess(List<CartItem> cartItems) {
    return copyWith(
      status: CartStateStatus.loadSuccess,
      cartItems: cartItems,
    );
  }

  CartState asLoadFailure(Exception e) {
    return copyWith(
      status: CartStateStatus.loadFailure,
      error: e,
    );
  }
  CartState asAddItemSuccess(List<CartItem> cartItems) {
    return copyWith(
      status: CartStateStatus.addItemSuccess,
      cartItems: cartItems,
    );
  }
  CartState asChangeQuantityFailure(Exception e) {
    return copyWith(
      status: CartStateStatus.changeQuantityFailure,
      error: e,
    );
  }

  CartState asLoadingMore() {
    return copyWith(status: CartStateStatus.loadingMore);
  }

  CartState asLoadMoreSuccess(List<CartItem> newItems) {
    return copyWith(
      status: CartStateStatus.loadMoreSuccess,
      cartItems: [...cartItems, ...newItems],
    );
  }


  CartState copyWith({
    CartStateStatus? status,
    List<CartItem>? cartItems,
    int? selectedCartItemIndex,
    Exception? error,
  }) {
    return CartState._(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      selectedCartItemIndex: selectedCartItemIndex ?? this.selectedCartItemIndex,
      error: error ?? this.error,
    );
  }
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
