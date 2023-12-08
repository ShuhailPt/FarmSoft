import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const del_prof());
}

class del_prof extends StatelessWidget {
  const del_prof({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FEEDBACK',
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
      home: const del_prof_page(title: 'FEEDBACK'),
    );
  }
}

class del_prof_page extends StatefulWidget {
  const del_prof_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<del_prof_page> createState() => _del_prof_pageState();
}

class _del_prof_pageState extends State<del_prof_page> {
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
          // Here we take the value from the del_prof_page object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('VIEW PROFILE'),
        ),
        body: SingleChildScrollView(
    child: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/images/bg5.jpg'),
    fit: BoxFit.cover,
    ),
    ),
          child: Container(height: 700,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                SizedBox(height: 15,),
                Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25) ,),
                SizedBox(height: 18,),
                Card(child:
                ListTile(
                  leading:Icon(Icons.people) ,
                  title: Text(gender),
                ),),
                SizedBox(height: 18,),
                Card(child:
                ListTile(
                  leading:Icon(Icons.date_range) ,
                  title: Text(dob),
                ),),
                SizedBox(height: 18,),
                Card(child:
                ListTile(
                  leading:Icon(Icons.email) ,
                  title: Text(email),
                ),),
                SizedBox(height: 18,),
                Card(child:
                ListTile(
                  leading:Icon(Icons.phone) ,
                  title: Text(phone),
                ),),
                SizedBox(height: 18,),
                Card(child:
                ListTile(
                  leading: Icon(Icons.place),
                  title: Text(place),
                ),),
                SizedBox(height: 18,),
                Card(child:
                ListTile(
                  leading: Icon(Icons.local_post_office_outlined),
                  title: Text(post),
                ),),

                // Card(child:
                // ListTile(
                //   leading:Icon(Icons.location_on_sharp) ,
                //   title: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //
                //       Text(farmer_place),
                //       // Text(post),
                //       Text(post+","+"  "+district),
                //       Text(state),
                //       // Text(pin),
                //     ],
                //   ),
                // ),),

              ],
            )
            ,),
        )
        ),
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
    Fluttertoast.showToast(
        msg: "eeeee-connection"+jsonData[' d_s_gender'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 12.0
    );
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