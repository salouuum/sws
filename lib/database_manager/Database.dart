import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase_Manager {
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
}