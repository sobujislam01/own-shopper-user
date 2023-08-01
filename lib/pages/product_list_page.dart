import 'package:flutter/material.dart';
import 'package:ownshoppers_user/auth/auth_service.dart';
import 'package:ownshoppers_user/customwedgets/main_drower.dart';
import 'package:ownshoppers_user/customwedgets/product_item.dart';
import 'package:ownshoppers_user/pages/cart_page.dart';
import 'package:ownshoppers_user/pages/login_page.dart';
import 'package:ownshoppers_user/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  static const String routeName = '/product-list';

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  late ProductProvider  _productProvider;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    _productProvider.getAllProduct();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
              icon: Icon(Icons.shopping_cart)),

        ],
      ),
      body: GridView.count(
      padding: const EdgeInsets.all(8.0),
       crossAxisCount: 2,
       crossAxisSpacing: 4,
       mainAxisSpacing: 4,
       childAspectRatio: 0.55,
       children: _productProvider.productList.map((product) =>
       ProductItem(product)).toList(),
      )
    );
  }
}
