import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/exceptions/http_exception.dart';
import 'package:shop_app/src/models/model_product.dart';

class ProductList with ChangeNotifier {
  ///////////////
  final List<Product> _items = [];
  List<Product> get items => [..._items];
  final _baseurl =
      'https://shop-matheus-71555-default-rtdb.firebaseio.com/produtos';

  //////////////

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems =>
      _items.where((element) => element.isFavorite).toList();

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasID = data['id'] != null;

    final product = Product(
      id: hasID ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasID) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_baseurl.json'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseurl/${product.id}.json'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Product product) async {
    if (product.isFavorite == false) {
      product.isFavorite = true;
    } else {
      product.isFavorite = false;
    }
    notifyListeners();

    await http.patch(
      Uri.parse('$_baseurl/${product.id}.json'),
      body: jsonEncode(
        {"isFavorite": product.isFavorite},
      ),
    );
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('$_baseurl/${product.id}.json'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
            'Não foi possível excluir o produto! ', response.statusCode);
      }
    }
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse('$_baseurl.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {
      _items.add(Product(
        id: key,
        name: value['name'],
        description: value['description'],
        price: value['price'].toDouble(),
        imageUrl: value['imageUrl'],
        isFavorite: value['isFavorite'],
      ));
    });

    notifyListeners();
  }
}
