import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop_app/models/model_cart.dart';
import 'package:shop_app/models/model_product.dart';

class CartList with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (value) => Cart(
          id: value.id,
          productId: value.productId,
          name: value.name,
          quantity: value.quantity + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => Cart(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total = total + (value.price * value.quantity);
    });
    return total;
  }

  void removeSingleItem(String productId) {
    if (_items.containsKey(productId) == false) {
      return;
    } else if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (value) => Cart(
          id: value.id,
          productId: value.productId,
          name: value.name,
          quantity: value.quantity - 1,
          price: value.price,
        ),
      );
    }
    notifyListeners();
  }
}
