import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Disease_view());
}

class Disease_view extends StatelessWidget {
  const Disease_view({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crop Disease',
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
      home: const Disease_view_page(title: 'Crop Disease'),
    );
  }
}

class Disease_view_page extends StatefulWidget {
  const Disease_view_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Disease_view_page> createState() => _Disease_view_pageState();
}

class _Disease_view_pageState extends State<Disease_view_page> {


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
        // Here we take the value from the Disease_view_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('CROP DISEASE'),
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
                            // trailing: Column(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     InkWell(onTap:(){
                            //       // delete_services(snapshot.data[index].S_id);
                            //
                            //     },child: Icon(Icons.delete,color: Colors.red,)),
                            //     InkWell(onTap:(){
                            //       // delete_services(snapshot.data[index].noti_id);
                            //
                            //     },child: Icon(Icons.edit,color: Colors.lightBlue,)),
                            //   ],
                            // ),

                            title:
                            Card(
                              child: Container(
                                height: 230,
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
                                      snapshot.data[index].diseas_name,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(height: 10.0),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Type:',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Flexible(
                                      child: Text(
                                        snapshot.data[index].type,
                                        style: const TextStyle(fontSize: 16.0),
                                        maxLines: null, // Allow multiple lines
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Precautions:',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        child: Text(
                                          snapshot.data[index].title,
                                          style: const TextStyle(fontSize: 16.0),
                                          maxLines: null, // Allow multiple lines
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),

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
                                  ],
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


  Future<List<JsService>> _getdata() async {
  final sh = await SharedPreferences.getInstance();
  String Url = sh.getString("url").toString();
  String lid = sh.getString("lid").toString();
  String crop_id = sh.getString("crop_id").toString();
  var data = await http.post(Uri.parse(Url+"far_diseas_view"),body: {
    'crop_id':crop_id
  });
  print("------------------------------hoiiiiiii---------------");
  print(data);
  var jsonData = json.decode(data.body);

  print(jsonData);
  List<JsService> jokes = [];
  for (var i in jsonData["data"]) {
    print(i);
    JsService newname =
    JsService(i['title'].toString(),i['type'].toString(),i['diseas_name'].toString());
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


class JsService{
  late final String title;
  late final String type;
  late final String diseas_name;
  JsService(this.title,this.type,this.diseas_name);
}
