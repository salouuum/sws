import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bin {
late final int bin_id ;
late final LatLng location ;
late final int capacity ;
late final bool fired ;

Bin ({
 required this.bin_id ,
 required this.location,
 required this.capacity,
   required this.fired,
});
}