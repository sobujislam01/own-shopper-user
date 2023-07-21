class UserModel {
  String userId;
  String? name;
  String email;
  String? phone;
  String? picture;
  String? deliveryAddress;

  UserModel(
      {required this.userId,
      this.name,
      required this.email,
      this.phone,
      this.picture,
      this.deliveryAddress});

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      'userId' : userId,
      'name' : name,
      'email' : email,
      'phone' : phone,
      'picture' : picture,
      'deliveryAddress' : deliveryAddress,
    };
    return map;
}

  factory UserModel.formMap(Map<String,dynamic>map) => UserModel(
      userId: map['userId'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      picture: map['picture'],
      deliveryAddress: map['deliveryAddress'],
  );
}