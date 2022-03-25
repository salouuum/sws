import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sws/Bins_List.dart';

import 'map.dart';

class User_Home extends StatefulWidget {
  const User_Home({Key? key}) : super(key: key);

  @override
  State<User_Home> createState() => _User_HomeState();
}

class _User_HomeState extends State<User_Home> {
 int FAB = 0;
 List<IconData> icon = [
   Icons.list ,
   Icons.map ,
 ];
 List<Widget> body =[
   UserMap(),
   BinList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[FAB],
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.blue,
        child: Icon(
          icon[FAB],
        color: Colors.white,
        ),
        onPressed:(){
          setState(() {
            if (FAB == 0){
             FAB = 1;
            }
            else {
              FAB =0;
            }
          });
        },
      ),
    );
  }
}
