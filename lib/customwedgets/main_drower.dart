import 'package:flutter/material.dart';
import 'package:ownshoppers_user/auth/auth_service.dart';
import 'package:ownshoppers_user/pages/login_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple.shade50,
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 200,
            child: Image.asset(
              'images/Ownshoppers logo.png',
              width: double.infinity,
              fit: BoxFit.cover,),
          ),
          ListTile(
            onTap: (){},
            leading: Icon(Icons.person),
            title: Text('My Profile'),
          ),
          ListTile(
            onTap: (){},
            leading: Icon(Icons.diamond),
            title: Text('My Order'),
          ),
          ListTile(
            onTap: (){},
            leading: Icon(Icons.shopping_cart),
            title: Text('My Cart'),
          ),
          ListTile(
            onTap: (){
              AuthService.logout().then((_){
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              });
            },
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
