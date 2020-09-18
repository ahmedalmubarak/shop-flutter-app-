import 'package:flutter/material.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('SHOP APP'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.ROUT_NAME),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.mode_edit),
            title: Text('Manage products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.ROUT_NAME),
          ),
        ],
      ),
    );
  }
}
