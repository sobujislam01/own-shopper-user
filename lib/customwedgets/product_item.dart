import 'package:flutter/material.dart';
import 'package:ownshoppers_user/models/product_model.dart';
import 'package:ownshoppers_user/provider/cart_provider.dart';
import 'package:ownshoppers_user/utils/constants.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  ProductItem(this.product);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 7,
      child: Column(
        children: [
          widget.product.productImage == null ?
              Expanded(child: Image.asset(
                'images/image not available.png',
                width: double.infinity,
                fit: BoxFit.cover,))
           :
          Expanded(
            child: FadeInImage.assetNetwork(
              image : widget.product.productImage!,
              placeholder: 'images/image not available.png',
              width: double.infinity,
              fit: BoxFit.cover,),
          ),
          Padding(
              padding: const EdgeInsets.all(4),
          child: Text(widget.product.name!,style: TextStyle(fontSize: 16),),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text('$takeSymbol${widget.product.price}',style: TextStyle(fontSize: 16),),
          ),
          Consumer<CartProvider>(
            builder: (context, provider, _) => ElevatedButton(onPressed: (){
              if(provider.isInCart(widget.product.id!)){
                provider.removeFromCart(widget.product.id!);
              }else{
                provider.addToCart(widget.product);

              }
            },
                child: Text(provider.isInCart(widget.product.id!) ? 'REMOVE ': 'Add to Cart')),
          )
        ],
      ),
    );
  }
}
