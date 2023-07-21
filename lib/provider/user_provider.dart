import 'package:flutter/foundation.dart';
import 'package:ownshoppers_user/db/DB_Helper.dart';
import 'package:ownshoppers_user/models/user_model.dart';

class UserProvider extends ChangeNotifier {

  Future<void>addUser(UserModel userModel){
    return DBHelper.addNewUser(userModel);
  }
}