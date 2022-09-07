// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  const CartItem(this.id, this.productId, this.title, this.price, this.quantity,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cart = context.watch<Cart>();
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(productId),
      background: Container(
        color: Theme.of(context).errorColor,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to remove the item from cart?'),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('No')),
                  TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Yes')),
                ],
              )),
      onDismissed: (direction) => cart.removeItem(productId),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: ${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
