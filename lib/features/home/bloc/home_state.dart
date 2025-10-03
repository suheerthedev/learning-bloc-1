part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadSuccessState extends HomeState {
  final List<ProductModel> product;

  HomeLoadSuccessState({required this.product});
}

final class HomeErrorState extends HomeState {}

//Action State

final class HomeNavigateToWishlistPageActionState extends HomeActionState {}

final class HomeNavigateToCartPageActionState extends HomeActionState {}

final class HomeProductWishlistedActionState extends HomeActionState {}

final class HomeProductCartedActionState extends HomeActionState {}
