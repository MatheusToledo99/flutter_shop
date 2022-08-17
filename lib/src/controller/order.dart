import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop_app/src/controller/cart.dart';
import 'package:shop_app/src/models/model_cart.dart';
import 'package:shop_app/src/models/model_order.dart';

class OrderList with ChangeNotifier {
  final _baseurl =
      'https://shop-matheus-71555-default-rtdb.firebaseio.com/orders';

  // ignore: prefer_final_fields
  List<Order> _itemsPedido = [];

  List<Order> get items {
    return [..._itemsPedido];
  }

  int get itemsCount {
    return _itemsPedido.length;
  }

  Future<void> addOrder(CartList cartList) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('$_baseurl.json'),
      body: jsonEncode(
        {
          'total': cartList.totalAmount,
          'date': date.toIso8601String(),
          'products': cartList.items.values
              .map(
                // ignore: non_constant_identifier_names
                (Cart Cart) => {
                  'id': Cart.id,
                  'productId': Cart.productId,
                  'name': Cart.name,
                  'quantity': Cart.quantity,
                  'price': Cart.price,
                },
              )
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _itemsPedido.insert(
      0,
      Order(
        id: id,
        total: cartList.totalAmount,
        products: cartList.items.values.toList(),
        date: date,
      ),
    );

    notifyListeners();
  }

  Future<void> loadOrders() async {
    _itemsPedido.clear();
    final response = await http.get(Uri.parse('$_baseurl.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {
      _itemsPedido.add(Order(
        id: key,
        date: DateTime.parse(value['date']),
        total: value['total'].toDouble(),
        products: (value['products'] as List<dynamic>).map((item) {
          return Cart(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'],
              price: item['price'].toDouble());
        }).toList(),
      ));
    });

    notifyListeners();
  }
}
