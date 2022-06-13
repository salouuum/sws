

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sws/database_manager/Database.dart';
import 'package:sws/services/authentication.dart';
import 'package:sws/worker_home.dart';

class Login_SWS extends StatefulWidget {
  @override
  State<Login_SWS> createState() => _Login_SWSState();
}

class _Login_SWSState extends State<Login_SWS> {
  Authentication _authentication = Authentication();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool ispassword =true;
  IconData icon = Icons.remove_red_eye;
  var FormKey = GlobalKey<FormState>();

  @override
  void initState()  {
    super.initState();

  }

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
          child: Form(
            key: FormKey,
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
                  'Use your work email and your password to log in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.0,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Work Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  validator: (value) {
                    if(value!.isEmpty){
                     return 'email can not be empty';
                    }
                  },
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ispassword = !ispassword;
                            icon = ispassword ? Icons.remove_red_eye : Icons
                                .visibility_off;
                          });
                        },
                      icon: Icon(icon),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'password cannot be empty';
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordcontroller,
                  obscureText: ispassword,
                ),
                SizedBox(height: 40.0,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.teal,
                  ),
                  child: MaterialButton(
                    onPressed: ()async{
                      dynamic user = await signin();
                      await savepref(user.uid.toString());
                      if(FormKey.currentState!.validate()){
                      if( user ==null){
                        print('something went wrong');
                      }else{
                        emailcontroller.clear();
                        passwordcontroller.clear();
                        print('login successed');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StaffHome(uid: user.uid)));
                      }
                    }
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
      ),
    );

  }

  dynamic signin() async{
    dynamic authresult = await _authentication.Login(emailcontroller.text, passwordcontroller.text);
    print(authresult.toString());
    return authresult;
  }
  savepref(String uid) async{
   final prefrences = await SharedPreferences.getInstance();
   await prefrences.setString('uid', uid);
  }
}
