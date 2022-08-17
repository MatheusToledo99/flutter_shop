import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_product_list.dart';
import 'package:shop_app/src/pages/components/widget_app_drawer.dart';
import 'package:shop_app/src/pages/components/widget_product_item.dart';
import 'package:shop_app/utils/app_routes.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      // ignore: prefer_const_constructors
      drawer: AppDrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: [
              ProductItemWidget(product: products.items[index]),
              const Divider(),
            ],
          ),
          itemCount: products.itemsCount,
        ),
      ),
    );
  }
}
