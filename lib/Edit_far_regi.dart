import 'dart:convert';
import 'dart:io';
// import 'dart:js';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/login.dart';

import 'home.dart';

void main() {
  runApp(const Edit_far_reg());
}

class Edit_far_reg extends StatelessWidget {
  const Edit_far_reg({super.key});

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
      home: const far_edit_reg_page(title: 'EDIT PROFILE'),
    );
  }
}

class far_edit_reg_page extends StatefulWidget {
  const far_edit_reg_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<far_edit_reg_page> createState() => _far_edit_reg_pageState();
}

class _far_edit_reg_pageState extends State<far_edit_reg_page> {
  final _fmkey=new GlobalKey<FormState>();
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





  TextEditingController name=new TextEditingController();
  TextEditingController dob=new TextEditingController();
  TextEditingController gender=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  // TextEditingController email=new TextEditingController();
  TextEditingController place=new TextEditingController();
  TextEditingController post=new TextEditingController();
  TextEditingController pin=new TextEditingController();
  TextEditingController district=new TextEditingController();
  TextEditingController state=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdel();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE PROFILE'),
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

          child: Form(
            key: _fmkey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uploadimage == null?
                InkWell(onTap: (){
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




                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  if(_fmkey.currentState!.validate()){

                    SignupJS();


                  }
                }, child: Text('Update'))

              ],
            ),
          ),
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
    url = Url;
    String lid = sh.getString("lid").toString();
    // String d_login_id = sh.getString("d_login_id").toString();
    var data = await http.post(Uri.parse(Url + "far_prof_data_edit"), body: {
      'lid': lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    String nm = jsonData['farmer_name'].toString();
    String phn = jsonData['phone'].toString();
    // String eml = jsonData['email'].toString();
    String plc = jsonData['farmer_place'].toString();
    String pst = jsonData['post'].toString();
    String pn = jsonData['pin'].toString();
    String dist = jsonData['district'].toString();
    String stt = jsonData['state'].toString();
    String pht = jsonData['photo'].toString();
    String id = jsonData['login_id'].toString();

    setState(() {
      name.text = nm.toString();
      phone.text = phn.toString();
      // email.text = eml.toString();
      place.text = plc.toString();
      post.text = pst.toString();
      pin.text = pn.toString();
      district.text = dist.toString();
      state.text = stt.toString();
      photo=pht.toString();
      url = Url;
    });
  }


  Future<void>SignupJS()async{
    final ips = await SharedPreferences.getInstance();
    String url = ips.getString("url").toString();
    String lid = ips.getString("lid").toString();
    if (uploadimage == null) {
      try {
        String nm = name.text.toString();
        String phn = phone.text.toString();
        // String eml = email.text.toString();
        String plc = place.text.toString();
        String pst = post.text.toString();
        String pn = pin.text.toString();
        String dist = district.text.toString();
        String stt = state.text.toString();
        // final bytes = File(uploadimage!.path).readAsBytesSync();
        // String base64Image =  base64Encode(bytes);
        // print("img_pan : $base64Image");


        var data = await http.post(
            Uri.parse(url + "far_register_edit"),
            body: {
              'nm': nm,
              "phn": phn,
              // "eml": eml,
              "plc": plc,
              "pst": pst,
              "pn": pn,
              "dist": dist,
              "stt": stt,
              "lid": lid,
              "photo": 'none'
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
          Navigator.push(
            context as BuildContext,
            MaterialPageRoute(builder: (context) => const home()),
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
        String phn = phone.text.toString();
        // String eml = email.text.toString();
        String plc = place.text.toString();
        String pst = post.text.toString();
        String pn = pin.text.toString();
        String dist = district.text.toString();
        String stt = state.text.toString();
        final bytes = File(uploadimage!.path).readAsBytesSync();
        String base64Image =  base64Encode(bytes);
        print("img_pan : $base64Image");


        var data = await http.post(
            Uri.parse(url + "far_register_edit"),
            body: {
              'nm': nm,
              "phn": phn,
              // "eml": eml,
              "plc": plc,
              "pst": pst,
              "pn": pn,
              "dist": dist,
              "stt": stt,
              "lid": lid,
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
          Navigator.push(
            context as BuildContext,
            MaterialPageRoute(builder: (context) => const home()),
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


      }
    }



