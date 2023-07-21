import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ownshoppers_user/auth/auth_service.dart';
import 'package:ownshoppers_user/models/user_model.dart';
import 'package:ownshoppers_user/pages/product_list_page.dart';
import 'package:ownshoppers_user/pages/resister_page.dart';
import 'package:ownshoppers_user/provider/user_provider.dart';
import 'package:ownshoppers_user/utils/constants.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  String _errMsg = '';
  bool islogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login page'),
      ),
      body: Center(
          child: Form(
            key: _formkey,
            child: ListView(
             padding: const EdgeInsets.symmetric(horizontal: 40),
              shrinkWrap: true,
              children:[
                TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller:_emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email'
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return EmptyFieldErrMSg;
                  }
                    return null;

                },
              ),
              SizedBox(height: 20,width: 10,),
                TextFormField(
                  obscureText: _obscureText,
                  controller:_passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: (){
                          setState(() {
                            _obscureText=!_obscureText;
                          });
                        },
                      ),
                      hintText: 'Password'
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return EmptyFieldErrMSg;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 5,),
                TextButton(
                    onPressed: (){

                    },
                    child: Text(
                        style: TextStyle(color: Colors.red),'Forgot Password?'),
                ),
                ElevatedButton(
                    onPressed:(){
                      islogin = true;
                      _loginUser();
                    },
                    child: Text('LOGIN')),
                SizedBox(height: 20,width: 10,),
                Text(_errMsg),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New User ?'),
                    TextButton(onPressed:(){
                      islogin = false;
                      _loginUser();
                    },
                        child: Text('Register',style: TextStyle(color: Colors.green),))

                  ],
                )
              ],
             ),
            ),
          )
        );
  }

  void _loginUser() async {
    if (_formkey.currentState!.validate()){
      try{
        String ? uid;
        if (islogin){
          uid = await AuthService.loginUser(_emailController.text, _passwordController.text);
        }else{
          uid = await AuthService.registerUser(_emailController.text, _passwordController.text);
        }
        if(uid != null){
          if(!islogin){
            final userModel = UserModel(userId: uid, email: AuthService.currentUser!.email!);
            Provider.of<UserProvider>(context,listen: false).addUser(userModel);
          }
          Navigator.pushReplacementNamed(context, ProductListPage.routeName);
        }
      }on FirebaseAuthException catch (error){
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }
}
