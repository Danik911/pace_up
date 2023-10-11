
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_up/domain/entities/cart_item.dart';
import 'package:pace_up/presentation/screens/cart_screen/bloc/cart_bloc.dart';


class CartItemStateSelector<T> extends BlocSelector<CartBloc, CartState, T> {
  CartItemStateSelector({super.key,
    required T Function(CartState) selector,
    required Widget Function(T) builder,
  }) : super(
    selector: selector,
    builder: (_, value) => builder(value),
  );
}

class CartItemStateStatusSelector extends CartItemStateSelector<CartStateStatus> {
  CartItemStateStatusSelector(Widget Function(CartStateStatus) builder, {super.key})
      : super(
    selector: (state) => state.status,
    builder: builder,
  );
}


class NumberOfCartItemsSelector extends CartItemStateSelector<int> {
  NumberOfCartItemsSelector(Widget Function(int) builder, {super.key})
      : super(
    selector: (state) => state.cartItems.length,
    builder: builder,
  );
}

class CurrentCartItemSelector extends CartItemStateSelector<CartItem> {
  CurrentCartItemSelector(Widget Function(CartItem) builder, {super.key})
      : super(
    selector: (state) => state.selectedCartItem,
    builder: builder,
  );
}

class CartItemSelector extends CartItemStateSelector<CartItemSelectorState> {
  CartItemSelector(int index, Widget Function(CartItem, bool) builder, {super.key})
      : super(
    selector: (state) => CartItemSelectorState(
      state.cartItems[index],
      state.selectedCartItemIndex == index,
    ),
    builder: (value) => builder(value.cartItem, value.selected),
  );
}

class CartItemSelectorState {
  final CartItem cartItem;
  final bool selected;

  const CartItemSelectorState(this.cartItem, this.selected);

  @override
  bool operator ==(Object other) =>
      other is CartItemSelectorState && cartItem == other.cartItem && selected == other.selected;
}