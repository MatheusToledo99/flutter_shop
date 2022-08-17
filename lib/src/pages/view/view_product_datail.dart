import 'package:flutter/material.dart';
import 'package:shop_app/src/models/model_product.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;

    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              height: altura * 0.5,
              width: largura,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              'R\$${product.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 30,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: largura,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }
}
