part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartProductRemoveEvent extends CartEvent {
  final ProductModel cartItem;

  CartProductRemoveEvent({required this.cartItem});
}
