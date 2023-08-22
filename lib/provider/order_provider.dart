import 'package:flutter/material.dart';
import 'package:ownshoppers_user/db/DB_Helper.dart';
import 'package:ownshoppers_user/models/cart_model.dart';
import 'package:ownshoppers_user/models/order_model.dart';
import 'package:ownshoppers_user/models/order_model2.dart';

class OrderProvider with ChangeNotifier {
  OrderModel orderModel = OrderModel();

  List<OrderModel2> userOrderList = [];
  List<CartModel> orderDetailList = [];

  void getOrderDetails(String orderId) async{
    DBHelper.fetchAllOrdersDetails(orderId).listen((event) {
      orderDetailList = List.generate(event.docs.length, (index) => CartModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void getUserOrder(String userId) async{
    DBHelper.fetchAllOrdersByUserId(userId).listen((event) {
      userOrderList = List.generate(event.docs.length, (index) => OrderModel2.fromMap(event.docs[index].data()));
        notifyListeners();
    });
  }

  void getOrderConstants() async{
    DBHelper.fetchOrderConstants().listen((event) {
      if(event.exists){
        orderModel = OrderModel.fromMap(event.data()!);
        notifyListeners();
      }
    });
  }

  num getDiscountAmount(num total){
    return ((total*orderModel.discount)/100).round();
  }

  num getTotalVatAmount(num total){
    return ((total*orderModel.vat)/100).round();
  }
  
  num getGrandTotal(num total){
    return (total+getTotalVatAmount(total)+orderModel.deliveryCharge) - getDiscountAmount(total);
  }

  Future<void> addNewOrder(OrderModel2 orderModel2,List<CartModel> cartModel){
    return DBHelper.addNewOrder(orderModel2, cartModel);
  }

}