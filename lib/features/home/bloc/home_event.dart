part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductCartButtonPressed extends HomeEvent {
  final ProductModel cartItem;

  HomeProductCartButtonPressed({required this.cartItem});
}

class HomeProductWishlistButtonPressed extends HomeEvent {
  final ProductModel wishlistItem;

  HomeProductWishlistButtonPressed({required this.wishlistItem});
}

class HomeCartButtonPressed extends HomeEvent {}

class HomeWishlistButtonPressed extends HomeEvent {}
