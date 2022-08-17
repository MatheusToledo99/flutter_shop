// ignore_for_file: constant_identifier_names

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_product_list.dart';
import 'package:shop_app/src/controller/model_cart_list.dart';
import 'package:shop_app/src/pages/components/widget_app_drawer.dart';
import 'package:shop_app/src/pages/components/widget_product_grid.dart';
import 'package:shop_app/utils/app_routes.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverView extends StatefulWidget {
  const ProductsOverView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsOverView> createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<CartList>(
            builder: (context, cart, _) => Badge(
              alignment: Alignment.bottomLeft,
              position: BadgePosition.topEnd(top: 3, end: 3),
              badgeContent: Text(cart.itemsCount.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductGridWidget(showFavoriteOnly: _showFavoriteOnly),
      // ignore: prefer_const_constructors
      drawer: AppDrawerWidget(),
    );
  }
}
