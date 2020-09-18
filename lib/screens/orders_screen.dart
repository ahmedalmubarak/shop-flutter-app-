import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../widget/app_drawer.dart';
import '../widget/oder_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String ROUT_NAME = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, i) {
          return OrderItemWidget(
            orderItem: ordersData.orders[i],
          );
        },
      ),
    );
  }
}
