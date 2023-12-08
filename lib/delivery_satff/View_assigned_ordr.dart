import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/delivery_satff/delhome.dart';

void main() {
  runApp(const del_Order_view());
}

class del_Order_view extends StatelessWidget {
  const del_Order_view({super.key});

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
      home: const del_Order_view_page(title: 'ORDER'),
    );
  }
}

class del_Order_view_page extends StatefulWidget {
  const del_Order_view_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<del_Order_view_page> createState() => _del_Order_view_pageState();
}

class _del_Order_view_pageState extends State<del_Order_view_page> {


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
          // Here we take the value from the del_Order_view_page object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('ORDERS'),
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
                          ListTile(

                            title:
                            Card(
                              child: Container(
                                height: 330,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 4.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].cust_name,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height:10 ,),
                                    Text(
                                      'Phone: '+ "" + " " +snapshot.data[index].cust_phone,
                                    ),
                                    Text(
                                      'Email: '+ "" + " " +snapshot.data[index].cust_email,
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Address:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 5,),
                                    Text(
                                      'Place: '+ "" + " " +snapshot.data[index].cust_place,
                                    ),
                                    // SizedBox(height: 10,),
                                    Text(
                                      'Post: '+ "" + " " +snapshot.data[index].cust_post,
                                    ),
                                    // SizedBox(height: 10,),
                                    Text(
                                      'Pin: '+ "" + " " +snapshot.data[index].cust_pin,
                                    ),
                                    // Expanded(
                                    //   flex: 3,
                                    //   child:
                                    // ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Date:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),SizedBox(width: 20,),
                                        Text(
                                          snapshot.data[index].main_date,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.,
                                      children: [
                                        Text(
                                          'Amount:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          snapshot.data[index].amnt,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),

                                SizedBox(height: 10,),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    snapshot.data[index].asgnmt_status=="pending"?
                                    Center(
                                      child: ElevatedButton(onPressed: ()async{
                                        updatesttus(snapshot.data[index].order_main_id);
                                      }, child: Text('Update')),
                                    ):Container(),
                                      ],
                                )






                                // SizedBox(height: 16.0),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'Disease Name:',
                                    //       style: TextStyle(
                                    //         fontSize: 16.0,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       snapshot.data[index].diseas_name,
                                    //       style: TextStyle(fontSize: 16.0),
                                    //     ),
                                    //   ],
                                    // ),
                                  ]
                                ),
                              ),
                            ),
                          );
                      },
                    );
                  }
                })
        )
    );
  }


  Future<void>updatesttus(oid)async{
    final sh = await SharedPreferences.getInstance();
    try{
      String url = sh.getString("url").toString();



      var data = await http.post(
          Uri.parse(url+"del_updt"),
          body: {
            "oid":oid

          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){

        Fluttertoast.showToast(
            msg: "status updated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => const del_home()),
        );


      }
      else{
        Fluttertoast.showToast(
            msg: "Updation error",
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
  Future<List<dOrderview>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"del_order_view"),body: {
      'lid':lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<dOrderview> jokes = [];
    for (var i in jsonData["data"]) {
      print(i);
      dOrderview newname =
      dOrderview(i['cust_name'].toString(),i['cust_phone'].toString(),i['cust_email'].toString(),i['cust_place'].toString(),i['cust_post'].toString(),i['cust_pin'].toString(),i['main_date'].toString(),i['amnt'].toString(),i['order_main_id'].toString(),i['asgnmt_status'].toString());
      jokes.add(newname);
    }
    return jokes;
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


class dOrderview{
  late final String main_date;
  late final String cust_name;
  late final String cust_pin;
  late final String cust_post;
  late final String cust_place;
  late final String cust_email;
  late final String cust_phone;
  late final String amnt;
  late final String order_main_id;
  late final String asgnmt_status;

  dOrderview(this.cust_name,this.cust_phone,this.cust_email,this.cust_place,this.cust_post,this.cust_pin,this.main_date,this.amnt,this.order_main_id,this.asgnmt_status);
}
