// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          AppBar(
            title: Text('Hello!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop'),
              onTap: () => Navigator.of(context).pushNamed('/')),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text('Orders'),
              onTap: () =>
                  Navigator.of(context).pushNamed(OrdersScreen.routeName)),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () =>
                  Navigator.of(context).pushNamed(UserProductScreen.routeName)),
          Divider(),
        ],
      ),
    );
  }
}
