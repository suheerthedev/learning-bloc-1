import 'package:flutter/material.dart';
import 'package:learning_bloc_1/data/models/product_model.dart';
import 'package:learning_bloc_1/features/wishlist/bloc/wishlist_bloc.dart';

class WishlistProductCard extends StatelessWidget {
  final ProductModel wishlistItem;
  final WishlistBloc wishlistBloc;
  const WishlistProductCard({
    super.key,
    required this.wishlistItem,
    required this.wishlistBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(wishlistItem.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      wishlistItem.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$ ${wishlistItem.price}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    wishlistBloc.add(
                      WishlistProductRemovedEvent(wishlistItem: wishlistItem),
                    );
                  },
                  icon: Icon(Icons.favorite_border),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
