import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ownshoppers_user/pages/cart_page.dart';
import 'package:ownshoppers_user/pages/checkout_page.dart';
import 'package:ownshoppers_user/pages/order_details_page.dart';
import 'package:ownshoppers_user/pages/order_successful_page.dart';
import 'package:ownshoppers_user/pages/product_details_page.dart';
import 'package:ownshoppers_user/pages/product_list_page.dart';
import 'package:ownshoppers_user/pages/user_order-list_page.dart';
import 'package:ownshoppers_user/pages/user_profile_page.dart';
import 'package:ownshoppers_user/provider/cart_provider.dart';
import 'package:ownshoppers_user/provider/order_provider.dart';
import 'package:ownshoppers_user/provider/product_provider.dart';
import 'package:ownshoppers_user/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'pages/launcher_page.dart';
import 'pages/login_page.dart';
import 'pages/resister_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName : (context) => LauncherPage(),
          LoginPage.routeName : (context) => LoginPage(),
          RegisterPage.routeName : (context) => RegisterPage(),
          CartPage.routeName : (context) => CartPage(),
          CheckoutPage.routeName : (context) => CheckoutPage(),
          OrderSuccessfulPage.routeName : (context) => OrderSuccessfulPage(),
          ProductDetailsPage.routeName : (context) => ProductDetailsPage(),
          ProductListPage.routeName : (context) => ProductListPage(),
          UserOrderListPage.routeName : (context) => UserOrderListPage(),
          UserProfilePage.routeName: (context) => UserProfilePage(),
          OrderDetailsPage.routeName: (context) => OrderDetailsPage(),
        },
      ),
    );
  }
}

