import 'package:flutter/material.dart';
import 'package:learning_bloc_1/features/cart/view/cart_page.dart';
import 'package:learning_bloc_1/features/home/view/home_page.dart';
import 'package:learning_bloc_1/features/wishlist/view/wishlist_page.dart';
import 'package:learning_bloc_1/router/routes.dart';

class AppRouter {
  dynamic onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => CartPage());
      case Routes.wishlistRoute:
        return MaterialPageRoute(builder: (_) => WishlistPage());
      default:
        return null;
    }
  }
}
