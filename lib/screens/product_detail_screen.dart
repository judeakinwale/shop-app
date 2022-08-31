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
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover,),
            ),
            SizedBox(height: 20,),
            Text('\$${loadedProduct.price}', style: TextStyle(color: Colors.blueGrey, fontSize: 20), textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Container(
              height: 300,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Text(loadedProduct.description, textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }
}
