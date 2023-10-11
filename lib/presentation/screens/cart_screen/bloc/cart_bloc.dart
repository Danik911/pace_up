import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/repositories/cart_repositoty.dart';
import '../../../../domain/entities/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(const CartState.initial()){
    on<CartItemLoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<ItemLoadMoreStarted>(
      _onLoadMoreStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<ItemSelectChanged>(_onSelectChanged);
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
