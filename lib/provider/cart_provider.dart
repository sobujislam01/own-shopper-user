import 'package:flutter/foundation.dart';
import 'package:ownshoppers_user/models/cart_model.dart';
import 'package:ownshoppers_user/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartlist = [];

  void addToCart(ProductModel productModel){
    cartlist.add(CartModel(productId: productModel.id!, productName: productModel.name!, price: productModel.price));
    notifyListeners();
  }

  bool isInCart (String id){
    bool tag = false;
    for(var model in cartlist){
      if(model.productId == id){
        tag = true;
        break;
      }
    }
    return tag;
  }
void removeFromCart(String id){
final cartModel = cartlist.firstWhere((element) => element.productId == id);
cartlist.remove(cartModel);
notifyListeners();
}
}