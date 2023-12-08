import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

void main() {
  runApp(const Cust_reg());
}

class Cust_reg extends StatelessWidget {
  const Cust_reg({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const Cust_regpage(title: 'CUSTOMER REGISTRATION'),
    );
  }
}

class Cust_regpage extends StatefulWidget {
  const Cust_regpage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Cust_regpage> createState() => _Cust_regpageState();
}

class _Cust_regpageState extends State<Cust_regpage> {
  final _fmkey=new GlobalKey<FormState>();
  String selctdgendr='Male';

  File? uploadimage;

  Future<void> chooseImage() async {
    final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }




  DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );


    if (picked != null) {
      setState(() {
        dob.text = _dateFormatter.format(picked);
      });
      Fluttertoast.showToast(
          msg: ""+_dateFormatter.format(picked).toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0
      );
    }

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Cust_regpage object that was created by
        // the App.build method, and use it to set our appbar title.
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
        child: Center(

          child:Form(
            key: _fmkey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                InkWell(onTap: (){
                  chooseImage();
                },
                    child:uploadimage == null?
                    CircleAvatar(child: Icon(Icons.person),radius: 80,) :
                    CircleAvatar(backgroundImage: FileImage(uploadimage!),radius: 80,),

                ),

                // CircleAvatar(child: Icon(Icons.person),radius: 80,),
                Padding(
                    padding: const EdgeInsets.only(top: 10,bottom:5,left: 10,right: 10 ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Full name',
                        prefixIcon: Icon(Icons.person_outline),


                      ),
                      controller: name,
                      validator: (v){
                        if(v!.isEmpty){
                          return 'Enter Name';
                        }
                        return null;
                      },


                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10 ),
                  child: TextFormField(
                    // keyboardType: TextInputType.datetime,
                    controller: dob,
                    onTap: (){
                      _selectDate(context);
                    },
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Enter Date Of Birth';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Date of Birth',
                      prefixIcon: Icon(Icons.date_range_outlined),


                    ),

                  ),
                ),
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
                SizedBox(height: 5,),
                Container(
                  // padding: EdgeInsets.only(left: 40.0,right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color when not focused
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child:Padding(
                    padding:EdgeInsets.only(top: 1,bottom: 1,right: 10,left: 10) ,
                    child:
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text('Male'),
                          value: 'Male',
                          groupValue: selctdgendr,
                          onChanged: (value) {
                            setState(() {
                              selctdgendr = value!;
                            });
                          },
                          // controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0.0),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text('Female'),
                          value: 'Female',
                          groupValue: selctdgendr,
                          onChanged: (value) {
                            setState(() {
                              selctdgendr = value!;
                            });
                          },
                          // controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0.0),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text('Other'),
                          value: 'Other',
                          groupValue: selctdgendr,
                          onChanged: (value) {
                            setState(() {
                              selctdgendr = value!;
                            });
                          },
                          // controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0.0),
                        ),
                      ),
                    ],
                  ),
                  )
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10 ),
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
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10 ),
                  child: TextFormField(
                    controller: post,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Enter the Post';
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
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10 ),
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
                      prefixIcon: Icon(Icons.area_chart_outlined),


                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 10,right: 10 ),
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
                        Signupcus();
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
    ),
      ),
    );
  }


Future<void>Signupcus()async {
  final ips = await SharedPreferences.getInstance();
  try {
    String url = ips.getString("url").toString();

    String nm = name.text.toString();
    String dob1 = dob.text.toString();
    // String gender = selectedGender.toString();
    String phn = phone.text.toString();
    String eml = email.text.toString();
    String gndr = selctdgendr.toString();
    String plc = place.text.toString();
    String pst = post.text.toString();
    String pn = pin.text.toString();
    String dist = district.text.toString();
    String stt = state.text.toString();
    String pswd = password.text.toString();
    String cpswd = con_password.text.toString();

    final bytes = File(uploadimage!.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    print("img_pan : $base64Image");

    print("=====================================================ok");


    var data = await http.post(
        Uri.parse(url + "cust_reg"),
        body: {
          'nm': nm,
          "dob1": dob1,
          "phn": phn,
          "eml": eml,
          "gndr": gndr,
          "plc": plc,
          "pst": pst,
          "pn": pn,
          "dist": dist,
          "stt": stt,
          // "pswd": password,
          "cpswd": cpswd,
          "photo": base64Image
        });
    print(data);
    var jasondata = json.decode(data.body);
    String status = jasondata['status'].toString();

    if (status == "ok") {
      Fluttertoast.showToast(
          msg: "Registration success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const login()),
      );
    }
    else {
      Fluttertoast.showToast(
          msg: "Registration error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
        msg: "eeeee-connection" + e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 12.0
    );
    print("Error--------------" + e.toString());
  }
}
}

