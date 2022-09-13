// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/order_items.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  // const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetorders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<Orders>(
              builder: (context, value, child) => ListView.builder(
                // value is the same as orderData, but using Consumer instead
                itemCount: value.orders.length,
                itemBuilder: (context, index) => OrderItem(value.orders[index]),
              ),
            );
          }
        },
      ),
      // body: ListView.builder(
      //     itemCount: orderData.orders.length,
      //     itemBuilder: (context, index) => OrderItem(orderData.orders[index])),
    );
  }
}
