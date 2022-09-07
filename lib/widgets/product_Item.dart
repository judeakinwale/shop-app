// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_local_variable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // const ProductItem(this.id,this.title, this.imageUrl, {Key? key})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              color: secondaryColor,
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
            // child: IconButton(
            //   color: secondaryColor,
            //   icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border ),
            //   onPressed: () {
            //     product.toggleFavoriteStatus();
            //   },
            // ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            color: secondaryColor,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItems(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Added Item to Cart!'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () => cart.removeItem(product.id),
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
