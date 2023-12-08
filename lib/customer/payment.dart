

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/home.dart';
import 'package:farm_soft/login.dart';

import 'cushome.dart';

void main() {
  runApp(const Paymnt());
}

class Paymnt extends StatelessWidget {
  const Paymnt({super.key});

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
      home: const Paymnt_page(title: ''),
    );
  }
}

class Paymnt_page extends StatefulWidget {
  const Paymnt_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Paymnt_page> createState() => _Paymnt_pageState();
}

class _Paymnt_pageState extends State<Paymnt_page> {
  final _fmkey=new GlobalKey<FormState>();
  // File? uploadimage;
  //
  // String selctdgendr='Male';


  // Future<void> chooseImage() async {
  //   final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   //set source: ImageSource.camera to get image from camera
  //   setState(() {
  //     uploadimage = File(choosedimage!.path);
  //   });
  // }

  DateFormat _dateFormatter = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );


    if (picked != null) {
      setState(() {
        date.text = _dateFormatter.format(picked);
      });
    }
  }
  TextEditingController card_no=new TextEditingController();
  TextEditingController name=new TextEditingController();
  TextEditingController date=new TextEditingController();
  TextEditingController cvc=new TextEditingController();


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
        // Here we take the value from the Paymnt_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('PAYMENT'),
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
                // uploadimage == null?
                // InkWell(onTap: (){
                //   chooseImage();
                // },
                //     child: CircleAvatar(child: Icon(Icons.person),radius: 80,)
                // ):
                // CircleAvatar(backgroundImage: FileImage(uploadimage!),radius: 80,),
                //
                // // CircleAvatar(child: Icon(Icons.person),radius: 80,),
                // Padding(
                //     padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                //     child: TextFormField(
                //       controller: name,
                //       validator: (v){
                //         if(v!.isEmpty){
                //           return 'Enter Name';
                //         }
                //         return null;
                //       },
                //       decoration: InputDecoration(
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           labelText: 'Full Name'
                //
                //
                //       ),
                //
                //     )
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: card_no,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Enter Card Number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Card Number'


                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                  child: TextFormField(
                    controller: name,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Card Holder Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Card Holder Name'


                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                  child: TextFormField(
                    onTap: (){
                      _selectDate(context);
                    },
                    keyboardType: TextInputType.datetime,
                    controller: date,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Give Expiry Date';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Expiry Date'


                    ),

                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10) ,
                //   child: Container(
                //     // padding: EdgeInsets.only(left: 40.0,right: 10),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Colors.grey, // Border color when not focused
                //           width: 1.0,
                //         ),
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       child:Padding(
                //         padding:EdgeInsets.only(top: 1,bottom: 1,right: 10,left: 10) ,
                //         child:
                //         Row(
                //           children: [
                //             SizedBox(width: 2,),
                //             Expanded(
                //               child: RadioListTile(
                //                 title: Text('Male'),
                //                 value: 'Male',
                //                 groupValue: selctdgendr,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     selctdgendr = value!;
                //                   });
                //                 },
                //                 // controlAffinity: ListTileControlAffinity.leading,
                //                 contentPadding: EdgeInsets.all(0.0),
                //               ),
                //             ),
                //             Expanded(
                //               child: RadioListTile(
                //                 title: Text('Female'),
                //                 value: 'Female',
                //                 groupValue: selctdgendr,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     selctdgendr = value!;
                //                   });
                //                 },
                //                 // controlAffinity: ListTileControlAffinity.leading,
                //                 contentPadding: EdgeInsets.all(0.0),
                //               ),
                //             ),
                //             Expanded(
                //               child: RadioListTile(
                //                 title: Text('Other'),
                //                 value: 'Other',
                //                 groupValue: selctdgendr,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     selctdgendr = value!;
                //                   });
                //                 },
                //                 // controlAffinity: ListTileControlAffinity.leading,
                //                 contentPadding: EdgeInsets.all(0.0),
                //               ),
                //             ),
                //             SizedBox(width: 2,)
                //           ],
                //         ),
                //       )
                //   ),
                // ),



                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: cvc,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Enter CVC';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'CVC Code'


                    ),

                  ),
                ),


                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                //   child: TextFormField(
                //     controller: post,
                //     validator: (v){
                //       if(v!.isEmpty){
                //         return 'Enter Post';
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         labelText: 'Post'
                //
                //
                //     ),
                //
                //   ),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                //   child: TextFormField(
                //     controller: password,
                //
                //     validator: (v){
                //       if(v!.isEmpty){
                //         return 'Enter Password';
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         labelText: 'Password'
                //
                //
                //     ),
                //
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
                //   child: TextFormField(
                //     controller: con_password,
                //     validator: (v){
                //       if(v!.isEmpty){
                //         return 'Confirm Password';
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         labelText: 'Re-Enter Password'
                //
                //
                //     ),
                //   ),
                // ),


                SizedBox(height: 20,),

                ElevatedButton(onPressed: (){
                  if(_fmkey.currentState!.validate()){

                    SignupJS();


                  }
                }, child: Text('PAY'))

              ],
            ),
          ),
        ),
      ),
    ),
      ),
    );
  }

  Future<void>SignupJS()async {
    final ips = await SharedPreferences.getInstance();
    try {
      String url = ips.getString("url").toString();
      String lid = ips.getString("lid").toString();

      String nm = name.text.toString();
      String date1 = date.text.toString();
      String no = card_no.text.toString();
      String code = cvc.text.toString();






      var data = await http.post(
          Uri.parse(url + "cust_pay"),
          body: {
            'nm': nm,
            "date1": date1,
            "no": no,
            "cd": code,


            "lid":lid,
          });
      print(data);
      var jasondata = json.decode(data.body);
      String status = jasondata['status'].toString();

      if (status == "ok") {
        Fluttertoast.showToast(
            msg: "Payment Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Cus_home()),
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




