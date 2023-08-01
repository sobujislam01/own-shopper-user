import 'package:flutter/material.dart';
import 'package:ownshoppers_user/auth/auth_service.dart';

class CheckoutAlertCart extends StatelessWidget {
  const CheckoutAlertCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Unverified User!'),
      content: const Text('Your Email is not verified yet!.Please click the SEND baton to verified your email'),
      actions: [
        TextButton(
            onPressed: (){},
            child: Text('CLOSE')),

      ],
    );
  }
}
