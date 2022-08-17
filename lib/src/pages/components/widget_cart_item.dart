import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/controller/model_cart_list.dart';
import 'package:shop_app/src/models/model_cart.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  final Cart cartItem;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartList>(context);

    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete_sweep_rounded,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Tem certeza?'),
                  content: const Text('Deseja remover o item do carrinho?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Não')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Sim'))
                  ],
                ));
      },
      onDismissed: (_) {
        provider.removeItem(cartItem.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('${cartItem.price}'),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}
