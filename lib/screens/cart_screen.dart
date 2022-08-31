// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartSCreen extends StatelessWidget {
  // const CartSCreen({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Order>(context);
    final cartItemsList = cart.items.values.toList();
    final cartKeyList = cart.items.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  // SizedBox(width: 10),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6?.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  // FlatButton(
                  TextButton(
                    onPressed: () {
                      order.addOrder(cartItemsList, cart.totalAmount);
                      cart.clear();
                    },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (BuildContext context, int index) {
                return CartItem(
                  cartItemsList[index].id,
                  cartKeyList[index],
                  cartItemsList[index].title,
                  cartItemsList[index].price,
                  cartItemsList[index].quantity,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
