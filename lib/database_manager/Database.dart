import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataBase_Manager {
  // fetch bins info
  final CollectionReference binslist =
  FirebaseFirestore.instance.collection('bins');

  Future getbins()async{
    List bins = [];
    try{
      await binslist.get().then((querysnapshot){
        querysnapshot.docs.forEach((element) {
          bins.add(element.data());
        });
      });
      return bins;
    }catch(e){
      print(e.toString());
    }
  }

  Future getfullbins()async{
    List bins = await this.getbins();
    List fullbins = [];
    try{
      for(int i = 0 ; i < bins!.length ; i++ ){
        if(bins[i]['capacity']>=75){
          fullbins.add(bins[i]);
        }
      }
      return fullbins;
    }catch(e){
      print(e.toString());
    }
  }

  Future getavailablebins()async{
    List bins = await this.getbins();
    List availablebins = [];
    try{
      for(int i = 0 ; i < bins!.length ; i++ ){
        if(bins[i]['capacity']<75){
          availablebins.add(bins[i]);
        }
      }
      return availablebins;
    }catch(e){
      print(e.toString());
    }
  }


  // fetch profile info
  final CollectionReference workerslist =
  FirebaseFirestore.instance.collection('users');

  Future getworkers()async{
    List workers = [];
    try{
      await workerslist.get().then((querysnapshot){
        querysnapshot.docs.forEach((element) {
          workers.add(element.data());
        });
      });
      return workers;
    }catch(e){
      print(e.toString());
    }
  }
  Future getworkerinfo(dynamic uid)async{
    List workers = await getworkers();
    for (int i =0 ; i < workers!.length ; i++){
      if(workers[i]['uid'] == uid){
        return workers[i];
      }
    }
  }
  add_history (dynamic uid , String id , LatLng location )async{
    await workerslist.doc(uid).collection('history').add({
    'id' : id ,
      'location' : location.toString(),
      'time' : DateTime.now(),
    });
  }
  getuserbins(dynamic uid)async{
    List workerbins = [];
    try{
      await workerslist.doc(uid.toString()).collection('history').get().then((querysnapshot){
        querysnapshot.docs.forEach((element) {
          workerbins.add(element.data());
        });
      });
      return workerbins;
    }catch(e){
      print(e.toString());
    }
  }
}