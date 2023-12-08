import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View_f_prdct.dart';
import 'home.dart';
import 'login.dart';


void main() {
  runApp(const Add_stock());
}

class Add_stock extends StatelessWidget {
  const Add_stock({super.key});

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
      home: const Add_Stock_page(title: 'ADD STOCK'),
    );
  }
}

class Add_Stock_page extends StatefulWidget {
  const Add_Stock_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Add_Stock_page> createState() => _Add_Stock_pageState();
}

class _Add_Stock_pageState extends State<Add_Stock_page> {
  final _fmkey=new GlobalKey<FormState>();

  TextEditingController qnty=new TextEditingController();




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
        // Here we take the value from the Add_Stock_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/images/bg5.jpg'),
    fit: BoxFit.cover,
    ),
    ),
    padding: const EdgeInsets.all(5.0),
    child: Center(

        child: Form(


          key: _fmkey,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Padding(
                padding: const EdgeInsets.only(left: 40.0,right: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: qnty,
                  validator: (v){
                    if(v!.isEmpty){
                      return 'Give Stock Quantity';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Stock Quantity'


                  ),

                ),
              ),








              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                if(_fmkey.currentState!.validate()){

                  SignupJS();


                }

              }, child: Text('ADD'))

            ],
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
    String prdct_id = ips.getString("prdct_id").toString();

    String qty = qnty.text.toString();




    var data = await http.post(
        Uri.parse(url + "far_stock_add"),
        body: {
          'qty': qty,
          "prdct_id":prdct_id


        });
    print(data);
    var jasondata = json.decode(data.body);
    String status = jasondata['status'].toString();

    if (status == "ok") {
      Fluttertoast.showToast(
          msg: "Stock Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Product_view_f()),
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


