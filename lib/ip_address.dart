import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/login.dart';
// import 'dart:js';

void main() {


  runApp(const IP());
}

class IP extends StatelessWidget {
  const IP({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: MaterialApp(

      title: 'ip',
      debugShowCheckedModeBanner: false,
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
      home: const IPpage(title: 'IP'),
      routes: {
        '/login':(context)=>loginpage(title: '',),
      },
    ),
        onWillPop: ()async{
      Fluttertoast.showToast(msg: 'msg');
      Navigator.pop(context);
            return false;
        });
  }
}

class IPpage extends StatefulWidget {
  const IPpage({super.key, required this.title});


  final String title;

  @override
  State<IPpage> createState() => _IPpageState();
}

class _IPpageState extends State<IPpage> {
  final _fmkey = new GlobalKey<FormState>();

  TextEditingController ip = new TextEditingController();

  Future<void> next() async {
    setState(() {
      String ipa = ip.toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(child: Scaffold(
      appBar: AppBar(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 140),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                margin: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 100.0),
                padding: EdgeInsets.all(20.0),

                child: Form(
                  key: _fmkey,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'IP Address',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ), SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 40.0, right: 10, top: 10.0, bottom: 5),
                        child: TextFormField(
                          controller: ip,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Enter IP';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: 'IP'


                          ),

                        ),
                      ),

                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: () async {
                        if (_fmkey.currentState!.validate()) {
                          // TODO submit
                          SharedPreferences pref = await SharedPreferences
                              .getInstance();
                          String ipc = ip.text;
                          String url = "http://" + ipc.toString() + ":5000/";
                          pref.setString("url", url);
                          pref.setString("ip", ipc);
                          Fluttertoast.showToast(
                              msg: url,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 12.0
                          );

                          Navigator.pushNamed(context, '/login');

                        }
                      }, child: Text('Submit'))

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
        onWillPop: ()async{
      // Fluttertoast.showToast(msg: 'msggg');
      Navigator.pop(context);
      return false;
    });
  }
}
