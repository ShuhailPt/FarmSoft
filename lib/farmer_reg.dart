import 'dart:convert';
// import 'dart:ffi';
import 'dart:io';
// import 'dart:js';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/login.dart';

import 'ip_address.dart';

void main() {
  runApp(const Farmer_reg());
}

class Farmer_reg extends StatelessWidget {
  const Farmer_reg({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: const Farmer_regpage(title: 'Farmer Registration'),
      routes: {
        '/login':(context)=>login(),

      },
    ),
        onWillPop: ()async{
      Navigator.pop(context);
      return false;
    });
  }
}

class Farmer_regpage extends StatefulWidget {
  const Farmer_regpage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Farmer_regpage> createState() => _Farmer_regpageState();
}

class _Farmer_regpageState extends State<Farmer_regpage> {
  final _fmkey=new GlobalKey<FormState>();
  File? uploadimage;

  Future<void> chooseImage() async {
    final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }
  TextEditingController name=new TextEditingController();
  TextEditingController dob=new TextEditingController();
  TextEditingController gender=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController place=new TextEditingController();
  TextEditingController post=new TextEditingController();
  TextEditingController pin=new TextEditingController();
  TextEditingController district=new TextEditingController();
  TextEditingController state=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController con_password=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:  Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: SingleChildScrollView(

              child: Form(
                key: _fmkey,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(onTap: (){
                      chooseImage();
                    },
                      child:uploadimage == null? CircleAvatar(child: Icon(Icons.person),radius:90,):
                      CircleAvatar(backgroundImage: FileImage(uploadimage!),radius:90,),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10),
                        child: TextFormField(
                          controller: name,
                          validator: (v){
                            if(v!.isEmpty){
                              return 'Enter Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person_outline),


                          ),

                        )
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 40.0,right: 10),
                    //   child: TextFormField(
                    //     controller: dob,
                    //     validator: (v){
                    //       if(v!.isEmpty){
                    //         return 'Enter Date Of Birth';
                    //       }
                    //       return null;
                    //     },
                    //     decoration: InputDecoration(labelText: 'Date Of Birth'),
                    //
                    //   ),
                    //     ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 5, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phone,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter Phone';
                          }
                          if (v.length < 10) {
                            return 'Phone number must contain at least 10 digits';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 5, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter Email';
                          }
                          // Email format validation
                          bool isValid = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
                              .hasMatch(v);
                          if (!isValid) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10),
                      child: TextFormField(
                        controller: place,
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Enter Place';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Place',
                          prefixIcon: Icon(Icons.place_outlined),



                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10),
                      child: TextFormField(
                        controller: post,
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Enter Post';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Post',
                          prefixIcon: Icon(Icons.local_post_office_outlined),




                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 5, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: pin,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter Pin code';
                          }
                          if (v.length != 6) {
                            return 'Pin code must contain 6 digits';
                          }
                          if (v.length > 6) {
                            return 'Pin code must not exceed 6 digits';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Pin code',
                          prefixIcon: Icon(Icons.pin_drop_outlined),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10),
                      child: TextFormField(
                        controller: district,
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Enter District';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'District',
                          prefixIcon: Icon(Icons.maps_home_work_outlined),



                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10),
                      child: TextFormField(
                        controller: state,
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Enter State';

                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'State',
                          prefixIcon: Icon(Icons.map_outlined),



                        ),

                      ),
                    ),
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
                          labelText: 'Create a Password',
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
                    ElevatedButton.icon(
                      onPressed: () {




                        if(_fmkey.currentState!.validate()){
                          if(uploadimage==null){
                            Fluttertoast.showToast(
                                msg: "MUST UPLOAD PHOTO",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );
                          }else{
                            SignupJS();
                          }



                        }
                      },
                      // Add the icon here
                      label: Text('Register'),
                      icon: Icon(Icons.save),
                    ),




                  ],
                ),
              ),
            ),
          ),
        )
    ),
        onWillPop: ()async {
          Navigator.pop(context);
          return false;
        });
  }



Future<void>SignupJS()async{
  final sh = await SharedPreferences.getInstance();
  try{
    String url = sh.getString("url").toString();

    String nm = name.text.toString();
    // String dob1 = dob.text.toString();
    // String gender = selectedGender.toString();
    String phn = phone.text.toString();
    String eml = email.text.toString();
    String plc = place.text.toString();
    String pst = post.text.toString();
    String pn = pin.text.toString();
    String dist = district.text.toString();
    String stt = state.text.toString();
    String pswd = password.text.toString();
    String cpswd = con_password.text.toString();
    final bytes = File(uploadimage!.path).readAsBytesSync();
    String base64Image =  base64Encode(bytes);
    print("img_pan : $base64Image");


    var data = await http.post(
        Uri.parse(url+"far_register"),
        body: {
          'nm':nm,
          // "dob":dob,
          "phn":phn,
          "eml":eml,
          "plc":plc,
          "pst":pst,
          "pn":pn,
          "dist":dist,
          "stt":stt,
          // "pswd":password,
          "cpswd":cpswd,
          "photo":base64Image,
        });
    print(data);
    var jasondata = json.decode(data.body);
    String status=jasondata['status'].toString();

    if(status=="ok"){

      Fluttertoast.showToast(
          msg: "Registration success",
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
          msg: "Registration error",
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
