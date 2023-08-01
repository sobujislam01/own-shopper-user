class OrderModel {
  num deliveryCharge;
  num discount;
  num vat;

  OrderModel({this.deliveryCharge =0, this.discount = 0, this.vat = 0});

  factory OrderModel.fromMap(Map<String,dynamic>map) => OrderModel(
    deliveryCharge: map['deliveryCharge'],
    discount: map['discount'],
    vat: map['vat'],
  );
  @override
  String toString() {
    return 'OrderModel{deliveryCharge:$deliveryCharge,discount:$discount,vat: $vat}'.toString();
  }
}
