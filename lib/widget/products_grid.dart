import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorite;
  ProductsGrid(this.showFavorite);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    // check if there  showFav is true return Favorites item else show all items
    final products =
        showFavorite ? productsData.favoriteItems : productsData.items;
    return productsData.items.isEmpty
        ? Center(
            child: Text('There is No Products Yet :)'),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              //builder: (ctx) => product[index] ==> replace with .value() constructor it's provide value prop. instead of create
              value: products[index],
              child: ProductItem(),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
