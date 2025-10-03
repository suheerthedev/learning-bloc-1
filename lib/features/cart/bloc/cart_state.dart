part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

sealed class CartActionState extends CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartLoadSuccessState extends CartState {
  final List<ProductModel> cartItems;

  CartLoadSuccessState({required this.cartItems});
}

final class CartErrorState extends CartState {}

final class CartEmptyState extends CartState {}

//Action States

final class CartProductRemovedActionState extends CartActionState {}

final class CartProductRemovedErrorActionState extends CartActionState {}
