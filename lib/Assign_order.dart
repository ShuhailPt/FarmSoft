import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View_order.dart';

void main() {
  runApp(const Assign_order());
}

class Assign_order extends StatelessWidget {
  const Assign_order({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
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
      home: const Assign_order_page(title: 'FEEDBACK'),
    );
  }
}

class Assign_order_page extends StatefulWidget {
  const Assign_order_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Assign_order_page> createState() => _Assign_order_pageState();
}

class _Assign_order_pageState extends State<Assign_order_page> {
  String Url='';



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
          // Here we take the value from the Assign_order_page object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('ASSIGN ORDER'),
        ),
        body:Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg5.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(5.0),
            child: FutureBuilder(
                future: _getdata(),
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
                        return
                          Container(height: 200,
                            child: Card(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar( radius: 50,
                                      backgroundImage: NetworkImage(Url+snapshot.data[index].d_s_photo),
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Expanded(
                                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Name:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].d_s_name,
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
                                            Text('Phone:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].d_s_phone,
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
                                            Text('Email:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].d_s_email,
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
                                            Text('Place:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].d_s_place,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20,),

                                        ElevatedButton(onPressed: ()async{
                                          final sh = await SharedPreferences.getInstance();
                                           String dlid=snapshot.data[index].d_login_id;
                                           String oid=sh.getString("main_id").toString();

                                          _assign(oid,dlid);



                                        }, child: Text('Assign')),




                                      ],

                                    ),
                                  )

                                ],
                              ),
                            ),);
                      },
                    );
                  }
                })
        )
    );
  }

  Future<List<Del_sataff>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"far_assgn_order"),body: {
      'lid':lid

    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<Del_sataff> jokes = [];
    for (var i in jsonData["data"]) {
      print(i);
      Del_sataff newname =
      Del_sataff(i['d_s_name'].toString(),i['d_s_place'].toString(),i['d_s_phone'].toString(),i[' d_s_email'].toString(),i['d_s_photo'].toString(),i['d_login_id'].toString());
      jokes.add(newname);
    }
    return jokes;
  }





Future<void>_assign(oid,dlid)async{
  final sh = await SharedPreferences.getInstance();
  try{
    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();


    var data = await http.post(
        Uri.parse(url+"assign_order"),
        body: {

          'oid':oid,
          'dlid':dlid,
          'lid':lid,


        });
    print(data);
    var jasondata = json.decode(data.body);
    String status=jasondata['status'].toString();

    if(status=="ok"){
      Fluttertoast.showToast(
          msg: "Order Assigned",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Order_view()),
      );
    }
    else{
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.white,
          fontSize: 12.0
      );
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: "eeeee"+e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.white,
        fontSize: 12.0
    );
    print("Error--------------"+e.toString());
  }


}
}


class Del_sataff {
  late final String d_s_name;
  late final String d_s_place;
  late final String d_s_phone;
  late final String d_login_id;
  late final String d_s_email;
  late final String d_s_photo;


  Del_sataff(this.d_s_name, this.d_s_place,this.d_s_phone,this.d_s_email, this.d_s_photo,this.d_login_id);
}
