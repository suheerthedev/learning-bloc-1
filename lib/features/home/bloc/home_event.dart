part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductCartButtonPressed extends HomeEvent {}

class HomeProductWishlistButtonPressed extends HomeEvent {}

class HomeCartButtonPressed extends HomeEvent {}

class HomeWishlistButtonPressed extends HomeEvent {}
