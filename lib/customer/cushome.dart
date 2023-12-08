import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../View_news.dart';
import '../demo.dart';
import '../login.dart';
import 'Add_RR.dart';
import 'Edit_c_paswd.dart';
import 'Edit_cust_regi.dart';
import 'Feedback.dart';
import 'View_c_profile.dart';
import 'View_cart.dart';
import 'View_news.dart';
import 'View_prdct.dart';
import 'cart_qnty.dart';
import 'compl_rply.dart';
import 'complaint.dart';


void main() {
  runApp(const Cus_home());
}

class Cus_home extends StatelessWidget {
  const Cus_home({super.key});

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
      home: const cus_home_page(title: 'CUSTOMER HOME'),
      routes: {
        '/View_cart':(context)=>View_cart_page(title: '',),
        '/View_news':(context)=>News_c_view_page(title: '',),
        '/View_prdct':(context)=>Product_view_page(title: '',),
        '/Add_rr':(context)=>Add_RR_page(title: '',),
        '/Add_feed':(context)=>Add_feedback_page(title: '',),
        '/Add_cmplnt':(context)=>Add_complnt_page(title: '',),
        '/View_reply':(context)=>View_cmpl_rply_page(title: '',),
        '/Logout':(context)=>loginpage(title: '',),

        '/View_prof':(context)=>View_c_prof_page(title: '',),
      },
    );
  }
}

class cus_home_page extends StatefulWidget {
  const cus_home_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<cus_home_page> createState() => _cus_home_pageState();
}

class _cus_home_pageState extends State<cus_home_page> {
  String url='';
  String photo='';
  String login_id='';
  String name='';




  get index => null;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdatap();
    super.initState();
    _getdata();
  }










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
    child: Scaffold(
      appBar: AppBar(
        // Here we take the value from the cus_home_page object that was created by
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

        padding: EdgeInsets.all(5.0),
          child: FutureBuilder(
              future: _getdatap(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print("snapshot" + snapshot.toString());
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    // padding: EdgeInsets.all(5.0),
                    // shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return IntrinsicHeight(

                      child: Container(height: 260,
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar( radius: 50,
                                    backgroundImage: NetworkImage(urlp+snapshot.data[index].prdct_photo),
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Name:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].prdct_name,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Type:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].prdct_type,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Price:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].prdct_price,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                final sh = await SharedPreferences.getInstance();
                                                sh.setString("prdct_id", snapshot.data[index].prdct_id);

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Add_cart_page(title: '',)),
                                                );
                                              },
                                              icon: Icon(Icons.shopping_cart_outlined),
                                              label: Text('Add to Cart'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height:15 ,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            TextButton(onPressed: ()async{
                                              final sh = await SharedPreferences.getInstance();
                                              sh.setString("prdct_id", snapshot.data[index].prdct_id);

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const Add_RR()),
                                              );
                                            }, child: Text('Ratings & Reviews')),

                                          ],

                                        ),




                                      ],


                                    ),
                                  ),

                                )



                              ],
                            ),
                          ),
                      ),
                      );

                    },
                  );
                }
              }
          )





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
              Navigator.push(context, MaterialPageRoute(builder: (context) => View_c_prof(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_checkout),
            title: Text('VIEW CART ITEMS'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => View_cart(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.newspaper_outlined),
            title: Text('VIEW NEWS'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => News_c_view(),));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.shopping_basket_outlined),
          //   title: Text('VIEW PRODUCT'),
          //   onTap: (){
          //
          //     // Navigator.pushNamed(context, '/View_prdct');
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const Product_view_page(title: 'view product',)),
          //     );
          //
          //   },
          // ),
          // ListTile(
          //   title: Text('RATING AND REVIEW'),
          //   onTap: (){
          //     Navigator.pushNamed(context, '/Add_rr');
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.feedback_outlined),
            title: Text('FEEDBACK'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Add_feedback(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.report_problem_outlined),
            title: Text('COMPLAINT'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Add_complnt(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text('VIEW REPLY'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => View_cmpl_rply(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('LOG OUT'),
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));
              // Navigator.pop(context);
              showDialog<bool>(
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
                              Navigator.push(dcontext, MaterialPageRoute(builder: (dcontext) => login(),));
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
    var data = await http.post(Uri.parse(Url+"cust_profile_view"),body: {
      'lid':lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    String nm = jsonData['cust_name'].toString();
    String pht = jsonData['cust_photo'].toString();

    setState(() {
      name=nm;
      photo=pht;
      url=Url;


    });


  }



}

String urlp='';
Future<List<JsService>> _getdatap() async {
  final sh = await SharedPreferences.getInstance();
  String Url = sh.getString("url").toString();
  urlp = sh.getString("url").toString();
  String lid = sh.getString("lid").toString();
  var data = await http.post(Uri.parse(Url+"cust_prdct_view"),body: {
    'lid':lid
  });
  print("------------------------------hoiiiiiii---------------");
  print(data);
  var jsonData = json.decode(data.body);

  print(jsonData);
  List<JsService> jokes = [];
  for (var i in jsonData["data"]) {
    print(i);
    JsService newname =
    JsService(i['prdct_name'].toString(),i['prdct_type'].toString(),i['prdct_photo'].toString(),i['prdct_price'].toString(),i['prdct_id'].toString());
    jokes.add(newname);
  }
  return jokes;
}




class JsService{
  late final String prdct_name ;
  late final String prdct_type;
  late final String prdct_photo;
  late final String prdct_price;
  late final String prdct_id;
  JsService(this.prdct_name,this.prdct_type,this.prdct_photo,this.prdct_price,this.prdct_id);
}

