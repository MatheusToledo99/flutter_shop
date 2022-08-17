import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/src/models/model_order.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'R\$${widget.order.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(widget.order.date),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: const Icon(Icons.expand_more),
            ),
          ),
          if (_expanded == true)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              height: widget.order.products.length * 25,
              width: double.infinity,
              child: ListView(
                children: widget.order.products.map(
                  (product) {
                    return Material(
                      elevation: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.quantity}x R\$${product.price}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
