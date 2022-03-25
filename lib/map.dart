import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserMap extends StatefulWidget {
  const UserMap({Key? key}) : super(key: key);

  @override
  State<UserMap> createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  late GoogleMapController googleMapController;
  Set<Polyline> polylines = {};
  void _nearestbin()async{
    Position pos = await _determinePosition();
    int mark = 0;
    double dis = 0.0;
    for(int i=0 ; i<markers.length ; i++){
      double distance = Geolocator.distanceBetween(markers[i].position.latitude, markers[i].position.longitude, pos.latitude, pos.longitude);
      if (distance>0 && distance<Geolocator.distanceBetween(markers.elementAt(i-1).position.latitude, markers.elementAt(i-1).position.longitude, pos.latitude, pos.longitude)){
        dis = distance;
        mark=i;
      }
    }
    setState(() {
      polylines.add(
          Polyline(polylineId: PolylineId('1234'),
            points: [
              LatLng(pos.latitude, pos.longitude),
              markers[mark].position,
            ],
          ));
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

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
  Future _gotolocation()async{
    Position position = await _determinePosition();

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));


    markers.clear();

    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));

    setState(() {});

  }
  void _setmarker(String id , String description ,var lat , var long){
    Marker marker =Marker(
        markerId: MarkerId(id),
      infoWindow: InfoWindow(
        title: description,
      ),
      position: LatLng(lat, long),
      onTap: (){

      }
    );
    setState(() {
      markers.add(marker);
    });
  }
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  List<Marker> markers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gotolocation();
    _nearestbin();
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
              polylines: polylines,
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
