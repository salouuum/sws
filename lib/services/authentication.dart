//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sws/models/c_user.dart';
//
// class Authentication {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   C_User _userfromfirebase (User user){
//     if (user != null) {
//       return C_User(uid:user.uid);
//     }
//     else{
//       return null;
//     }
//   }
//   // login :
//
//   Future Login ()async {
//     try{
//       UserCredential result = await _auth.signInAnonymously();
//       User? user = result.user;
//       return user;
//     }catch(e){
//      print(e.toString());
//      return null;
//     }
//   }
//
//
// }