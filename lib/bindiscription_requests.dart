

import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bin.dart';
import 'database_manager/Database.dart';

class Bin_Discription_Request extends StatefulWidget {
  final String bin_id ;
  Bin_Discription_Request({
    required this.bin_id,

  });

  @override
  State<Bin_Discription_Request> createState() => _Bin_Discription_RequestState();
}

class _Bin_Discription_RequestState extends State<Bin_Discription_Request> {
  String _token = 'fWf2CkwM7UzET4Qq6NzVEp:APA91bGyICrik6UpV5bxobG9cg-WeO_U5SJwbeVE2E0_RdXeDCl_62tFArhmcIn1JI51K_NcHmpgOc1ty1lRioZ2alPrkbpXE85Cu5BC5sPvbSJas82OWx-JL4niv05AVXxbBKxtsfpd';

   int cap = 0 ;
  LatLng? location ;
  dynamic uid ;
  String button = 'empty';
  AssetImage getimage(dynamic bin){
    AssetImage image ;
    if(bin>=75){
      image = AssetImage('images/Bin2.png');
    }else{
      image = AssetImage('images/Bin1.png');
    }
    return image;
  }
  getbincapacity(String id)async{
    dynamic bins = await DataBase_Manager().getbins();
    if (bins == null){
      print('unable to relieve');
    }
    else {
      for (int i =0 ; i < bins!.length ; i++){
        if(bins[i]['NC-MA'] == id){
         setState(() {
           cap = bins[i]['capacity'];
           location = LatLng(double.parse(bins[i]['lat']), double.parse(bins[i]['long']));
         });
        }
      }
    }
  }
  DataBase_Manager db_manager = DataBase_Manager();
  getpref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() async {
      uid = await preferences.getString('uid');
    });
  }
  String getbutton (int cap){
    if (cap<10){
      return 'empty';
    }else {
      return button;
    }
  }
  Future update_cpacity(String id) async {

    var cap;
    var alarm;
    FirebaseDatabase database = FirebaseDatabase.instance;

    DatabaseReference ref = FirebaseDatabase.instance.ref(id);
    FirebaseDatabase.instance.ref(id).get().then((event) {
      print("---------------------");
      print(event.child("capacity").value);
      print(event.child("smoke").value);
      cap=event.child("capacity").value;
      alarm=event.child("smoke").value;
      setState(() {

      });
      CollectionReference Reference =
      FirebaseFirestore.instance.collection('bins');
      Reference.where('NC-MA', isEqualTo: id).get().then((value) {
        value.docs.forEach((element) {
          print(element.id);
          DocumentReference documentReference =
          FirebaseFirestore.instance.collection('bins').doc(element.id);

          Map<String, dynamic> adddata = ({

            "capacity": cap,
            "alarm": alarm,


          });
          // update data to Firebase
          documentReference
              .update(adddata)
              .whenComplete(() => print('updated'));
        });
      });

    });


  }

  void showdirections ( LatLng location , int capacity )async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(location.latitude,location.longitude ),
      title: capacity.toString(),
    );
  }
@override
void initState() {
    super.initState();
    getpref();
    getbincapacity(widget.bin_id);
    Timer timer = Timer.periodic(Duration(seconds: 3), (timer)async {
      update_cpacity(widget.bin_id);
      getbincapacity(widget.bin_id);
    });
}
  @override
  Widget build(BuildContext context) {
    update_cpacity(widget.bin_id);
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsetsDirectional.all(15.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(image: getimage(cap),
                    height: 320.0,
                  ),
                ),
                SizedBox(height: 10.0,),
                Text('bin id : ${widget.bin_id}',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0,),
                Text('More Info.'),
                SizedBox(height: 10.0,),
                Center(
                  child: CircularPercentIndicator(
                    radius: 70.0,
                    progressColor: Colors.teal,
                    lineWidth: 20,
                    percent: cap/100,
                    center: Text('${cap}%',
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.teal,
                      ) ,
                    ) ,
                  ),
                ),
                SizedBox(height: 30.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Expanded(
                      flex: 1,
                      child: Material(
                        elevation: 8.0,
                        color: Colors.transparent,
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: MaterialButton(

                            onPressed: (){
                              showdirections(location!,cap);
                            },
                            child: Text(
                              'Get location',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Expanded(
                      flex: 1,
                      child: Material(
                        elevation: 8.0,
                        color: Colors.transparent,
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: MaterialButton(

                            onPressed: ()async{
                                if (_token == null) {
                                  print('Unable to send FCM message, no token exists.');
                                  return;
                                }
                                try {
                                  await http
                                      .post(
                                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                                    headers: <String, String>{
                                      'Content-Type': 'application/json',
                                      'Authorization':
                                      'key=AAAAlxjSVh0:APA91bEsooijUbNihkC-PYqFiBdzDtcu1oPdMnA6a_gn01mn4MsfWWcRhBTXsKfwW52skhbAnJxlpagrNNpVijoFrNlfKY5Y1viLDlx-TFZFgXFXqbIlm5sL2Dvh7CeKuSyuYsYutDL7'
                                    },
                                    body: json.encode({
                                      'to': _token,
                                      'message': {
                                        'token': _token,
                                      },
                                      "notification": {
                                        "title": "Push Notification",
                                        "body": "Firebase  push notification 35464684k-------------"
                                      }
                                    }),
                                  )
                                      .then((value) => print(value.body));
                                  print('FCM request for web sent!');
                                } catch (e) {
                                  print(e);
                                }

                              //int cap = await getbincapacity(widget.bin_id);
                             if (cap<10){
                               setState(() {
                                 db_manager.add_history(uid, widget.bin_id, location!);
                               });

                             }else{
                               setState(() {
                                 button = 'Checking ...';
                               });

                             }

                            },
                            child: Text(
                              getbutton(cap),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ], ),
          ),
        )
    );
  }
}
