import 'package:flutter/material.dart';
import 'package:ownshoppers_user/provider/cart_provider.dart';
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

  @override
  void didChangeDependencies() {
    _cartProvider = Provider.of<CartProvider>(context);
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getOrderConstants();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
               const Text('Your Items',style: TextStyle(fontSize: 20),),
               const Divider(height: 2,color: Colors.black,),
                Column(
                 mainAxisSize: MainAxisSize.min,
                  children: _cartProvider.cartlist.map((cartModel) => ListTile(
                    title: Text(cartModel.productName),
                    trailing: Text('${cartModel.Quentity} * ${cartModel.price}'),
                  )).toList(),
                ),
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
                const Text('Select payment mathod',style: TextStyle(fontSize: 20),),
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
          ElevatedButton(
              onPressed: _saqveOrder,
              child:const Text('Place Order'))
        ],
      )
    );
  }

  void _saqveOrder() {
  }
}
