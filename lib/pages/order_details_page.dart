import 'package:flutter/material.dart';
import 'package:ownshoppers_user/provider/cart_provider.dart';
import 'package:ownshoppers_user/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName = '/order_detail_page';

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String ? orderId;
  late OrderProvider _orderProvider;
  @override
  void didChangeDependencies() {
    orderId = ModalRoute.of(context)!.settings.arguments as String;
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getOrderDetails(orderId!);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details '),
      ),
      body:  ListView.builder(
          itemCount: _orderProvider.orderDetailList.length,
          itemBuilder: (context, index){
            final details = _orderProvider.orderDetailList[index];
            final order = _orderProvider.userOrderList[index];
            return ListTile(
              title: Text(details.productName),
              subtitle:  Text('total : ${order.grandTotal}'),
              trailing: Text('${details.Quentity} * ${details.price}'),
            );
          }),

      );

  }
}
