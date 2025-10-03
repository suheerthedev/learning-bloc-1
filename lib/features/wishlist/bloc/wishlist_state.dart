part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

sealed class WishlistActionState extends WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistLoadSuccessState extends WishlistState {
  final List<ProductModel> wishlistItems;

  WishlistLoadSuccessState({required this.wishlistItems});
}

final class WishlistEmptyState extends WishlistState {}

final class WishlistErrorState extends WishlistState {}

//Action States

final class WishlistProductRemovedActionState extends WishlistActionState {}

final class WishlistProductRemovedErrorActionState
    extends WishlistActionState {}
