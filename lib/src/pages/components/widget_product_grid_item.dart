import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_product_list.dart';
import 'package:shop_app/src/controller/model_cart_list.dart';
import 'package:shop_app/src/models/model_product.dart';
import 'package:shop_app/utils/app_routes.dart';

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartList>(context);
    final productList = Provider.of<ProductList>(context, listen: false);

    //ClipRRect é somente para cortar de forma arredondada cada elemento
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        footer: GridTileBar(
          //"pé" de uma Grid individual
          title: Text(
            textAlign: TextAlign.center,
            product.name,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              //inicio
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                productList.toggleFavorite(product);
              },
            ),
          ),
          trailing: IconButton(
            //fim
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Produto adicionado com sucesso'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'DESFAZER',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      }),
                ),
              );
              cart.addItem(product);
            },
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        ),
      ),
    );
  }
}
