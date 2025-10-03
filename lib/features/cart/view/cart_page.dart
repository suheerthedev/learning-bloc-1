import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc_1/features/cart/bloc/cart_bloc.dart';
import 'package:learning_bloc_1/features/cart/widgets/cart_product_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Cart Page', style: TextStyle(color: Colors.white)),
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
      body: SafeArea(
        child: BlocConsumer(
          bloc: cartBloc,
          listenWhen: (previous, current) => current is CartActionState,
          buildWhen: (previous, current) => current is! CartActionState,
          listener: (context, state) {
            if (state is CartProductRemovedActionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product Removed From Cart!'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is CartProductRemovedErrorActionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error in removing product!'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartLoadingState:
                return Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                );
              case CartEmptyState:
                return Center(child: Text("No Cart Items Added Yet"));
              case CartErrorState:
                return Center(child: Text("Something went wrong"));
              case CartLoadSuccessState:
                final successState = state as CartLoadSuccessState;
                return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = successState.cartItems[index];
                    return CartProductCard(
                      cartItem: cartItem,
                      cartBloc: cartBloc,
                    );
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
