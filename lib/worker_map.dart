import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sws/workermap_sub.dart';
import 'Bins_List.dart';
import 'bin.dart';

class Worker_Map extends StatefulWidget {
  const Worker_Map({Key? key}) : super(key: key);

  @override
  State<Worker_Map> createState() => _Worker_MapState();
}

class _Worker_MapState extends State<Worker_Map> {

  int FAB = 0;
  List<IconData> icon = [
    Icons.list ,
    Icons.map ,
  ];
  List<Widget> maplist = [
    Worker_Map_Sub(),
    BinList(),
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:maplist[FAB],
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

