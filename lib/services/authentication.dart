
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future Login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future CreateUser(String email, String Password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: Password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }
}

