import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sws/database_manager/Database.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic uid ;
  ProfileScreen({
    required this.uid,
  });
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name ;
  String? n_id ;
  List? userbins ;
  void Function()? onPressed;
  getbins()async{
    dynamic resultant = await DataBase_Manager().getuserbins(widget.uid);
    if(resultant==null){
      print('unable to relieve');
    }else{
      setState(() {
        userbins=resultant;
      });
    }
  }
  @override
  void initState(){
    super.initState();
    getaccountinfo(widget.uid);
    getbins();
  }

  @override
  Widget build(BuildContext context) {
      if (name == null ) {
        return Center(
          child: Text (
            'Loading ...',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
      else{
        return Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white

            ),
          ),
          MediaQuery
              .of(context)
              .orientation == Orientation.portrait ?
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 50.0,),
                Material(
                  borderRadius: BorderRadiusDirectional.circular(25.0),
                  color: Colors.transparent,
                  elevation: 5.0,
                  child: Container(
                    width: 320.0,
                    height: 220.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffFFC300), Color(0xffFFB319),]
                        ),
                        borderRadius: BorderRadiusDirectional.circular(25.0)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10.0,),
                        Center(
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(
                                    120.0),

                              ),
                              child: CircleAvatar(
                                  radius: 60.0,
                                  child: Image(
                                    image: AssetImage('images/profile.jpg'),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            )
                        ),
                        SizedBox(height: 10.0,),
                        Center(
                          child: Text(
                            name!,
                            style: GoogleFonts.yanoneKaffeesatz(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Center(
                          child: Text(
                            'ID: ${n_id}',
                            style: GoogleFonts.yanoneKaffeesatz(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.0,),
                Container(
                  height: 280.0,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          profileInfo(index, context),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 20.0,),
                      itemCount: 2
                  ),
                ),

              ],
            ),
          )
              :
          Container(
            width: 200,
            height: 200,
            color: Colors.white,
          )
        ],
      );}
  }

  Widget profileInfo (int index, context) {
    List <Widget> A = [
      Material(
        borderRadius: BorderRadiusDirectional.circular(25.0),
        color: Colors.transparent,
        elevation: 5.0,
        child: Container(

          width: 320.0,
          height: 280.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff005555), Color(0xff069A8E),]
              ),
              borderRadius: BorderRadiusDirectional.circular(25.0)
          ),
          child: Column(
            children: [
              SizedBox(height: 15.0,),
              Center(
                child: Text(
                  'Total Bins this month',
                  style: GoogleFonts.yanoneKaffeesatz(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Center(
                      child: Text(
                        userbins!.length.toString(),
                        style: GoogleFonts.yanoneKaffeesatz(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 90,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0,),
                    Center(
                      child: Text(
                        'Bins',
                        style: GoogleFonts.yanoneKaffeesatz(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,

                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.0,),
              MaterialButton(
                onPressed: (){
                  showModalBottomSheet(context: context,
                      builder: (context)=> Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        color: Colors.white,
                        child:ListView.separated(
                          itemBuilder: (context, index)=>  Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Material(
                              elevation: 10,
                              color: Colors.transparent,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image(
                                        image: AssetImage('images/Bin1.png'),
                                        width: 110.0,
                                        height: 110.0,
                                        fit: BoxFit.contain,
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.0,),
                                          Text(
                                            'Bin ID : ${userbins![index]['id']} ',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 15.0,),
                                          Text('Time : ${userbins![index]['time'].toDate()}'),
                                          SizedBox(height: 10.0,),
                                          Text('Location: ${userbins![index]['location']}'),
                                          // Container(
                                          //   width: 220.0,
                                          //   child: RoundedProgressBar(
                                          //     percent: 70.0,
                                          //     height: 22.0,
                                          //     style: RoundedProgressBarStyle(
                                          //         colorProgress: Colors.teal,
                                          //         colorProgressDark: Colors.teal.shade600,
                                          //         backgroundProgress: Colors.teal.shade100
                                          //
                                          //
                                          //     ),
                                          //   ),
                                          // ),

                                        ],
                                      ),
                                    flex: 3,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index)=> SizedBox(height: 1.0,),
                          itemCount: userbins!.length,
                        )

                      ));
                },
                elevation: 5.0,
                child: Container(
                  width: 250.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                      color: Color(0xffFFC300),
                      borderRadius: BorderRadiusDirectional.circular(20.0)
                  ),

                  child: Center(
                    child: Text(
                      'View Bins',
                      style: GoogleFonts.yanoneKaffeesatz(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,

                        ),

                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Material(
        borderRadius: BorderRadiusDirectional.circular(25.0),
        color: Colors.transparent,
        elevation: 5.0,
        child: Container(
          width: 320.0,
          height: 280.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff005555), Color(0xff069A8E),]
              ),
              borderRadius: BorderRadiusDirectional.circular(25.0)
          ),
          child: Column(
            children: [
              SizedBox(height: 15.0,),
              Center(
                child: Text(
                  'Total Earned this month',
                  style: GoogleFonts.yanoneKaffeesatz(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Center(
                      child: Text(
                        '130',
                        style: GoogleFonts.yanoneKaffeesatz(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 90,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0,),
                    Center(
                      child: Text(
                        'EGP',
                        style: GoogleFonts.yanoneKaffeesatz(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,

                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.0,),
              // MaterialButton(
              //   onPressed: (){},
              //   elevation: 5.0,
              //   child: Container(
              //     width: 250.0,
              //     height: 55.0,
              //     decoration: BoxDecoration(
              //         color: Color(0xffFFC300),
              //         borderRadius: BorderRadiusDirectional.circular(20.0)
              //     ),
              //
              //     child: Center(
              //       child: Text(
              //         'View Details',
              //         style: GoogleFonts.yanoneKaffeesatz(
              //           textStyle: TextStyle(
              //             color: Colors.white,
              //             fontSize: 30.0,
              //             fontWeight: FontWeight.bold,
              //
              //           ),
              //
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),

    ];
    return A[index];
  }

  Widget buildItem () {
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
                    'Bin ID : ',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Text('21/5/2022, 02:54 PM'),
                  SizedBox(height: 10.0,),
                  Text('Location: 15485, 45645'),
                  // Container(
                  //   width: 220.0,
                  //   child: RoundedProgressBar(
                  //     percent: 70.0,
                  //     height: 22.0,
                  //     style: RoundedProgressBarStyle(
                  //         colorProgress: Colors.teal,
                  //         colorProgressDark: Colors.teal.shade600,
                  //         backgroundProgress: Colors.teal.shade100
                  //
                  //
                  //     ),
                  //   ),
                  // ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getaccountinfo(dynamic uid)async{
    dynamic user = await DataBase_Manager().getworkers();
    if (user == null){
      print('unable to relieve');
    }
    else {
      for (int i =0 ; i < user!.length ; i++){
        if(user[i]['uid'] == uid){
          setState(() {
            name = user[i]['display_name'];
            n_id = user[i]['national_id'];
          });
        }
      }
    }
}

}