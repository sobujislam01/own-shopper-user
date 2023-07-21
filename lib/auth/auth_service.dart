import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User ? get currentUser => _auth.currentUser;

  static Future<String?> loginUser(String email,String pass) async {
   final credential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
   return credential.user?.uid;
  }

  static Future<String?> registerUser(String email,String pass) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    return credential.user?.uid;
  }

  static Future<void> logout(){
    return _auth.signOut();
  }

}