

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/home.dart';
import 'package:farm_soft/login.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const Edit_del());
}

class Edit_del extends StatelessWidget {
  const Edit_del({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
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
      home: const Edit_del_page(title: 'ADDING DELIVERY STAFF'),
    );
  }
}

class Edit_del_page extends StatefulWidget {
  const Edit_del_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Edit_del_page> createState() => _Edit_del_pageState();
}

class _Edit_del_pageState extends State<Edit_del_page> {
  final _fmkey = new GlobalKey<FormState>();
  File? uploadimage;
  String photo='';
  String url='';

  Future<void> chooseImage() async {
    final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  String selctdgendr = 'Male';

  get index => null;

  //
  // Future<void> chooseImage() async {
  //   final choosedimage = await ImagePicker().pickImage(
  //       source: ImageSource.gallery);
  //   //set source: ImageSource.camera to get image from camera
  //   setState(() {
  //     uploadimage = File(choosedimage!.path);
  //   });
  // }

  DateFormat _dateFormatter = DateFormat('2023-05-02');

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
    }
  }

  TextEditingController name = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  // TextEditingController email = new TextEditingController();
  TextEditingController place = new TextEditingController();
  TextEditingController post = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdel();
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var snapshot;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Edit_del_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Update Delivery Staff'),
      ),
      body: SingleChildScrollView(
        child: Center(

          child: Form(
            key: _fmkey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uploadimage == null ?
                InkWell(onTap: () {
                  chooseImage();
                },
              child: CircleAvatar( radius: 80,
                backgroundImage: NetworkImage(url+photo),

                // backgroundImage: NetworkImage(urlp+snapshot.data[index].d_s_photo),
                ),):
            CircleAvatar(
                  backgroundImage: FileImage(uploadimage!), radius: 80,),

                // CircleAvatar(child: Icon(Icons.person),radius: 80,),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                  child: TextFormField(
                    onTap: (){
                      _selectDate(context);
                    },
                    keyboardType: TextInputType.datetime,
                    controller: dob,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Give Date of Birth';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Date of birth',
                      prefixIcon: Icon(Icons.date_range_outlined),


                    ),

                  ),
                ),
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
                          SizedBox(width: 2,),
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
                          SizedBox(width: 2,)
                        ],
                      ),
                    )
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
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0, bottom: 5, left: 10, right: 10),
                //   child: TextFormField(
                //     keyboardType: TextInputType.emailAddress,
                //     controller: email,
                //     validator: (v) {
                //       if (v!.isEmpty) {
                //         return 'Enter Email';
                //       }
                //       // Email format validation
                //       bool isValid = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
                //           .hasMatch(v);
                //       if (!isValid) {
                //         return 'Enter a valid email';
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       labelText: 'Email',
                //       prefixIcon: Icon(Icons.email_outlined),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                  child: TextFormField(
                    controller: place,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Enter place';
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
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
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


                SizedBox(height: 20,),
                ElevatedButton(onPressed: () {
                  if (_fmkey.currentState!.validate()) {
                      SignupJS();

                  }
                }, child: Text('Update'))

              ],
            ),
          ),
        ),
      ),
    );
  }
  String urlp='';
  Future<void> _getdel() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    String d_login_id = sh.getString("d_login_id").toString();
    var data = await http.post(Uri.parse(Url + "far_del_data_edit"), body: {
      'd_login_id': d_login_id
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    String nm = jsonData['d_s_name'].toString();
    String db = jsonData['d_s_dob'].toString();
    String gndr = jsonData['d_s_gender'].toString();
    // String eml = jsonData['d_s_email'].toString();
    String phn = jsonData['d_s_phone'].toString();
    String plc = jsonData['d_s_place'].toString();
    String pst = jsonData['d_s_post'].toString();
    String pht = jsonData['d_s_photo'].toString();
    String id = jsonData['d_login_id'].toString();

    setState(() {
      name.text = nm.toString();
      dob.text = db.toString();
      selctdgendr= gndr.toString();
      // email.text = eml.toString();
      phone.text = phn.toString();
      place.text = plc.toString();
      post.text = pst.toString();
      photo=pht.toString();
      url = Url;
    });
  }

  Future<void> SignupJS() async {
    final ips = await SharedPreferences.getInstance();
    String url = ips.getString("url").toString();
    String d_login_id = ips.getString("d_login_id").toString();
    if (uploadimage == null) {
      try {
        String nm = name.text.toString();
        String db = dob.text.toString();
        String gndr = selctdgendr.toString();
        String phn = phone.text.toString();
        // String eml = email.text.toString();
        String plc = place.text.toString();
        String pst = post.text.toString();

        // final bytes = File(uploadimage!.path).readAsBytesSync();
        // String base64Image =  base64Encode(bytes);
        // print("img_pan : $base64Image");


        var data = await http.post(
            Uri.parse(url + "far_edit_delvry"),
            body: {
              'nm': nm,
              "dob1": db,
              "gndr": gndr,
              "phn": phn,
              // "eml": eml,
              "plc": plc,
              "pst": pst,
              "photo": 'none',
              "d_login_id": d_login_id,

            });
        print(data);
        var jasondata = json.decode(data.body);
        String status = jasondata['status'].toString();

        if (status == "ok") {
          Fluttertoast.showToast(
              msg: " success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0
          );
          Navigator.pop(
            context,

          );
        }
        else {
          Fluttertoast.showToast(
              msg: " error",
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
    else {
      try {
        String nm = name.text.toString();
        String db = dob.text.toString();
        String gndr = selctdgendr.toString();
        String phn = phone.text.toString();
        // String eml = email.text.toString();
        String plc = place.text.toString();
        String pst = post.text.toString();

        final bytes = File(uploadimage!.path).readAsBytesSync();
        String base64Image = base64Encode(bytes);
        print("img_pan : $base64Image");


        var data = await http.post(
            Uri.parse(url + "far_edit_delvry"),
            body: {
              'nm': nm,
              "dob1": db,
              "gndr": gndr,
              "phn": phn,
              // "eml": eml,
              "plc": plc,
              "pst": pst,
              "d_login_id": d_login_id,
              "photo": base64Image
            });
        print(data);
        var jasondata = json.decode(data.body);
        String status = jasondata['status'].toString();

        if (status == "ok") {
          Fluttertoast.showToast(
              msg: "Updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0
          );
          Navigator.pop(
            context,
          );
        }
        else {
          Fluttertoast.showToast(
              msg: " error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0
          );
        }
      }
      catch (e) {
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
}




