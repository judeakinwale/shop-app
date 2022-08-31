// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/product.dart';
import 'product_Item.dart';
  
class ProductsGrid extends StatelessWidget {
  final bool showFavorites;
  
  ProductsGrid(this.showFavorites, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavorites ? productsData.favoriteItems : productsData.items;
    // final products = context.watch<Products>().items;  // alternative syntax
    // print('$productsData, $products');
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (context) => products[index],
        value: products[index],
        child: ProductItem(
          // products[index].id,
          // products[index].title, 
          // products[index].imageUrl,
        ),
      ),
    );
  }
}