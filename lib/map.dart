import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bin.dart';
import 'bindiscription.dart';
import 'database_manager/Database.dart';


class UserMap extends StatefulWidget {
  const UserMap({Key? key}) : super(key: key);

  @override
  State<UserMap> createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  late GoogleMapController googleMapController;
  List? bins;
  getbins()async{
    dynamic resultant = await DataBase_Manager().getavailablebins();
    if(resultant==null){
      print('unable to relieve');
    }else{
      setState(() {
        _setmarkers(resultant);
      });
    }
  }
  void _nearestbin()async{
    Position pos = await _determinePosition();
    int mark = 0;
    double dis = Geolocator.distanceBetween(markers[0].position.latitude, markers[0].position.longitude, pos.latitude, pos.longitude);;
    for(int i=1 ; i<markers.length ; i++){
      double distance = Geolocator.distanceBetween(markers[i].position.latitude, markers[i].position.longitude, pos.latitude, pos.longitude);
      if (distance>2 && distance<dis){
        dis = distance;
        if(markers[i].position!=LatLng(pos.latitude, pos.longitude))
        {mark=i;}
      }
    }
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target:markers[mark].position , zoom: 15.0,))
    );
    setState(() {

    });
  }
  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    return position;
  }
  Future _gotolocation()async{
    Position position = await _determinePosition();

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));

    setState(() {});

  }
  AssetImage getimage(dynamic bin){
    AssetImage image ;
    if(bin>=75){
      image = AssetImage('images/Bin2.png');
    }else{
      image = AssetImage('images/Bin1.png');
    }
    return image;
  }
  void _setmarkers(List binslist) {
    for (int i = 0; i < binslist!.length; i++) {
      Marker marker = Marker(
          markerId: MarkerId(binslist[i]['NC-MA']),
          infoWindow: InfoWindow(
            title: binslist[i]['capacity'].toString(),
          ),
          position: LatLng(double.parse(binslist[i]['lat']),double.parse(binslist[i]['long'])),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Bin_Discription(
                  bin_id: binslist[i]['NC-MA'],
                  )
            ));
          }
      );
      setState(() {
        markers.add(marker);
      });
    }
  }
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  List<Marker> markers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gotolocation();
    getbins();
    Timer timer = Timer.periodic(Duration(seconds: 3), (timer) {
     getbins();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: initialCameraPosition,
              markers: markers.map((e) => e).toSet(),
              onMapCreated: (GoogleMapController controller){
                googleMapController = controller;
              },
              mapType: MapType.normal,

            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
                end: 65.0,
                bottom: 15.0,
                top: 15.0,

              ),
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue,
                        ),
                        child: MaterialButton(
                          onPressed: _gotolocation,
                          child: Row(
                            children: [
                              Icon(Icons.location_searching),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'my location',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue,
                        ),
                        child: MaterialButton(
                          onPressed: _nearestbin,
                          child: Row(
                            children: [
                              Icon(Icons.recycling),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'nearest bin',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}
