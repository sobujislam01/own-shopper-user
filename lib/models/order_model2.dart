import 'package:cloud_firestore/cloud_firestore.dart';

final String ORDER_ID = 'orderId';
final String USER_ID = 'userId';
final String TIME_STAMP = 'timestamp';
final String GRAND_TOTAL = 'grandTotal';
final String DISCOUNT = 'discount';
final String DELIVERY_CHARGE = 'deliveryCharge';
final String DELIVERY_ADDERSS = 'deliveryaddress';
final String ORDER_VAT = 'vat';
final String ORDER_ORDER_STATUS = 'orderStatus';
final String ORDER_PAYMENT_METHOD = 'paymentMethod';

class OrderModel2 {
  String ? orderId;
  Timestamp  timestamp;
  String  userId;
  num  grandTotal;
  num  discount;
  num deliveryCharge;
  String deliveryAddress;
  num vat;
  String  orderStatus;
  String  paymentMethod;

  OrderModel2(
      {this.orderId,
        required this.timestamp,
        required this.userId,
        required this.grandTotal,
        required this.discount,
        required  this.deliveryCharge,
        required  this.deliveryAddress,
        required  this.vat,
        required this.orderStatus,
        required this.paymentMethod});

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      ORDER_ID : orderId,
      USER_ID : userId,
      TIME_STAMP : timestamp,
      DISCOUNT : discount,
      ORDER_VAT : vat,
      DELIVERY_ADDERSS : deliveryAddress,
      DELIVERY_CHARGE : deliveryCharge,
      GRAND_TOTAL : grandTotal,
      ORDER_ORDER_STATUS : orderStatus,
      ORDER_PAYMENT_METHOD : paymentMethod,
    };
    return map;
  }

/*
  factory OrderModel2.fromMap(Map<String,dynamic>map) => OrderModel2(
    orderId : map[ORDER_ID],
    userId : map[USER_ID],
    timestamp : map[TIME_STAMP],
    discount : map[DISCOUNT],
    vat : map[ORDER_VAT],
    deliveryCharge : map[DELIVERY_CHARGE],
    deliveryAddress : map[DELIVERY_ADDERSS],
    grandTotal : map[GRAND_TOTAL],
    orderStatus : map[ORDER_ORDER_STATUS],
    paymentMethod : map[ORDER_PAYMENT_METHOD],
  );
*/
}