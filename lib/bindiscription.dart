

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'database_manager/Database.dart';

class Bin_Discription extends StatefulWidget {
   final String bin_id ;

  Bin_Discription({
    required this.bin_id,
  });

  @override
  State<Bin_Discription> createState() => _Bin_DiscriptionState();
}

class _Bin_DiscriptionState extends State<Bin_Discription> {
   int cap = 6 ;
  late LatLng location ;
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
  void showdirections ( LatLng location , int capacity )async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(location.latitude,location.longitude ),
      title: capacity.toString(),
    );
  }

  @override
  void initState() {
    getbincapacity(widget.bin_id);
    super.initState();
    Timer timer = Timer.periodic(Duration(seconds: 3), (timer)async {
      getbincapacity(widget.bin_id);
    });
  }
  @override
  Widget build(BuildContext context) {
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
                              showdirections(location,cap);
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
              ], ),
          ),
        )
    );
  }
}
