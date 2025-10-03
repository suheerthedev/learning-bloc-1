import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:learning_bloc_1/data/cart_items.dart';
import 'package:learning_bloc_1/data/grocery_data.dart';
import 'package:learning_bloc_1/data/models/product_model.dart';
import 'package:learning_bloc_1/data/wishlist_items.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_init);
    on<HomeCartButtonPressed>(_onNavigateCart);
    on<HomeWishlistButtonPressed>(_onNavigateWishlist);
    on<HomeProductCartButtonPressed>(_onProductCart);
    on<HomeProductWishlistButtonPressed>(_onProductWishlist);
  }

  FutureOr<void> _onNavigateCart(
    HomeCartButtonPressed event,
    Emitter<HomeState> emit,
  ) {
    debugPrint("onNavigate to Cart called!!!");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> _init(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(
      HomeLoadSuccessState(
        product: GroceryData.groceryItems
            .map((product) => ProductModel.fromJson(product))
            .toList(),
      ),
    );
  }

  FutureOr<void> _onNavigateWishlist(
    HomeWishlistButtonPressed event,
    Emitter<HomeState> emit,
  ) {
    debugPrint("onNavigate to Wishlist called!!!");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> _onProductCart(
    HomeProductCartButtonPressed event,
    Emitter<HomeState> emit,
  ) {
    cartItems.add(event.cartItem);
    emit(HomeProductCartedActionState());
  }

  FutureOr<void> _onProductWishlist(
    HomeProductWishlistButtonPressed event,
    Emitter<HomeState> emit,
  ) {
    wishlist.add(event.wishlistItem);
    emit(HomeProductWishlistedActionState());
  }
}
