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
  void inceraseQty(CartModel cartModel){
    cartModel.Quentity += 1;
    notifyListeners();
  }
  void diceraseQty(CartModel cartModel){
    if (cartModel.Quentity >1) {
      cartModel.Quentity -= 1;
      notifyListeners();
    }
  }

  int get totalItemInCart => cartlist.length;

  num get cartItemTotalPrice {
    num total = 0;
    cartlist.forEach((element) {
      total += element.price * element.Quentity;
    });
    return total;
}
 void clearCart(){
    cartlist.clear();
    notifyListeners();
 }

void removeFromCart(String id){
final cartModel = cartlist.firstWhere((element) => element.productId == id);
cartlist.remove(cartModel);
notifyListeners();
}
}