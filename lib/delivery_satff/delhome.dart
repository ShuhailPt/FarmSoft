import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../View_news.dart';
import '../View_order.dart';
import '../login.dart';
import 'View_assigned_ordr.dart';
import 'View_prof.dart';
import 'View_prvs_order.dart';


void main() {
  runApp(const del_home());
}

class del_home extends StatelessWidget {
  const del_home({super.key});

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
      home: const del_home_page(title: 'DELIVERY STAFF HOME'),
      routes: {
        '/View_assig':(context)=>del_Order_view_page(title: '',),
        '/View_prof':(context)=>del_prof_page(title: '',),
        '/View_prorder':(context)=>p_order_view_page(title: '',),
        '/Logout':(context)=>loginpage(title: '',),

      },
    );
  }
}

class del_home_page extends StatefulWidget {
  const del_home_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<del_home_page> createState() => _del_home_pageState();
}

class _del_home_pageState extends State<del_home_page> {
  String url = '';
  String photo = '';
  String name = '';
  String gender = '';
  String dob = '';
  String email = '';
  String phone = '';
  String place = '';
  String post = '';
  String login_id = '';

  get index => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdata();
  }


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
        // Here we take the value from the del_home_page object that was created by
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
          child: Container(height: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Welcome back, User.',
                  //   style: TextStyle(
                  //     fontSize: 24.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 16.0),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 2.0,
                      children: [
                        // ElevatedButton(
                        //   child: Column(
                        //     children: [
                        //       SizedBox(height: 20.0),
                        //       Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3140/3140300.png')),
                        //       SizedBox(height: 10.0),
                        //       Text('Start Screening'),
                        //     ],
                        //   ),// add image
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => ScreenPage1()),
                        //     );// Add your logic for Start Screening button here
                        //   },
                        // ),

                        GestureDetector(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [Colors.blueGrey, Colors.green],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .stretch,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            'assets/images/dr.png', width: 120,
                                            // Adjust the width as needed
                                            height: 120,),
                                        ),
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Center(
                                            child: Text(
                                              'VIEW ASSIGNED ORDER',
                                              style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,

                                              ),
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                                        //   child: Text(
                                        //     'Subtitle',
                                        //     style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15,
                                        //       color: Colors.white,
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => del_Order_view(),));
                              // Navigator.pushNamed(context, '/View_assig');
                              // Add your desired logic for the onPressed callback here
                              print('Card pressed');
                            }),

                        GestureDetector(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [Colors.blueGrey, Colors.green],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .stretch,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            'assets/images/as.png', width: 120,
                                            // Adjust the width as needed
                                            height: 120,),
                                        ),
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Center(
                                            child: Text(
                                              'VIEW PREVIOUS ORDER',
                                              style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,

                                              ),
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                                        //   child: Text(
                                        //     'Subtitle',
                                        //     style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15,
                                        //       color: Colors.white,
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              // Navigator.pushNamed(context, '/View_prorder');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => p_order_view(),));
                              // Add your desired logic for the onPressed callback here
                              print('Card pressed');
                            }),














                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
    ),
        ),
        drawer: Drawer(child: ListView(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.green],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140, // Adjust the width and height as per your requirement
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue, // Choose your desired border color
                        width: 2, // Adjust the border width as per your preference
                      ),
                    ),
                    child: CircleAvatar(radius:70 ,backgroundImage: NetworkImage(url+photo),),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    name,
                    // "tet",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_3_outlined),
            title: Text('VIEW PROFILE'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => del_prof(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_outlined),
            title: Text('VIEW ASSIGNED ORDER'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => del_Order_view(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_rounded),
            title: Text('VIEW PREVIOUS ORDER'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => p_order_view(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('LOG OUT'),
            onTap: (){
              Navigator.pushNamed(context, '/Logout');
            },
          ),

        ],
      ),),

    );
  }
  Future<void> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url + "del_prof_view"), body: {
      'lid': lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    String nm = jsonData['d_s_name'].toString();
    String db = jsonData['d_s_dob'].toString();
    String gndr = jsonData['d_s_gender'].toString();
    String eml = jsonData['d_s_email'].toString();
    String  phn= jsonData['d_s_phone'].toString();
    String plc = jsonData['d_s_place'].toString();
    String pst = jsonData['d_s_post'].toString();
    String id = jsonData['d_login_id'].toString();
    String phot = jsonData['d_s_photo'].toString();

    setState(() {
      name = nm;
      login_id = lid;
      place = plc;
      phone = phn;
      email = eml;
      post = pst;
      dob = db;
      gender = gndr;
      photo = phot;
      url = Url;
    });
  }
}


