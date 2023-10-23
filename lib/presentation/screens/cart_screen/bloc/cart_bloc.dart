import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../../data/repositories/cart_repositoty.dart';
import '../../../../domain/entities/cart_item.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartStateDefault> {
  static const int itemsPerPage = 20;

  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(CartStateDefault.initial()) {
    on<CartItemLoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<CartItemUpdated>(_onCartItemUpdated);
    on<CartItemIncrease>(_onIncreaseQuantity);
    on<CartItemDecrease>(_onDecreaseQuantity);
    on<CartItemAddToCart>(_onCartItemAddToCart);
    on<CartLoadMoreStarted>(
      _onCartLoadMoreStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void _onCartItemUpdated(
      CartItemUpdated event, Emitter<CartStateDefault> emit) async {
    try {
      emit(state.asLoading());
      final items = await _cartRepository.getAllCartItems();
      emit(state.asUpdateCartItems(items));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onLoadStarted(
      CartItemLoadStarted event, Emitter<CartStateDefault> emit) async {
    try {
      emit(state.asLoading());
      final items = await _cartRepository.getAllCartItems();
      emit(state.asLoadSuccess(items));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onCartLoadMoreStarted(
      CartLoadMoreStarted event, Emitter<CartStateDefault> emit) async {
    try {
      if (!state.canLoadMore) return;

      emit(state.asLoadingMore());

      final cartItems = await _cartRepository.getItems(
        page: state.page + 1,
        limit: itemsPerPage,
      );
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onIncreaseQuantity(
      CartItemIncrease event, Emitter<CartStateDefault> emit) async {
    try {
      final cartItemIndex =
          state.cartItems.indexWhere((item) => item.id == event.cartItem.id);

      if (cartItemIndex < 0 || cartItemIndex >= state.cartItems.length) return;

      final cartItem = state.cartItems[cartItemIndex];
      if (cartItem.id == null) return;
      var increasedItem = await {cartItem.id!: cartItem.quantity++};
      print(increasedItem);
      emit(state.asIncreaseQuantitySuccess(increasedItem));
    } on Exception catch (e) {
      emit(state.asChangeQuantityFailure(e));
    }
  }

  void _onDecreaseQuantity(
      CartItemDecrease event, Emitter<CartStateDefault> emit) async {
    try {
      final cartItemIndex =
          state.cartItems.indexWhere((item) => item.id == event.cartItem.id);

      if (cartItemIndex < 0 || cartItemIndex >= state.cartItems.length) return;

      final cartItem = state.cartItems[cartItemIndex];
      if (cartItem.id == null) return;
      var decreasedItem = await {cartItem.id!: cartItem.quantity--};
      print(decreasedItem);
      if (decreasedItem.values.first <= 1) {
        state.cartItems
            .removeWhere((element) => element.id == event.cartItem.id);
        emit(state.asUpdateCartItems(state.cartItems));
      } else {
        emit(state.asDecreaseQuantitySuccess(decreasedItem));
      }
    } on Exception catch (e) {
      emit(state.asChangeQuantityFailure(e));
    }
  }

  void _onCartItemAddToCart(
      CartItemAddToCart event, Emitter<CartStateDefault> emit) async {
    try {
      if (state.cartItems.contains(event.cartItem)) return;
      final cartItemToAdd = event.cartItem.copyWith(quantity: 1);
      state.cartItems.add(cartItemToAdd);
      final newCartItems = state.cartItems;

      emit(state.asUpdateCartItems(newCartItems));
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
