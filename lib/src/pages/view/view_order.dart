import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/controller/model_order_list.dart';
import 'package:shop_app/src/pages/components/widget_app_drawer.dart';
import 'package:shop_app/src/pages/components/widget_order.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerOrderList = Provider.of<OrderList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      // ignore: prefer_const_constructors
      drawer: AppDrawerWidget(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: providerOrderList.itemsCount,
              itemBuilder: (context, index) =>
                  OrderWidget(order: providerOrderList.items[index]),
            ),
    );
  }
}
