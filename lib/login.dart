import 'package:flutter/material.dart';
import 'package:sws/worker_home.dart';


class Login_SWS extends StatelessWidget {
  const Login_SWS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Staff Members Login',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.0,),
              Text(
                'Login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0
                ),
              ),
              SizedBox(height: 35.0,),
              Text(
                'Use your work ID and your National ID to log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50.0,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Work ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'National ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 40.0,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.teal,
                ),
                child: MaterialButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffHome()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
