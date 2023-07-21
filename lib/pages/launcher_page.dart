import 'package:flutter/material.dart';
import 'package:ownshoppers_user/auth/auth_service.dart';
import 'package:ownshoppers_user/pages/login_page.dart';
import 'package:ownshoppers_user/pages/product_list_page.dart';
import 'package:ownshoppers_user/pages/resister_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      if (AuthService.currentUser == null){
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, ProductListPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CircularProgressIndicator()),
    );
  }
}
