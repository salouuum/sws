

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'bin.dart';

class Bin_Discription extends StatelessWidget {
   final int bin_id ;
   final LatLng location ;
   final int capacity ;
   final bool fired ;
   final AssetImage image;
  Bin_Discription({
    required this.bin_id,
    required this.location,
    required this.capacity,
    required this.fired,
    required this.image
  });

  void showdirections ( LatLng location , int capacity )async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(location.latitude,location.longitude ),
      title: capacity.toString(),
    );
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
                  child: Image(image: image,
                    height: 320.0,
                  ),
                ),
                SizedBox(height: 10.0,),
                Text('Bin Description',
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
                    percent: capacity.toDouble()/100,
                    center: Text('${capacity}%',
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
                              showdirections(location,bin_id);
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
