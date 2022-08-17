import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/controller/cart.dart';
import 'package:shop_app/src/controller/order.dart';
import 'package:shop_app/src/pages/components/widget_cart_item.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartList>(context);
    final providerOrderList = Provider.of<OrderList>(context, listen: false);

    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              ?.color),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: cart.itemsCount == 0
                        ? null
                        : () {
                            providerOrderList.addOrder(cart);
                            cart.clear();
                            //Navigator.of(context).pushNamed(AppRoutes.ORDER);
                          },
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: const Text('Comprar'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: ((context, index) =>
                  CartItemWidget(cartItem: items[index])),
            ),
          ),
        ],
      ),
    );
  }
}
