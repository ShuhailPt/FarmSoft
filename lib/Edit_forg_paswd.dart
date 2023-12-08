import 'dart:convert';
import 'dart:io';
// import 'dart:js';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/login.dart';

import 'home.dart';

void main() {
  runApp(const Edit_for_pswd());
}

class Edit_for_pswd extends StatelessWidget {
  const Edit_for_pswd({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const Edit_for_pswd_page(title: 'EDIT PROFILE'),
    );
  }
}

class Edit_for_pswd_page extends StatefulWidget {
  const Edit_for_pswd_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Edit_for_pswd_page> createState() => _Edit_for_pswd_pageState();
}

class _Edit_for_pswd_pageState extends State<Edit_for_pswd_page> {
  final _fmkey=new GlobalKey<FormState>();

  // File? uploadimage;
  //
  // Future<void> chooseImage() async {
  //   final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   //set source: ImageSource.camera to get image from camera
  //   setState(() {
  //     uploadimage = File(choosedimage!.path);
  //   });
  // }

  TextEditingController password=new TextEditingController();
  TextEditingController con_password=new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('CHANGE PASSWORD'),
      ),
      body: SingleChildScrollView(
        child: Center(

          child: Form(
            key: _fmkey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5, left: 10, right: 10),
                  child: TextFormField(
                    controller: password,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Enter New Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5, left: 10, right: 10),
                  child: TextFormField(
                    controller: con_password,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Confirm Password';
                      }
                      if (v != password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Re-Enter Password',
                      prefixIcon: Icon(Icons.lock_outlined),
                    ),
                  ),
                ),


                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  if(_fmkey.currentState!.validate()){

                    SignupJS();


                  }
                }, child: Text('Submit'))

              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void>SignupJS()async{
    final ips = await SharedPreferences.getInstance();
    try{
      String url = ips.getString("url").toString();
      String lid = ips.getString("lid").toString();

      String pswd = password.text.toString();
      String cpswd = con_password.text.toString();



      var data = await http.post(
          Uri.parse(url+"forgt_password"),
          body: {

            "pswd":pswd,
            "cpswd":cpswd,
            "lid":lid

          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){

        Fluttertoast.showToast(
            msg: "Changed success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => const login()),
        );


      }
      else{
        Fluttertoast.showToast(
            msg: "error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );

      }
    }catch(e){
      Fluttertoast.showToast(
          msg: "eeeee-connection"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0
      );
      print("Error--------------"+e.toString());
    }


  }
}
