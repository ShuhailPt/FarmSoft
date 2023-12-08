import 'dart:convert';
import 'package:farm_soft/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Assign_order.dart';
import 'View_more_order.dart';

void main() {
  runApp(const Order_view());
}

class Order_view extends StatelessWidget {
  const Order_view({super.key});

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
      home: const Order_view_page(title: 'ORDER'),
      routes: {
        '/homepage':(context)=>homepage(title: '',),
      },
    );
  }
}

class Order_view_page extends StatefulWidget {
  const Order_view_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Order_view_page> createState() => _Order_view_pageState();
}

class _Order_view_pageState extends State<Order_view_page> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return
      Scaffold(
        appBar: AppBar(
          leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => home()),
            );

          },
        ),
          // Here we take the value from the Order_view_page object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('ORDERS'),
        ),

    );
  }
  Future<List<orderView>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"far_order_view"),body: {
      'lid':lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<orderView> jokes = [];
    for (var i in jsonData["data"]) {
      print(i);
      orderView newname =
      orderView(i['main_id'].toString(),i['main_date'].toString(),i['amnt'].toString(),i['main_status'].toString(),i['cust_name'].toString(),i['cust_phone'].toString(),i['cust_email'].toString(),i['cust_place'].toString(),i['cust_post'].toString());
      jokes.add(newname);
    }
    return jokes;
  }




}


class orderView{
  late final String main_id;
  late final String main_date;
  late final String cust_name;
  late final String cust_phone;
  late final String cust_email;
  late final String cust_place;
  late final String cust_post;
  late final String amnt;
  late final String main_status;
  orderView(this.main_id,this.main_date,this.amnt,this.main_status,this.cust_name,this.cust_phone,this.cust_email,this.cust_place,this.cust_post);
}
