import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

// describe product detail
class ProductDetailScreen extends StatelessWidget {
  static const String ROUT_NAME = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;

    final loadedData = Provider.of<Products>(context, listen: false)
        .findById(productId); // fetch specifics product with ID

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedData.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //margin: EdgeInsets.all(8.0),
              height: 200,
              width: double.infinity,
              child: Image.network(
                loadedData.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.0),
            Chip(label: Text('\$${loadedData.price}')),
            SizedBox(height: 10.0),
            Chip(label: Text('${loadedData.description}'))
          ],
        ),
      ),
    );
  }
}
