import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/Edit_prod.dart';

import 'Add_stock.dart';
import 'View_f_stock.dart';
import 'home.dart';
void main() {
  runApp(const Order_more());
}

class Order_more extends StatelessWidget {
  const Order_more({super.key});

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
      home: const Order_more_page(title: ''),
    );
  }
}

class Order_more_page extends StatefulWidget {
  const Order_more_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Order_more_page> createState() => _Order_more_pageState();
}

class _Order_more_pageState extends State<Order_more_page> {


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
          // Here we take the value from the Order_more_page object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('VIEW MORE'),
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
                          Container(height: 150,
                            child: Card(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar( radius: 40,
                                      backgroundImage: NetworkImage(urlp+snapshot.data[index].prdct_photo),
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
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Quantity:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].sub_qnty,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 10,),
                                        // Row(
                                        //   children: [
                                        //     Text('Qualification:',
                                        //
                                        //     ),SizedBox(width: 15,),
                                        //     Text(
                                        //       snapshot.data[index].qualificatiom,
                                        //       style: TextStyle(
                                        //         fontSize: 16.0,
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),



                                      ],

                                    ),
                                  )

                                ],
                              ),
                            ),);

                      },
                    );
                  }
                }
            )
        )
    );
  }


}
String urlp='';
Future<List<JsService>> _getdata() async {
  final sh = await SharedPreferences.getInstance();
  String Url = sh.getString("url").toString();
  urlp = sh.getString("url").toString();
  String lid = sh.getString("lid").toString();
  String main_id = sh.getString("main_id").toString();
  var data = await http.post(Uri.parse(Url+"far_suborder_view"),body: {
    'lid':lid,
    'main_id':main_id,
  });
  print("------------------------------hoiiiiiii---------------");
  print(data);
  var jsonData = json.decode(data.body);

  print(jsonData);
  List<JsService> jokes = [];
  for (var i in jsonData["data"]) {
    print(i);
    JsService newname =
    JsService(i['prdct_name'].toString(),i['prdct_type'].toString(),i['prdct_photo'].toString(),i['prdct_price'].toString(),i['prdct_id'].toString(),i['sub_qnty'].toString());
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
  late final String sub_qnty;
  JsService(this.prdct_name,this.prdct_type,this.prdct_photo,this.prdct_price,this.prdct_id,this.sub_qnty);
}

