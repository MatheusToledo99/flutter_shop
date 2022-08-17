// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_product_list.dart';
import 'package:shop_app/src/controller/cart.dart';
import 'package:shop_app/src/controller/order.dart';
import 'package:shop_app/src/pages/view/view_cart.dart';
import 'package:shop_app/src/pages/view/view_order.dart';
import 'package:shop_app/src/pages/view/view_product.dart';
import 'package:shop_app/src/pages/view/view_product_datail.dart';
import 'package:shop_app/src/pages/view/view_product_form.dart';
import 'package:shop_app/src/pages/view/view_product_overview.dart';
import 'package:shop_app/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartList(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Compras SimpleSoft',
        theme: ThemeData(
          fontFamily: 'Lato',
        ).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.deepOrange,
              ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (ctx) => ProductsOverView(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailView(),
          AppRoutes.CART: (ctx) => CartView(),
          AppRoutes.ORDER: (ctx) => OrderView(),
          AppRoutes.PRODUCTS: (ctx) => ProductView(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormView(),
        },
      ),
    );
  }
}
