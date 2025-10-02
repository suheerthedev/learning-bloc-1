import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeCartButtonPressed>(_onNavigateCart);
    on<HomeWishlistButtonPressed>(_onNavigateWishlist);
  }

  FutureOr<void> _onNavigateCart(
    HomeCartButtonPressed event,
    Emitter<HomeState> emit,
  ) {
    debugPrint("onNavigate to Cart called!!!");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> _onNavigateWishlist(
    HomeWishlistButtonPressed event,
    Emitter<HomeState> emit,
  ) {
    debugPrint("onNavigate to Wishlist called!!!");
    emit(HomeNavigateToWishlistPageActionState());
  }
}
