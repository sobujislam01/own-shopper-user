import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ownshoppers_user/models/user_model.dart';

class DBHelper {
  static const _collectionProduct = 'products';
  static const _collectionCategory = 'catagory';
  static const _collectionUser = 'Users';
  static const _collectionOrderUtils = 'OrderUtils';
  static const _documentConstants = 'Constants';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addNewUser(UserModel userModel) {
    final doc = _db.collection(_collectionUser).doc(userModel.userId);
    return doc.set(userModel.toMap());
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCatagory() =>
      _db.collection(_collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProduct() =>
      _db.collection(_collectionProduct).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchProductbyProductId(String productId) =>
      _db.collection(_collectionProduct).doc(productId).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchOrderConstants() =>
      _db.collection(_collectionOrderUtils).doc(_documentConstants).snapshots();



}