

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farm_soft/home.dart';
import 'package:farm_soft/view_ntfctn.dart';
import 'package:farm_soft/view_seed.dart';
import 'package:farm_soft/view_tip.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Add_stock.dart';
import 'Crop_view.dart';
import 'Del_Add.dart';
import 'Edit_del.dart';
import 'View_deli.dart';
import 'View_diseas.dart';
import 'View_f_prdct.dart';
import 'View_feedback.dart';
import 'View_fert.dart';
import 'View_land.dart';
import 'View_news.dart';
import 'View_officer.dart';
import 'View_order.dart';
import 'View_profile.dart';
import 'View_pymnt.dart';
import 'View_status.dart';
import 'View_sub.dart';
import 'add_prod.dart';
import 'chat.dart';
import 'demo.dart';
import 'login.dart';


void main() {
  runApp(const Farm_homepage());
}

class Farm_homepage extends StatelessWidget {
  const Farm_homepage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'student_homepage',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: const Farm_homepagePage(title: 'Farmer Home'),
      routes: {

        '/logout':(BuildContext context)=>loginpage(title: '',),
        '/View_diseas':(context)=>Disease_view_page(title: '',),
        '/View_feedback':(context)=>Feed_view_page(title: '',),
        '/View_fertilizer':(context)=>Fert_view_page(title: '',),
        '/View_land':(context)=>Land_view_page(title: '',),
        '/View_news':(context)=>News_view_page(title: '',),
        '/View_del':(context)=>view_del_f_page(title: '',),
        '/View_ordr':(context)=>Order_view_page(title: '',),
        '/View_officer':(context)=>Officer_view_page(title: '',),
        '/View_prof':(context)=>View_prof(),
        '/View_seed':(context)=>Seed_view_page(title: '',),
        '/View_status':(context)=>Status_view_page(title: '',),
        '/View_sub':(context)=>Subsd_view_page(title: '',),
        '/Add_prod':(context)=>Add_product_page(title: '',),
        '/Add_stock':(context)=>Add_Stock_page(title: '',),
        '/Add_del':(context)=>Add_del_page(title: '',),
        '/Edit_del':(context)=>Edit_del_page(title: '',),
        '/View_pro':(context)=>Product_view_f_page(title: '',),
        '/View_tip':(context)=>tip_view_page(title: '',),
        '/View_ntf':(context)=>Ntfctn_view_page(title: '',),
        '/Chat':(context)=>MyChatPage(title: '',),
        '/Pay':(context)=>Pay_view_page(title: '',),
        '/Logout':(context)=>loginpage(title: '',),
        '/Crop_view':(context)=>Crop_view_page(title: '',),
      },
    );
  }
}

class Farm_homepagePage extends StatefulWidget {
  const Farm_homepagePage({super.key, required this.title});


  final String title;

  @override
  State<Farm_homepagePage> createState() => _BusHomePageState();
}

class _BusHomePageState extends State<Farm_homepagePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdata();
  }
  String url='';
  String Url='';
  String photo='';
  String farmer_name='Test';



  @override

  Widget build(BuildContext context) {


    return WillPopScope(
        onWillPop: () async {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (dcontext) {
          return AlertDialog(
            title: const Text('Do you want to Logout?'),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);

                      // Navigator.push(dcontext, MaterialPageRoute(builder: (context) => login(),));
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {


                      // Navigator.push(
                      //           context,
                      //           MaterialPageRoute(builder: (context) => Farm_homepage()),
                      //         );
                      Navigator.pop(dcontext, false);
                    },
                    child: const Text('No'),


                  ),
                ],
              )
            ],
          );
        },
      );
      return shouldPop!;
    },
      child:
      Scaffold(
        appBar: AppBar(
          // Here we take the value from the homepage object that was created by
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

          padding: EdgeInsets.all(16.0),
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
                                        'assets/images/order.png', width: 120,
                                        // Adjust the width as needed
                                        height: 120,),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'VIEW ORDERS'
                                              '',
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Order_view(),));
                          // Navigator.pushNamed(context, '/View_ordr');
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
                                        'assets/images/of.jpg', width: 120,
                                        // Adjust the width as needed
                                        height: 120,),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'AGRICULTURE OFFICER'
                                              '',
                                          style: TextStyle(
                                            fontSize: 24,
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
                          // Navigator.pushNamed(context, '/View_officer');
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Officer_view()));
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
                                        'assets/images/news.png', width: 120,
                                        // Adjust the width as needed
                                        height: 120,),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'VIEW NEWS',
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
                          // Navigator.pushNamed(context, '/View_news');
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => News_view()));

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
                                        'assets/images/sub.png', width: 120,
                                        // Adjust the width as needed
                                        height: 120,),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'VIEW SUBSIDIES',
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
                          // Navigator.pushNamed(context, '/View_sub');
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Subsd_view()));
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
                                        'assets/images/FR.png', width: 100,
                                        // Adjust the width as needed
                                        height: 100,),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'VIEW FERTILIZER',
                                          style: TextStyle(
                                            fontSize: 26,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,

                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Fert_view()));
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
                                        'assets/images/crr.png', width: 120,
                                        // Adjust the width as needed
                                        height: 120,),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'VIEW CROPS',
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
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Crop_view()));
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
                                        'assets/images/seed.png', width: 120,
                                        // Adjust the width as needed
                                        height: 120,),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          'VIEW SEEDS',
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
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Seed_view()));
                          // Add your desired logic for the onPressed callback here
                          print('Card pressed');
                        }),



                    // ElevatedButton(
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 20.0),
                    //       Image(image: NetworkImage(
                    //           'https://cdn-icons-png.flaticon.com/128/1716/1716282.png')),
                    //       SizedBox(height: 10.0),
                    //       Text('Logout'),
                    //     ],
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => home()),
                    //     ); // Add your logic for Logout button here
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),


        drawer: Drawer( backgroundColor: Colors.grey[300],
          child: ListView(
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
                        farmer_name,
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
              // children: [

              // ListTile(
              //   leading: Icon(Icons.person_3_outlined),
              //   title: Text('DEMO'),
              //   onTap: () {
              //     Navigator.pushNamed(context, '/Demo');
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.person_2_outlined),
                title: Text('VIEW PROFILE'),
                onTap: () {
                  // Navigator.pushNamed( MaterialPageRoute( builder: (context) => View_prof())
                  Navigator.push(context, MaterialPageRoute(
                              builder: (context) => View_prof()));
                },
              ),
              ListTile(
                leading: Icon(Icons.add_shopping_cart),
                title: Text('ADD PRODUCTS'),
                onTap: () {
                  // Navigator.pushNamed(context, '/Add_prod');
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Add_product()));
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_basket_outlined),
                title: Text('VIEW PRODUCT'),
                onTap: () {
                  // Navigator.pushNamed(context, '/View_pro');
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Product_view_f()));
                },
              ),
              ListTile(
                leading: Icon(Icons.tips_and_updates_outlined),
                title: Text('VIEW TIPS'),
                onTap: () {
                  // Navigator.pushNamed(context, '/View_tip');
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => tip_view()));
                },
              ),
              ListTile(
                leading: Icon(Icons.payment_outlined),
                title: Text('VIEW PAYMENT'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Pay_view()));
                },
              ),
              ListTile(leading: Icon(Icons.share_location_outlined),
                title: Text('VIEW LAND'),
                onTap: () {
                  // Navigator.pushNamed(context, '/View_land');
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Land_view()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1_outlined),
                title: Text('ADD DELIVERY STAFF'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Add_del()));
                },
              ),
              ListTile(
                leading: Icon(Icons.delivery_dining_outlined),
                title: Text('VIEW DELIVERY STAFF'),
                onTap: () {
                  // Navigator.pushNamed(context, '/View_del');
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => view_del_f()));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.grass_outlined),
              //   title: Text('VIEW CROPS'),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(
              //         builder: (context) => Crop_view_page(title: '',)));
              //   },
              // ),
              // ListTile(
              //   title: Text('VIEW CROP DISEAS'),
              //   onTap: (){
              //     Navigator.pushNamed(context, '/View_diseas');
              //   },
              // ),

              ListTile(
                leading: Icon(Icons.reviews_outlined),
                title: Text('RATINGS & REVIEWS'),
                onTap: () {
                  // Navigator.pushNamed(context, '/View_feedback');
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Feed_view()));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.feedback_outlined),
              //   title: Text('CHAT'),
              //   onTap: (){
              //     Navigator.pushNamed(context, '/Chat');
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.energy_savings_leaf_outlined),
              //   title: Text('VIEW FERTILIZER'),
              //   onTap: () {
              //     Navigator.pushNamed(context, '/View_fertilizer');
              //   },
              // ),

              // ListTile(
              //   leading: Icon(Icons.newspaper_outlined),
              //   title: Text('VIEW NEWS'),
              //   onTap: () {
              //     Navigator.pushNamed(context, '/View_news');
              //   },
              // ),

              // ListTile(
              //   leading: Icon(Icons.trolley),
              //   title: Text('VIEW ORDER'),
              //   onTap: () {
              //     Navigator.pushNamed(context, '/View_ordr');
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.person_3_outlined),
              //   title: Text('VIEW AGRICULTURE OFFICERS'),
              //   onTap: () {
              //     Navigator.pushNamed(context, '/View_officer');
              //   },
              // ),


              // ListTile(
              //   leading: Icon(Icons.egg_outlined),
              //   title: Text('VIEW SEED'),
              //   onTap: () {
              //     Navigator.pushNamed(context, '/View_seed');
              //   },
              // ),

              ListTile(
                leading: Icon(Icons.signal_wifi_statusbar_null_rounded),
                title: Text('VIEW ORDER STATUS'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Status_view()));
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications_none_outlined),
                title: Text('VIEW NOTIFICATION'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Ntfctn_view()));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.newspaper_rounded),
              //   title: Text('SUBSIDIES'),
              //   onTap: () {
              //     Navigator.pushNamed(context, '/View_sub');
              //   },
              // ),


              // ListTile(
              //   title: Text('ADD STOCK'),
              //   onTap: (){
              //     Navigator.pushNamed(context, '/Add_stock');
              //   },
              // ),

              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('LOG OUT'),
                onTap: () {
                  // Navigator.pushNamed(context, '/Logout');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));

                },
              ),

            ],
          ),),
      ),
    );
  }

  Future<void> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"far_profile_view"),body: {
      'lid':lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    String nm = jsonData['farmer_name'].toString();
    String phot = jsonData['photo'].toString();

    setState(() {
      farmer_name=nm;
      photo=phot;
      url=Url;


    });


  }

}
