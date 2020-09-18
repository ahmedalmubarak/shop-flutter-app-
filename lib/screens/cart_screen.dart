import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widget/cart_item.dart';
import '../providers/order.dart';

class CartScreen extends StatelessWidget {
  static const ROUT_NAME = '/cartScreen';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartData.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addItem(
                        cartData.items.values.toList(),
                        double.parse(cartData.totalAmount),
                      );
                      cartData.clear();
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cartData.items.length,
                itemBuilder: (context, i) => CartItemWidget(
                    id: cartData.items.values.toList()[i].id,
                    productId: cartData.items.keys.toList()[i],
                    price: cartData.items.values.toList()[i].price,
                    title: cartData.items.values.toList()[i].title,
                    quantity: cartData.items.values.toList()[i].quantity)),
          ),
        ],
      ),
    );
  }
}
