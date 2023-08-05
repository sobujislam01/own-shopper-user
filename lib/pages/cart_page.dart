import 'package:flutter/material.dart';
import 'package:ownshoppers_user/auth/auth_service.dart';
import 'package:ownshoppers_user/pages/checkout_page.dart';
import 'package:ownshoppers_user/provider/cart_provider.dart';
import 'package:ownshoppers_user/utils/DBHelper_Function.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart_page';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartProvider _cartProvider;

  @override
  void didChangeDependencies() {
    _cartProvider = Provider.of<CartProvider>(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My cart'),
        actions: [
          TextButton(
              onPressed: (){
                _cartProvider.clearCart();
              },
              child: Text('CLEAR',style: TextStyle(color: Colors.red),))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: _cartProvider.cartlist.length,
                  itemBuilder: (context,index){
                  final model = _cartProvider.cartlist[index];
                  return ListTile(
                    title: Text(model.productName),
                    subtitle:Text('$takeSymbol ${model.price}') ,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: (){
                              _cartProvider.diceraseQty(model);
                            },
                            icon: Icon(Icons.remove_circle),
                        ),
                        Text('${model.Quentity}'),
                    IconButton(
                    onPressed: (){
                      _cartProvider.inceraseQty(model);
                    },
                    icon: Icon(Icons.add_circle),
                    )],
                    ),
                  );
                  })),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('total: $takeSymbol ${_cartProvider.cartItemTotalPrice}', style: TextStyle(fontSize: 18),),
                  TextButton(
                      child: Text('Checkout'),
                    onPressed: (){
                   // _cartProvider.totalItemInCart == 0 ? null : (){
                      //if(!AuthService.isUserVerified()){
                       //showEmailVerificationAlert();
                      if(_cartProvider.cartlist.isNotEmpty) {
                        Navigator.pushNamed(context, CheckoutPage.routeName);
                      }

                    }
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showEmailVerificationAlert() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Unverified User!'),
      content: const Text('Your Email is not verified yet!.Please click the SEND baton to verified your email'),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('CLOSE')),
        TextButton(
            onPressed: (){
              Navigator.pop(context);
              AuthService.sendVerificationMail().then((value) {
                print('mail send');
              }).catchError((error){
                throw error;
              });
            },
            child: Text('SEND')),
      ],
    ));
  }
}
