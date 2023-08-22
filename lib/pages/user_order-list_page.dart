import 'package:flutter/material.dart';
import 'package:ownshoppers_user/auth/auth_service.dart';
import 'package:ownshoppers_user/pages/order_details_page.dart';
import 'package:ownshoppers_user/provider/order_provider.dart';
import 'package:ownshoppers_user/utils/DBHelper_Function.dart';
import 'package:provider/provider.dart';

class UserOrderListPage extends StatefulWidget {
  static const String routeName = '/user_order_list';

  @override
  State<UserOrderListPage> createState() => _UserOrderListPageState();
}

class _UserOrderListPageState extends State<UserOrderListPage> {

  late OrderProvider _orderProvider;
  @override
  void didChangeDependencies() {
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getUserOrder(AuthService.currentUser!.uid);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Order'),
      ),
      body: ListView.builder(
        itemCount: _orderProvider.userOrderList.length,
          itemBuilder: (context, index){
          final order = _orderProvider.userOrderList[index];
          return ListTile(
            onTap: () => Navigator.pushNamed(context, OrderDetailsPage.routeName,arguments: order.orderId),
            title: Text(getFormattedDate(order.timestamp.millisecondsSinceEpoch, 'dd/MM/yy hh:mm a')),
            trailing: Text(order.orderStatus),
          );
          }),
    );
  }
}
