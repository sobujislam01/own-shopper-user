import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ownshoppers_user/auth/auth_service.dart';
import 'package:ownshoppers_user/models/order_model2.dart';
import 'package:ownshoppers_user/pages/order_successful_page.dart';
import 'package:ownshoppers_user/pages/product_list_page.dart';
import 'package:ownshoppers_user/provider/cart_provider.dart';
import 'package:ownshoppers_user/utils/DBHelper_Function.dart';
import 'package:ownshoppers_user/utils/constants.dart';
import 'package:provider/provider.dart';

import '../provider/order_provider.dart';

class CheckoutPage extends StatefulWidget {
  static const String routeName = '/checkout_page';


  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CartProvider _cartProvider;
  late OrderProvider _orderProvider;
  String radioGroupValue = Payment.cod;
  final _addressController = TextEditingController();

  @override
  void didChangeDependencies() {
    _cartProvider = Provider.of<CartProvider>(context);
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getOrderConstants();
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
               const Text('Your Items',style: TextStyle(fontSize: 20),),
               const Divider(height: 2,color: Colors.black,),
                Column(
                 mainAxisSize: MainAxisSize.min,
                  children: _cartProvider.cartlist.map((cartModel) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(cartModel.productName,style: TextStyle(fontSize: 18),),
                       Text('${cartModel.Quentity} * ${cartModel.price}'),
                     ],
                  )).toList(),
                ),
                SizedBox(height: 20,),
                const Text('Order Summary',style: TextStyle(fontSize: 20),),
                const Divider(height: 2,color: Colors.black,),
                Column(
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     const Text('Cart Total',style: TextStyle(fontSize: 18),),
                      Text('$takeSymbol ${_cartProvider.cartItemTotalPrice}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black),)
                    ],
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Charge',style: TextStyle(fontSize: 18),),
                        Text('$takeSymbol ${_orderProvider.orderModel.deliveryCharge}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text('Discount (${_orderProvider.orderModel.discount}%)',style: TextStyle(fontSize: 18),),
                        Text('-$takeSymbol ${_orderProvider.getDiscountAmount(_cartProvider.cartItemTotalPrice)}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vat (${_orderProvider.orderModel.vat}%)',style: TextStyle(fontSize: 18),),
                        Text('$takeSymbol ${_orderProvider.getTotalVatAmount(_cartProvider.cartItemTotalPrice)}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black),)
                      ],
                    ),
                    const Divider(height: 2,color: Colors.black,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Grand Total ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                        Text('$takeSymbol ${_orderProvider.getGrandTotal(_cartProvider.cartItemTotalPrice)}',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black),),
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
                const Text('Set Delivery Address',style: TextStyle(fontSize: 20),),
                const Divider(height: 3,color: Colors.black,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Text('Select payment method',style: TextStyle(fontSize: 20),),
                const Divider(height: 3,color: Colors.black,),
                Row(
                  children: [
                    Radio(
                        value: Payment.cod,
                        groupValue: radioGroupValue,
                        onChanged: (value){
                          setState(() {
                            radioGroupValue = value!;
                          });
                        }),
                    Text(Payment.cod),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: Payment.online,
                        groupValue: radioGroupValue,
                        onChanged: (value){
                          setState(() {
                            radioGroupValue = value!;
                          });
                        }),
                    Text(Payment.online),
                  ],
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: _saveOrder,
                child:const Text('Place Order')),
          )
        ],
      )
    );
  }

  void _saveOrder() {
    if(_addressController.text.isEmpty) {
      showMsg(context, 'Please provide a delivery address');

      final orderModel2 = OrderModel2(
          timestamp: Timestamp.now(),
          userId: AuthService.currentUser!.uid,
          grandTotal: _orderProvider.getGrandTotal(
              _cartProvider.cartItemTotalPrice),
          discount: _orderProvider.orderModel.discount,
          deliveryCharge: _orderProvider.orderModel.deliveryCharge,
          deliveryAddress: _addressController.text,
          vat: _orderProvider.orderModel.vat,
          orderStatus: OrderStatus.pending,
          paymentMethod: radioGroupValue);
      _orderProvider.addNewOrder(orderModel2, _cartProvider.cartlist).then((
          value) {
        Navigator.pushNamedAndRemoveUntil(
            context, OrderSuccessfulPage.routeName,
            ModalRoute.withName(ProductListPage.routeName));
        _cartProvider.clearCart();
      }).catchError((error) {
        showMsg(context, 'Could Not Save.');
      });
    }

  }
}
