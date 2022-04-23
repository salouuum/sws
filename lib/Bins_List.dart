import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sws/bin.dart';
import 'package:sws/database_manager/Database.dart';




import '../bindiscription.dart';

class BinList extends StatefulWidget {
  @override
  State<BinList> createState() => _BinListState();
}


class _BinListState extends State<BinList> {
  var isloaded =false;
  List? bins ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getbins();
  }
  getbins()async{
    dynamic resultant = await DataBase_Manager().getavailablebins();
    if(resultant==null){
     print('unable to relieve');
    }else{
      setState(() {
        bins=resultant;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  getbody();
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
  Widget getbody(){
    if(bins == null){
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
    }else{
      return ListView.separated(
        itemBuilder: (context, index)=>  Padding(
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
                      MaterialPageRoute(builder: (context) => Bin_Discription(
                        bin_id:bins![index]['NC-MA'] ,
                        location: LatLng(bins![index]['location'].latitude,bins![index]['location'].longitude),
                        fired: bins![index]['alarm'],
                        capacity: bins![index]['capacity'],
                        image: getimage(bins![index]['capacity']),
                      ))
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: getimage(bins![index]['capacity']),
                      width: 110.0,
                      height: 110.0,
                      fit: BoxFit.contain,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.0,),
                        Text(
                          bins![index]['NC-MA-01'].toString(),
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Text('Capacity ${bins![index]['capacity']}%'),
                        SizedBox(height: 10.0,),
                      ],
                    ),
                    SizedBox(width: 60.0,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 10.0,
                        percent: bins![index]['capacity'].toDouble()/100,
                        center: Text('${bins![index]['capacity']}%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),),
                        progressColor: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index)=> SizedBox(height: 1.0,),
        itemCount: bins!.length,
      );
    }
  }
  }

