import 'package:flutter/material.dart';

import 'package:map_launcher/map_launcher.dart';
import 'package:sws/Bins_List.dart';
import 'bin.dart';


class BinDescription extends StatefulWidget {

BinDescription({
 required Bin bin,
});
  @override
  State<BinDescription> createState() => _BinDescriptionState();
}

class _BinDescriptionState extends State<BinDescription> {
  Future<bool> _ismapavailable () async {
    bool? available = await MapLauncher.isMapAvailable(MapType.google);
    bool damn = available! ;
    if (damn) {
      return true;
    } else {
      return false;
    }
  }
  double percent = bin.capacity.toDouble();
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
              Text(bin.bin_id.toString(),
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Text('More Info.'),
              SizedBox(height: 10.0,),
              SizedBox(height: 15.0,),
             Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Material(
                  elevation: 8.0,
                  color: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: MaterialButton(
                      onPressed: () async{
                    if (await _ismapavailable()){
                    MapLauncher.showMarker(
                    mapType: MapType.google,
                    coords: Coords(bin.location.latitude, bin.location.longitude),
                    title: 'title',
                    );
                    }
                    },
                      child: Text(
                        'Get Location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
