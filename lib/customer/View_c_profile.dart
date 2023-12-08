import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Edit_far_regi.dart';
import '../Edit_paswd.dart';
import 'Edit_c_paswd.dart';
import 'Edit_cust_regi.dart';



void main() {
  runApp(const View_c_prof());
}

class View_c_prof extends StatelessWidget {
  const View_c_prof({super.key});

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
      home: const View_c_prof_page(title: ''),
    );
  }
}

class View_c_prof_page extends StatefulWidget {
  const View_c_prof_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<View_c_prof_page> createState() => _View_c_prof_pageState();
}

class _View_c_prof_pageState extends State<View_c_prof_page> {
  String url='';
  String photo='';
  String state='';
  String district='';
  String pin='';
  String post='';
  String email='';
  String phone='';
  String place='';
  String name='';
  String gender='';
  String dob='';
  String login_id='';

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
          // Here we take the value from the View_c_prof_page object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('PROFILE'),
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
          child: Container(height: 900,
          child:Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
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
              title: Text(post + "," + "  " + pin),
            ),),
            SizedBox(height: 18,),
            Card(child:
            ListTile(
              leading: Icon(Icons.flag),
              title: Text(district + "," + "  " + state),
            ),),
            SizedBox(height: 18,),
            Center(
              child: Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: ()async{
                    final sh = await SharedPreferences.getInstance();
                    var snapshot;
                    // sh.setString("login_id", snapshot.data[index].login_id);

                    Navigator.push( context,
                      MaterialPageRoute(builder: (context) =>  Cus_edit_reg_page(title: '',)),);
                  }, child: Text('Update')),
                ],
              ),
            ),
                Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  ElevatedButton(onPressed: ()async{
                    final sh = await SharedPreferences.getInstance();
                    var snapshot;
                    // sh.setString("login_id", snapshot.data[index].login_id);

                    Navigator.push( context,
                      MaterialPageRoute(builder: (context) =>  Edit_c_pswd_page(title: '',)),);
                  }, child: Text('Change Password')),
              ],
            ),
                ),

          ],
          )
            ,),
        )
    ),),
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
    String dob1 = jsonData['cust_dob'].toString();
    String gndr = jsonData['cust_gender'].toString();
    String phn = jsonData['cust_phone'].toString();
    String eml = jsonData['cust_email'].toString();
    String plc = jsonData['cust_place'].toString();
    String pst = jsonData['cust_post'].toString();
    String pn = jsonData['cust_pin'].toString();
    String dis = jsonData['cust_district'].toString();
    String stt = jsonData['cust_state'].toString();
    String pht = jsonData['cust_photo'].toString();
    setState(() {
      name=nm;
      dob=dob1;
      gender=gndr;
      login_id=lid;
      place=plc;
      phone=phn;
      email=eml;
      post=pst;
      pin=pn;
      district=dis;
      state=stt;
      photo=pht;
      url=Url;


    });


  }





// Future<void>delete_services(nid)async{
//   final sh = await SharedPreferences.getInstance();
//   try{
//     String url = sh.getString("url").toString();
//
//
//     var data = await http.post(
//         Uri.parse(url+"js_delete_services"),
//         body: {'sid':nid
//         });
//     print(data);
//     var jasondata = json.decode(data.body);
//     String status=jasondata['status'].toString();
//
//     if(status=="ok"){
//       Fluttertoast.showToast(
//           msg: "Services deleted",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.grey,
//           textColor: Colors.white,
//           fontSize: 12.0
//       );
//       Navigator.pop(
//           context
//       );
//     }
//     else{
//       Fluttertoast.showToast(
//           msg: "Python error.. pleasse register",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.orangeAccent,
//           textColor: Colors.white,
//           fontSize: 12.0
//       );
//     }
//   }catch(e){
//     Fluttertoast.showToast(
//         msg: "eeeee"+e.toString(),
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.orangeAccent,
//         textColor: Colors.white,
//         fontSize: 12.0
//     );
//     print("Error--------------"+e.toString());
//   }
//
//
// }
}

//
// class JsService {
//   late final String farmer_name;
//   late final String farmer_place;
//   late final String phone;
//   late final String login_id;
//   late final String email;
//   late final String post;
//   late final String pin;
//   late final String district;
//   late final String state;
//   late final String photo;
//
//
//   JsService(this.farmer_name, this.farmer_place,this.phone, this.email,this.post, this.pin,this.district,this.state,this.photo,this.login_id,);
// }
