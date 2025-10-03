import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc_1/features/home/bloc/home_bloc.dart';
import 'package:learning_bloc_1/features/home/widgets/product_card.dart';
import 'package:learning_bloc_1/router/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Suheer Grocery App',
          style: TextStyle(color: Colors.white),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
        actions: [
          IconButton(
            onPressed: () {
              homeBloc.add(HomeCartButtonPressed());
            },
            icon: Icon(Icons.shopping_cart_outlined),
            color: Colors.white,
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              homeBloc.add(HomeWishlistButtonPressed());
            },
            icon: Icon(Icons.favorite_border),
            color: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listenWhen: (previous, current) => current is HomeActionState,
          buildWhen: (previous, current) => current is! HomeActionState,
          listener: (context, state) {
            if (state is HomeNavigateToCartPageActionState) {
              Navigator.pushNamed(context, Routes.cartRoute);
            } else if (state is HomeNavigateToWishlistPageActionState) {
              Navigator.pushNamed(context, Routes.wishlistRoute);
            } else if (state is HomeProductCartedActionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product Carted!'),
                  duration: Duration(milliseconds: 300),
                ),
              );
            } else if (state is HomeProductWishlistedActionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product Wishlisted!'),
                  duration: Duration(milliseconds: 300),
                ),
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case HomeLoadingState:
                return Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                );
              case HomeErrorState:
                return Center(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(color: Colors.red),
                    child: Center(
                      child: Text(
                        "Error",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                );
              case HomeLoadSuccessState:
                final successState = state as HomeLoadSuccessState;
                return ListView.builder(
                  itemCount: successState.product.length,
                  itemBuilder: (context, index) {
                    final product = successState.product[index];
                    return ProductCard(product: product, homeBloc: homeBloc);
                  },
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
