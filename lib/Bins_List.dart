import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sws/bin.dart';


import 'bin_description.dart';

class BinList extends StatefulWidget {
  const BinList({Key? key}) : super(key: key);

  @override
  State<BinList> createState() => _BinListState();
}

class _BinListState extends State<BinList> {
  Bin bin = Bin(bin_id: 12, location: LatLng(34.000004584,35.049874564), capacity:75, fired: false);
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      itemBuilder: (context, index)=> buildItem(bin),
      separatorBuilder: (context, index)=> SizedBox(height: 1.0,),
      itemCount: 10,
    );
  }
  Widget buildItem (Bin bin) {
    double value = bin.capacity.toDouble();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 10,
        color: Colors.transparent,
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: GestureDetector(
            onTap: () {
          Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => BinDescription(bin: bin ,))
          );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('images/Bin1.png'),
                  width: 110.0,
                  height: 110.0,
                  fit: BoxFit.contain,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.0,),
                    Text(
                      bin.bin_id.toString(),
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Text('Capacity ${bin.capacity}%'),
                    SizedBox(height: 10.0,),
                    Container(
                      width: 220.0,
                      child: Slider(
                        value: value,
                        max: 100,
                        min: 0,
                        onChanged: (double v) {
                          setState(() {
                            value = v ;
                          });
                        },
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
