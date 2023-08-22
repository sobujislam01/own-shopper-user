import 'package:flutter/material.dart';

class OrderSuccessfulPage extends StatefulWidget {
  static const String routeName = '/order_successful';


  @override
  State<OrderSuccessfulPage> createState() => _OrderSuccessfulPageState();
}

class _OrderSuccessfulPageState extends State<OrderSuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SucessFull'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Order Place SucessFull'),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Go to Home'))
            ],
          )),
    );
  }
}
