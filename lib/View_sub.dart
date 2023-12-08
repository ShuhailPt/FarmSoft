import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Crop_view.dart';


void main() {
  runApp(const Subsd_view());
}

class Subsd_view extends StatelessWidget {
  const Subsd_view({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sub',
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
      home: const Subsd_view_page(title: 'Farmer Profile'),
    );
  }
}

class Subsd_view_page extends StatefulWidget {
  const Subsd_view_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Subsd_view_page> createState() => _Subsd_view_pageState();
}

class _Subsd_view_pageState extends State<Subsd_view_page> {


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
        // Here we take the value from the Subsd_view_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('SUBSIDIES'),
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
                        height: 220,
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
                              child: Text(
                                snapshot.data[index].title,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),

                            Flexible(
                              child: SingleChildScrollView(
                                child: Text(
                                  snapshot.data[index].sub_description,
                                  style: const TextStyle(fontSize: 16.0),
                                  maxLines: null, // Allow multiple lines
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data[index].date,
                                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.black54,),

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

  Future<List<JsService>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url + "far_sub_view"), body: {
      'lid': lid
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<JsService> jokes = [];
    for (var i in jsonData["data"]) {
      print(i);
      JsService newname =
      JsService(i['title'].toString(), i['sub_description'].toString(),
          i['date'].toString());
      jokes.add(newname);
    }
    return jokes;
  }
}




class JsService {
  late final String title ;
  late final String sub_description;
  late final String date;
  JsService(this.title,this.sub_description,this.date);
}
