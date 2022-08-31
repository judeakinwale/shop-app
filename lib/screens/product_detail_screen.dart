// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  
  // const ProductDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments;
    final productsData = Provider.of<Products>(context, listen: false);
    final loadedProduct = productsData.findById(productId as String);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: Center(child: Text('Product Details')),
    );
  }
}
