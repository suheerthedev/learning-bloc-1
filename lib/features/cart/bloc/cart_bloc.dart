import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:learning_bloc_1/data/cart_items.dart';
import 'package:learning_bloc_1/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(_init);
    on<CartProductRemoveEvent>(_onRemoved);
  }

  FutureOr<void> _init(CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(Duration(seconds: 3));

    if (cartItems.isNotEmpty) {
      emit(CartLoadSuccessState(cartItems: cartItems));
    } else {
      emit(CartEmptyState());
    }
  }

  FutureOr<void> _onRemoved(
    CartProductRemoveEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    await Future.delayed(Duration(seconds: 3));
    if (cartItems.contains(event.cartItem)) {
      cartItems.remove(event.cartItem);
      emit(CartProductRemovedActionState());
      if (cartItems.isNotEmpty) {
        emit(CartLoadSuccessState(cartItems: cartItems));
      } else {
        emit(CartEmptyState());
      }
    } else {
      emit(CartProductRemovedErrorActionState());
      emit(CartErrorState());
    }
  }

  // @override
  // CartState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final raw = json['items'] as List<dynamic>? ?? const [];
  //     final items = raw.map((e) => ProductModel.fromJson(e)).toList();
  //     if (items.isEmpty) return CartEmptyState();
  //     return CartLoadSuccessState(cartItems: items);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(CartState state) {
  //   if (state is CartLoadSuccessState) {
  //     return {'items': state.cartItems.map((e) => e.toJson()).toList()};
  //   }
  //   if (state is CartEmptyState) {
  //     return {'items': <dynamic>[]};
  //   }
  //   return null;
  // }
}
