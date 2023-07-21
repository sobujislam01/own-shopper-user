const String EmptyFieldErrMSg = 'this field must not be empty';
const String takeSymbol = '৳';
const String photoDirectory = 'ownshoppers';
const String negativePriceErrorMsg = 'Price shouldn\'t be less then 0';
const String negativeStockErrorMsg = 'Quantity should be greater then 0';
 class OrderStatus{
   static const String pending = 'Pending';
   static const String delivered = 'Delivered';
   static const String cancelled = 'Cancelled';
}

class Payment{
  static const String cod = 'cash on delivery';
  static const String online = 'Online payment';
}