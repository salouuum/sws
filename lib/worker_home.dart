import 'package:flutter/material.dart';

import 'package:sws/Bins_List.dart';
import 'package:sws/requests.dart';
import 'package:sws/worker_map.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({Key? key}) : super(key: key);

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
  List<Widget> body =[
    Worker_Map(),
    BinList(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home'),
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

