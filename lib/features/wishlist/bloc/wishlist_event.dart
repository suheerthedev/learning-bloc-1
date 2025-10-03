part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistProductRemovedEvent extends WishlistEvent {
  final ProductModel wishlistItem;

  WishlistProductRemovedEvent({required this.wishlistItem});
}
