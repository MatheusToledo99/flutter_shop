import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_product.dart';
import 'package:shop_app/models/model_product_list.dart';
import 'package:shop_app/widgets/widget_product_grid_item.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({Key? key, required this.showFavoriteOnly})
      : super(key: key);

  final bool showFavoriteOnly;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> product =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: product.length, // redenrizar a quant de produtos
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //maximo de elementos por linha (Eixo X)
        crossAxisSpacing: 10, //espacamentos entre os elementos (Eixo X)
        mainAxisSpacing: 10, //espacamentos entre os elementos (Eixo Y)
        childAspectRatio: 3 / 2, //proporção (tamanho)
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: product[index],
        // ignore: prefer_const_constructors
        child: ProductGridItemWidget(),
      ),
    );
  }
}
