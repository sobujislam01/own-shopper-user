import 'package:flutter/foundation.dart';
import 'package:ownshoppers_user/db/DB_Helper.dart';
import 'package:ownshoppers_user/models/product_model.dart';

class ProductProvider extends ChangeNotifier{

  List<ProductModel> productList =[];
  List<String> catagoryList = [];


  void getAllCatagory() {
    DBHelper.fetchAllCatagory().listen((event) { 
      catagoryList = List.generate(event.docs.length, (index) => event.docs[index].data()['name']);
      notifyListeners();
    });
  }

  void getAllProduct() {
    DBHelper.fetchAllProduct().listen((event) {
      productList = List.generate(event.docs.length, (index) => ProductModel.formMap(event.docs[index].data()));
      notifyListeners();
    });
  }


}