import 'dart:convert';

import 'package:farm_soft/Bus_home.dart';
import 'package:farm_soft/view_ntfctn.dart';
import 'package:farm_soft/view_seed.dart';
import 'package:farm_soft/view_tip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:farm_soft/delivery_satff/delhome.dart';

import 'customer/Edit_cust_regi.dart';
import 'customer/cushome.dart';
import 'customer/cust_reg.dart';
import 'farmer_reg.dart';
import 'forgt_pswd.dart';
import 'home.dart';
import 'ip_address.dart';




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
  runApp(const login());
}

class login extends StatelessWidget {
  const login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HOME',
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
      home: const loginpage(title: 'LOGIN PAGE'),
      routes: {
        '/Farmer_regpage':(context)=>Farmer_regpage(title: '',),
        '/homepage':(context)=>Farm_homepagePage(title: '',),

        '/logout':(BuildContext context)=>loginpage(title: '',),
        '/View_diseas':(context)=>Disease_view_page(title: '',),
        '/View_feedback':(context)=>Feed_view_page(title: '',),
        '/View_fertilizer':(context)=>Fert_view_page(title: '',),
        '/View_land':(context)=>Land_view_page(title: '',),
        '/View_news':(context)=>News_view_page(title: '',),
        '/View_del':(context)=>view_del_f_page(title: '',),
        '/View_ordr':(context)=>Order_view_page(title: '',),
        '/View_officer':(context)=>Officer_view_page(title: '',),
        '/View_prof':(context)=>View_prof_page(title: '',),
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

class loginpage extends StatefulWidget {
  const loginpage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _fmkey = new GlobalKey<FormState>();

  TextEditingController uname = new TextEditingController();
  TextEditingController pswd = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return WillPopScope(
      onWillPop: () async {
        // Navigator.pop(context);
        // Add your logic here for handling the back button press
        // Navigate back to the login page when the back button is pressed
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => home()),
        // );
        // Prevent the default back navigation
        return true;
      },


      child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the loginpage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('LOGIN PAGE'),
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
                    key: _fmkey,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 100.0),
                    padding: EdgeInsets.all(20.0),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [


                        Image.asset('assets/images/logo1.png', width: 150,
                          // Adjust the width as needed
                          height: 150,),
                        // Text(
                        //   'Farmsoft',
                        //   style: TextStyle(
                        //     fontSize: 28.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          // validator: (v){
                          //   if (v!.isEmpty) {
                          //     return 'Please enter your username';
                          //   }
                          //   return null;
                          // },
                          controller: uname,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Enter Your Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          // validator: (v){
                          //   if (v!.isEmpty) {
                          //     return 'Please enter your password';
                          //   }
                          //   return null;
                          // },

                          controller: pswd,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Enter Your Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Forgot_pswd()),
                              );
                            }, child: Text('Forgot password?')),
                          ],
                        ),
                        SizedBox(height: 20,),


                        ElevatedButton.icon(
                          onPressed: () {
                            // if (_fmkey.currentState!.validate()) {
                            //   Fluttertoast.showToast(
                            //       msg: "Invalid",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.BOTTOM,
                            //       backgroundColor: Colors.grey,
                            //       textColor: Colors.white,
                            //       fontSize: 12.0
                            //   );

                            login();
                            // }
                          },
                          // Add the icon here
                          label: Text('Login'),
                          icon: Icon(Icons.login),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New Farmer?"), TextButton(onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Farmer_reg()),
                              );
                              // Navigator.pushNamed(context, '/Farmer_regpage');

                            }, child: Text('Signup here')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New C"
                                "ustomer?"), TextButton(onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Cust_reg()),
                              );
                            }, child: Text('Signup here')),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        // backgroundColor: Colors.grey[300],
      ),
    );
  }

  Future<void> login()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String jdata= "";
    try{
      String username=uname.text;
      String paswrd=pswd.text;
      String Url = pref.getString("url").toString();
      var data = await http.post(
          Uri.parse(Url+"and_login"),body:
      {
        "username":username,
        "password":paswrd,
      }
      );
      print(data);
      var jasondata = json.decode(data.body);
      jdata=jasondata['status'].toString();
      if(jdata=="ok") {
        String lid = jasondata['lid'].toString();
        String type = jasondata['type'].toString();
        print(type);
        pref.setString("lid", lid);
        if (type == 'farmer') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Farm_homepagePage(title: "Home")),
          );
          // Navigator.pushNamed(context, '/homepage');
        }
        else if(type == 'customer'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const cus_home_page(title: 'Home',)),
          );
        }
        else if(type == 'delivery_staff') {

          print("==================Dstaff");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const del_home_page(title: '',)),
          );
        }
        else{

          Fluttertoast.showToast(
              msg: "Invalid",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0
          );
        }
      }
      // else{
      //   Navigator.pushNamed(context, '/signup');
      // }
    }catch(e){
      print("Error--------------"+e.toString());
    }



  }
}
