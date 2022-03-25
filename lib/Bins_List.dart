import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sws/bin.dart';

class BinList extends StatefulWidget {
  const BinList({Key? key}) : super(key: key);

  @override
  State<BinList> createState() => _BinListState();
}

class _BinListState extends State<BinList> {
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      itemBuilder: (context, index)=> buildItem(Bin(bin_id: 12, location: LatLng(34.000004584,35.049874564), capacity:75, fired: false)),
      separatorBuilder: (context, index)=> SizedBox(height: 1.0,),
      itemCount: 10,
    );
  }
  Widget buildItem (Bin bin) {
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

            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('assets/images/Bin1.png'),
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
                      child: RoundedProgressBar(
                        percent: bin.capacity.toDouble(),
                        height: 22.0,
                        style: RoundedProgressBarStyle(
                            colorProgress: Colors.teal,
                            colorProgressDark: Colors.teal.shade600,
                            backgroundProgress: Colors.teal.shade100


                        ),
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
