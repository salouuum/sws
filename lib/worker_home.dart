import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sws/profile.dart';
import 'package:sws/requests.dart';
import 'package:sws/worker_map.dart';
import 'allbins.dart';

class StaffHome extends StatefulWidget {
final dynamic uid ;
StaffHome({
  required this.uid,
});

  @override
  State<StaffHome> createState() => _StaafHomeState();
}

class _StaafHomeState extends State<StaffHome> {

  int current = 0;
  List<Widget> screen = [
    Worker_Map(),
    Requests(),
  ];
  int FAB = 0;
  List<IconData> icon = [
    Icons.list ,
    Icons.map ,
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfileScreen(uid : widget.uid)));
            },
            icon: Icon(Icons.account_circle_outlined)),
        title: Text('Home')
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        currentIndex: current,
        onTap: (index){
          setState(() {
            current = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.restore_from_trash),label: 'All Bins',),
          BottomNavigationBarItem(icon: Icon(Icons.location_on),label: 'Requests'),
        ],
      ),
      body: screen[current],
    );
  }
}

