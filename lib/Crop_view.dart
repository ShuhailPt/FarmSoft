import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View_diseas.dart';
import 'home.dart';

void main() {
  runApp(const Crop_view());
}

class Crop_view extends StatelessWidget {
  const Crop_view({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Crop_view_page(title: ''),
      routes: {
        '/Disease_view_page':(context)=>Disease_view_page(title: '',),
        '/homepage':(context)=>homepage(title: '',),
      },

    );
  }
}

class Crop_view_page extends StatefulWidget {
  const Crop_view_page({Key? key, required this.title});

  final String title;

  @override
  State<Crop_view_page> createState() => _Crop_view_pageState();
}

class _Crop_view_pageState extends State<Crop_view_page> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //   onWillPop: () async {
      // Navigator.pop(context);
      // Add your logic here for handling the back button press
      // Navigate back to the login page when the back button is pressed
      // Navigator.pushNamed(context, '/homepage');
      // Fluttertoast.showToast(msg: "halo");
      // Prevent the default back navigation
    //   return false;
    // },


    child: Scaffold(
      appBar: AppBar(
        title: const Text('CROP VIEW'),
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
                        height: 300,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                child: CircleAvatar( radius: 50,
                                  backgroundImage: NetworkImage(urlp+snapshot.data[index].image),
                                ),
                              ),

                            ),
                            Text(
                              snapshot.data[index].crop_name,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Flexible(
                              child: SingleChildScrollView(
                                child: Text(
                                  snapshot.data[index].deatails,
                                  style: const TextStyle(fontSize: 16.0),
                                  maxLines: null, // Allow multiple lines
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            // SizedBox(height: 20,),

                            Center(
                              child: ElevatedButton(onPressed: ()async{
                                final sh = await SharedPreferences.getInstance();
                                sh.setString("crop_id", snapshot.data[index].crop_id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Disease_view_page(title: '',)),
                                );
                              }, child: Text('View Disease')),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Text(
                            //       '',
                            //       style: TextStyle(
                            //         fontSize: 16.0,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     Text(
                            //       snapshot.data[index].date,
                            //       style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,),
                            //
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
          },
        ),
      ),
    ),
        onWillPop: ()async{
          Fluttertoast.showToast(msg: 'msggg');
          Navigator.pop(context);
          return false;
        });
  }

  String urlp='';
  Future<List<JsService>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    urlp = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"far_crop_view"),body: {
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
      JsService(i['crop_name'].toString(),i['deatails'].toString(),i['image'].toString(),i['crop_id'].toString());
      jokes.add(newname);
    }
    return jokes;
  }

}

class JsService{
  late final String crop_name;
  late final String deatails;
  late final String image;
  late final String crop_id;
  JsService(this.crop_name,this.deatails,this.image,this.crop_id);
}
