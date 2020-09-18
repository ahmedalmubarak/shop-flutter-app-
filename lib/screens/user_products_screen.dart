import 'package:flutter/material.dart';
import 'package:my_shop/screens/added_product_screen.dart';
import '../widget/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widget/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const String ROUT_NAME = '/user-products';

  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddingEditingScreen.ROUT_NAME);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  id: productData.items[i].id,
                  title: productData.items[i].title,
                  imageUrl: productData.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
    );
  }
}
