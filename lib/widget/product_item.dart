import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

// => describe  how to grid item look
class ProductItem extends StatelessWidget {
  //static const String ROUT_NAME = '/product-item';

  //======== changed with provider ==================

  // final String id;
  // final String title;
  // final String imagUrl;

  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imagUrl,
  // );

  //======== changed with provider ==================

  @override
  Widget build(BuildContext context) {
    // Thate is a common way to fetch data with provider and there is consumer method,
    final product = Provider.of<Product>(context, listen: false);
    final cartProvider = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.ROUT_NAME,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          // To mange Favorite product
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: product.toggleFavoritIcon, // Control favorite icon
            ),
          ),
          backgroundColor: Colors.grey.withOpacity(0.7),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cartProvider.addItem(
                productId: product.id,
                title: product.title,
                price: product.price,
              );
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added Item To Cart !'),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartProvider.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              // print(cartProvider.items);
            },
          ),
        ),
      ),
    );
  }
}
