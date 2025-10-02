import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc_1/features/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.pushNamed(context, '/cart');
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.pushNamed(context, '/wishlist');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
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
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 280,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 20),
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
