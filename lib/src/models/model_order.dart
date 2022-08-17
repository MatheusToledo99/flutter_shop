import 'package:shop_app/src/models/model_cart.dart';

class Order {
  final String id;
  final double total;
  final List<Cart> products;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}
