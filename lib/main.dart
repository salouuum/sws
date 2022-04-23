import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sws/welcome.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 500,
      animationDuration: Duration(seconds: 4),
      nextScreen: WelcomeScreen(),
      splash: Container(
        height: 300,
        width: 300,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                fit: BoxFit.fill,
                image: AssetImage('images/Bin0.png'),
                width: 300,
                height: 300,
              ),
              SizedBox(height: 15,),
              Text(
                'Smart Waste System',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                'of Compound X',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

    ),


    );
  }


}



