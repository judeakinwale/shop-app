// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/order_items.dart';

import '../providers/orders.dart' show Order;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  // const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) => OrderItem(orderData.orders[index])),
    );
  }
}
