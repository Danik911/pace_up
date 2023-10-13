import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../../data/repositories/cart_repositoty.dart';
import '../../../../domain/entities/cart_item.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  static const int itemsPerPage = 20;

  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(const CartState.initial()) {
    on<CartItemLoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<CartItemIncrease>(_onIncreaseQuantity);
    on<CartItemDecrease>(_onDecreaseQuantity);
    on<CartItemAddToCart>(_onCartItemAddToCart);
    on<CartLoadMoreStarted>(
      _onCartLoadMoreStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void _onLoadStarted(CartItemLoadStarted event,
      Emitter<CartState> emit) async {
    try {
      emit(state.asLoading());
      final items = await _cartRepository.getAllCartItems();
      emit(state.asLoadSuccess(items));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onCartLoadMoreStarted(CartLoadMoreStarted event,
      Emitter<CartState> emit) async {
    try {
      if (!state.canLoadMore) return;

      emit(state.asLoadingMore());

      final cartItems = await _cartRepository.getItems(
        page: state.page + 1,
        limit: itemsPerPage,
      );
    }on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onDecreaseQuantity(CartItemDecrease event,
      Emitter<CartState> emit) async {
    try {
      final cartItemIndex = state.cartItems.indexWhere(
            (item) => item.id == event.cartItemId,
      );

      if (cartItemIndex < 0 || cartItemIndex >= state.cartItems.length) return;
      final cartItem = _cartRepository.getCartItem(event.cartItemId);
      if (cartItem == null) return;
      var cartItemsQuantity = cartItem.quantity ?? 1;
      final increasedCartItem = cartItem.copyWith(
          quantity: cartItemsQuantity++);


      emit(state.copyWith(
        cartItems: state.cartItems..setAll(cartItemIndex, [increasedCartItem]),
      ));
    } on Exception catch (e) {
      emit(state.asChangeQuantityFailure(e));
    }
  }

  void _onIncreaseQuantity(CartItemIncrease event,
      Emitter<CartState> emit) async {
    try {
      final cartItemIndex = state.cartItems.indexWhere(
            (item) => item.id == event.cartItemId,
      );

      if (cartItemIndex < 0 || cartItemIndex >= state.cartItems.length) return;
      final cartItem = _cartRepository.getCartItem(event.cartItemId);
      if (cartItem == null) return;
      var cartItemsQuantity = cartItem.quantity ?? 1;
      final increasedCartItem = cartItem.copyWith(
          quantity: cartItemsQuantity++);


      emit(state.copyWith(
        cartItems: state.cartItems..setAll(cartItemIndex, [increasedCartItem]),
      ));
    } on Exception catch (e) {
      emit(state.asChangeQuantityFailure(e));
    }
  }

  void _onCartItemAddToCart(CartItemAddToCart event,
      Emitter<CartState> emit) async {
    try {
      if (state.cartItems.contains(event.cartItem)) return;
      final cartItemToAdd = event.cartItem;
      _cartRepository.addCartItem(cartItemToAdd);
      final newCartItems = await _cartRepository.getAllCartItems();

      emit(state.asAddItemSuccess(newCartItems));
    } on Exception catch (e) {
      emit(state.asChangeQuantityFailure(e));
    }
  }

/*
  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartLoadingEvent) {
      yield* _mapCartUpdatedEventToState(event);
    } else if (event is ChangeQuantityCartItem) {
      yield* _mapCartChangeQuantitEventToState(event);
    } else if (event is RemoveCartItem) {
      yield* _mapRemoveCartItemEventToState(event);
    }
  }

  Stream<CartState> _mapCartUpdatedEventToState(CartEvent event) async* {
    var result = await _cartRepository.getAllCartItems();
    yield CartLoadFinished(result);
  }

  Stream<CartState> _mapCartChangeQuantitEventToState(
      ChangeQuantityCartItem event) async* {
    await _cartRepository.updateQuantity(event.product, event.value);
    var result = await _cartRepository.getCartItems();
    yield CartLoadFinished(result);
  }

  Stream<CartState> _mapRemoveCartItemEventToState(
      RemoveCartItem event) async* {
    await _cartRepository.removeCartItem(event.cartItem);
    var result = await _cartRepository.getCartItems();
    yield CartLoadFinished(result);
  }*/
}
