import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sws/bin.dart';

class BinDescription extends StatefulWidget {

   BinDescription({
    required Bin bin
   });
  @override
  State<BinDescription> createState() => _BinDescriptionState(
  );
}

class _BinDescriptionState extends State<BinDescription> {

  double percent = 12.0;


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
                          onPressed: (){},
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
