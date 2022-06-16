import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bindiscription.dart';
import 'database_manager/Database.dart';


class Worker_Map_Sub extends StatefulWidget {
  const Worker_Map_Sub({Key? key}) : super(key: key);

  @override
  State<Worker_Map_Sub> createState() => _Worker_Map_SubState();
}

class _Worker_Map_SubState extends State<Worker_Map_Sub> {
  List? available;
  List? full;

  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  List<Marker> markers = [];
  late BitmapDescriptor icon;

  getfbins() async {
    dynamic resultant = await DataBase_Manager().getfullbins();
    if (resultant == null) {
      print('unable to relieve');
    } else {
      setState(() {
        _setmarkers(resultant,
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
        full = resultant;
      });
    }
  }

  getavailbins() async {
    dynamic resultant = await DataBase_Manager().getavailablebins();
    if (resultant == null) {
      print('unable to relieve');
    } else {
      setState(() {
        _setmarkers(resultant,
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
        available = resultant;
      });
    }
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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return position;
  }

  Future _gotolocation() async {
    Position position = await _determinePosition();

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 14)));

    setState(() {});
  }

  AssetImage getimage(dynamic bin) {
    AssetImage image;
    if (bin >= 75) {
      image = AssetImage('images/Bin2.png');
    } else {
      image = AssetImage('images/Bin1.png');
    }
    return image;
  }

  void _setmarkers(List binslist, BitmapDescriptor icon) async {

    for (int i = 0; i < binslist!.length; i++) {
      Marker marker = Marker(
          markerId: MarkerId(binslist[i]['NC-MA']),
          infoWindow: InfoWindow(
            title: binslist[i]['capacity'].toString(),
          ),
          position: LatLng(double.parse(binslist[i]['lat']),
              double.parse(binslist[i]['long'])),
          icon: icon,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    Bin_Discription(
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

    Future update_cpacity(String id) async {
      var cap;
      var alarm;
      FirebaseDatabase database = FirebaseDatabase.instance;

      DatabaseReference ref = FirebaseDatabase.instance.ref(id);
      FirebaseDatabase.instance.ref(id).get().then((event) {
        print("---------------------");
        print(event
            .child("capacity")
            .value);
        print(event
            .child("smoke")
            .value);
        cap = event
            .child("capacity")
            .value;
        alarm = event
            .child("smoke")
            .value;
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
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _gotolocation();
      getfbins();
      getavailbins();
    }
    @override
    Widget build(BuildContext context) {
      if (available != null) {
        for (int i = 0; i < available!.length; i++) {
          update_cpacity(available![i]['NC-MA']);
        }
      }
      if (full != null) {
        for (int i = 0; i < full!.length; i++) {
          update_cpacity(full![i]['NC-MA']);
        }
      }
      getfbins();
      getavailbins();
      return getbody();
    }
    Widget getbody() {
      if (full == null) {
        return Center(child:
        Text(
          'Loading ...',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        )
        );
      } else {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: initialCameraPosition,
                  markers: markers.map((e) => e).toSet(),
                  onMapCreated: (GoogleMapController controller) {
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

