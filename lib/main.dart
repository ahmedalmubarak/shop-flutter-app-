import 'package:flutter/material.dart';
import 'package:my_shop/providers/order.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './screens/added_product_screen.dart';
import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/cart_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,
        fontFamily: 'Lato',
      ),
      routes: {
        '/': (ctx) => ProductsOverviewScreen(),
        ProductDetailScreen.ROUT_NAME: (ctx) => ProductDetailScreen(),
        CartScreen.ROUT_NAME: (ctx) => CartScreen(),
        OrdersScreen.ROUT_NAME: (ctx) => OrdersScreen(),
        UserProductsScreen.ROUT_NAME: (ctx) => UserProductsScreen(),
        AddingEditingScreen.ROUT_NAME: (ctx) => AddingEditingScreen(),
      },
    );
  }
}
