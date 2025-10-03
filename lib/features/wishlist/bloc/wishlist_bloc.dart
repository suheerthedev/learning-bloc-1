import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learning_bloc_1/data/models/product_model.dart';
import 'package:learning_bloc_1/data/wishlist_items.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(_init);
    on<WishlistProductRemovedEvent>(_onRemoved);
  }

  FutureOr<void> _init(
    WishlistInitialEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoadingState());
    await Future.delayed(Duration(seconds: 3));

    if (wishlist.isNotEmpty) {
      emit(WishlistLoadSuccessState(wishlistItems: wishlist));
    } else {
      emit(WishlistEmptyState());
    }
  }

  FutureOr<void> _onRemoved(
    WishlistProductRemovedEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoadingState());
    await Future.delayed(Duration(seconds: 3));
    if (wishlist.contains(event.wishlistItem)) {
      wishlist.remove(event.wishlistItem);
      emit(WishlistProductRemovedActionState());
      if (wishlist.isNotEmpty) {
        emit(WishlistLoadSuccessState(wishlistItems: wishlist));
      } else {
        emit(WishlistEmptyState());
      }
    } else {
      emit(WishlistProductRemovedErrorActionState());
      emit(WishlistErrorState());
    }
  }

  // @override
  // WishlistState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final raw = json['items'] as List<dynamic>? ?? const [];
  //     final items = raw.map((e) => ProductModel.fromJson(e)).toList();
  //     if (items.isEmpty) return WishlistEmptyState();
  //     return WishlistLoadSuccessState(wishlistItems: items);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(WishlistState state) {
  //   if (state is WishlistLoadSuccessState) {
  //     return {'items': state.wishlistItems.map((e) => e.toJson()).toList()};
  //   }
  //   if (state is WishlistEmptyState) {
  //     return {'items': <dynamic>[]};
  //   }
  //   return null;
  // }
}
