import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(const Land_view());
}

class Land_view extends StatelessWidget {
  const Land_view({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Land Availability',
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
      home: const Land_view_page(title: 'Land Availabilty'),
    );
  }
}

class Land_view_page extends StatefulWidget {
  const Land_view_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Land_view_page> createState() => _Land_view_pageState();
}

class _Land_view_pageState extends State<Land_view_page> {


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
        // Here we take the value from the Land_view_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('LAND AVAILABILITY'),
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
                                height: 330,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
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
                                      snapshot.data[index].land_location,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 16.0),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'Latitude:',
                                    //       style: TextStyle(
                                    //         fontSize: 16.0,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       snapshot.data[index].latitude,
                                    //       style: TextStyle(fontSize: 16.0),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(height: 16.0),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'Longitude:',
                                    //       style: TextStyle(
                                    //         fontSize: 16.0,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       snapshot.data[index].longitude,
                                    //       style: TextStyle(fontSize: 16.0),
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Post:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[index].post,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Pin Code:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[index].pin,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'District:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[index].district,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'State:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[index].state,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      'Land Details:',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        child: Text(
                                          snapshot.data[index].land_details,
                                          style: const TextStyle(fontSize: 16.0),
                                          maxLines: null, // Allow multiple lines
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),

                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            String uri = "https://www.google.com/maps/search/?api=1&query="+snapshot.data[index].latitude+","+snapshot.data[index].longitude;
                                            launchUrl(Uri.parse(uri));
                                            print("https://www.google.com/maps/search/?api=1&query="+snapshot.data[index].latitude+","+snapshot.data[index].longitude);
                                          },
                                          icon: Icon(Icons.location_on_outlined),
                                          label: Text('Locate'),
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
                })
        )
    );
  }
  Future<List<JsService>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"far_land_view"),body: {
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
      JsService(i['land_location'].toString(),i['land_details'].toString(),i['latitude'].toString(),i['longitude'].toString(),i['post'].toString(),i['pin'].toString(),i['district'].toString(),i['state'].toString());
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
  late final String land_location;
  late final String land_details;
  late final String latitude;
  late final String longitude;
  late final String post;
  late final String pin;
  late final String district;
  late final String state;
  JsService(this.land_location,this.land_details,this.latitude,this.longitude,this.post,this.pin,this.district,this.state);
}
