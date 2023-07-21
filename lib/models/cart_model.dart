class CartModel{
  String productId;
  String productName;
  num price;
  int Quentity;

  CartModel({
    required this.productId,
    required this.productName,
    required this.price,
    this.Quentity= 1});

  Map<String,dynamic> toMap(){
   var  map = <String,dynamic>{
     'productId' : productId,
     'productName' : productName,
     'price' : price,
     'Quentity' : Quentity,
   };
   return map;
  }
  factory CartModel.fromMap(Map<String,dynamic>map) => CartModel(
      productId: map['productId'],
      productName: map['productName'],
      price: map['price'],
    Quentity: map['Quentity'],
  );

}