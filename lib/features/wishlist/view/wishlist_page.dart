import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc_1/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:learning_bloc_1/features/wishlist/widgets/wishlist_product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Wishlist Page', style: TextStyle(color: Colors.white)),
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
      body: SafeArea(
        child: BlocConsumer(
          bloc: wishlistBloc,
          listenWhen: (previous, current) => current is WishlistActionState,
          buildWhen: (previous, current) => current is! WishlistActionState,
          listener: (context, state) {
            if (state is WishlistProductRemovedActionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Product Removed Successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is WishlistProductRemovedErrorActionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error in removing product"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case WishlistLoadingState:
                return Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                );

              case WishlistErrorState:
                return Center(
                  child: Text("Erorr in loading wishlist products"),
                );
              case WishlistEmptyState:
                return Center(child: Text("No Wishlisted Products Found"));
              case WishlistLoadSuccessState:
                final successState = state as WishlistLoadSuccessState;
                return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    final wishlistItem = successState.wishlistItems[index];
                    return WishlistProductCard(
                      wishlistItem: wishlistItem,
                      wishlistBloc: wishlistBloc,
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
