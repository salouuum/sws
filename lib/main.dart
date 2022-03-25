import 'package:flutter/material.dart';
import 'package:sws/map.dart';
import 'package:sws/user_home.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: User_Home(),
    );}
}
