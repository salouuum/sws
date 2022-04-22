import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseManager {
  Future getbins() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection("bins").get();
    final documents = querySnapshot.docs;

  }
}