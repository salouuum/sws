

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'bin.dart';

class Bin_Discription extends StatelessWidget {
  final Bin bin;
  Bin_Discription({
    required this.bin,
  });

  void showdirections (Bin b)async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(b.location.latitude,b.location.longitude ),
      title: b.capacity.toString(),
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
                  child: Image(image: AssetImage('images/Bin1.png'),
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
                    percent: bin.capacity/100,
                    center: Text('${bin.capacity}%',
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
                              showdirections(bin);
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
