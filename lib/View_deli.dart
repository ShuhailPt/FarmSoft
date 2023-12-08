import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/Edit_prod.dart';

import 'Add_stock.dart';
import 'Edit_del.dart';
import 'View_f_stock.dart';
import 'home.dart';
void main() {
  runApp(const view_del_f());
}

class view_del_f extends StatelessWidget {
  const view_del_f({super.key});

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
      home: const view_del_f_page(title: ''),
    );
  }
}

class view_del_f_page extends StatefulWidget {
  const view_del_f_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<view_del_f_page> createState() => _view_del_f_pageState();
}

class _view_del_f_pageState extends State<view_del_f_page> {


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
        // Here we take the value from the view_del_f_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('VIEW DELIVERY STAFF'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: _getdata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("snapshot" + snapshot.toString());
            if (snapshot.data == null) {
              return const Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Card(
                      child: Container(
                        height: 450,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 0,
                              child:  Center(
                                child: Container(
                                  width: 120, // Adjust the width and height as per your requirement
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue, // Choose your desired border color
                                      width: 2, // Adjust the border width as per your preference
                                    ),
                                  ),
                                  child: CircleAvatar(radius: 50,
                                    backgroundImage: NetworkImage(urlp+snapshot.data[index].d_s_photo),),
                                ),
                              ),

                            ),
                            SizedBox(height: 10,),
                            Row(

                              children: [
                                Text('Name:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                                 SizedBox(width: 67,),
                                Text(
                                  snapshot.data[index].d_s_name,

                                ),
                              ],
                            ),
                            // SizedBox(height: 10,),
                            // Text(
                            //   snapshot.data[index].officer_name,
                            //   style: const TextStyle(
                            //     fontSize: 18.0,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Date of Birth:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 18,),
                                Text(
                                  snapshot.data[index].d_s_dob,

                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Gender:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 56,),
                                Text(
                                  snapshot.data[index].d_s_gender,

                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Email:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 67,),
                                Text(
                                  snapshot.data[index].d_s_email,

                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Phone:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 58,),
                                Text(
                                  snapshot.data[index].d_s_phone,

                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Place:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 64,),
                                Text(
                                  snapshot.data[index].d_s_place,

                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Post:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 69,),
                                Text(
                                  snapshot.data[index].d_s_post,

                                ),
                              ],
                            ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(onPressed: ()async{
                                        final sh = await SharedPreferences.getInstance();
                                        sh.setString("d_login_id", snapshot.data[index].d_login_id);

                                        Navigator.push( context,
                                          MaterialPageRoute(builder: (context) =>  Edit_del_page(title: '',)),);
                                      }, label: Text('Update'),
                                        icon: Icon(Icons.edit_outlined)

                                      ),
                                      SizedBox(width: 10,),
                                      ElevatedButton.icon(onPressed: (){
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          title: Text('Are you sure!'),
                                          actions: [
                                            ElevatedButton(onPressed: () async{
                                              final sh = await SharedPreferences.getInstance();
                                              Deletestaff(snapshot.data[index].d_login_id);
                                            }, child: Text('Yes'))
                                          ],
                                        ),

                                        );
                                      },

                                        label: Text('Delete'),
                                        icon: Icon(Icons.delete_outline_outlined),

                                      ),
                                    ],
                                  ),


                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void>Deletestaff(d_login_id)async{
    final ips = await SharedPreferences.getInstance();
    try{
      String url = ips.getString("url").toString();
      String lid = ips.getString("lid").toString();

      var data = await http.post(
          Uri.parse(url+"far_del_delete"),
          body: {
            'd_login_id':d_login_id


          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){

        Fluttertoast.showToast(
            msg: "success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const home()),
        );


      }
      else{
        Fluttertoast.showToast(
            msg: " error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );

      }
    }catch(e){
      Fluttertoast.showToast(
          msg: "eeeee-connection"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0
      );
      print("Error--------------"+e.toString());
    }


  }

}
String urlp='';
Future<List<JsService>> _getdata() async {
  final sh = await SharedPreferences.getInstance();
  String Url = sh.getString("url").toString();
  urlp = sh.getString("url").toString();
  String lid = sh.getString("lid").toString();
  var data = await http.post(Uri.parse(Url+"far_del_view"),body: {
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
    JsService(i['d_s_name'].toString(),i['d_s_place'].toString(),i[' d_s_email'].toString(),i['d_s_phone'].toString(),i['d_s_post'].toString(),i['d_s_dob'].toString(),i[' d_s_gender'].toString(),i['d_login_id'].toString(),i['d_s_photo'].toString());
    jokes.add(newname);
  }
  return jokes;
}




class JsService{
  late final String d_s_name ;
  late final String d_login_id ;
  late final String d_s_place ;
  late final String d_s_phone ;
  late final String d_s_email;
  late final String d_s_post;
  late final String d_s_dob;
  late final String d_s_gender;
  late final String d_s_photo;
  JsService(this.d_s_name,this.d_s_place,this. d_s_email,this.d_s_phone,this.d_s_post,this.d_s_dob,this. d_s_gender,this.d_login_id,this.d_s_photo);
}


