import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const JViewService());
}

class JViewService extends StatelessWidget {
  const JViewService({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Disease',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const JViewServicePage(title: 'Profile'),
    );
  }
}

class JViewServicePage extends StatefulWidget {
  const JViewServicePage({super.key, required this.title});


  final String title;

  @override
  State<JViewServicePage> createState() => _JViewServicePageState();
}

class _JViewServicePageState extends State<JViewServicePage> {
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
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
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(onTap:(){
                                delete_services(snapshot.data[index].S_id);

                              },child: Icon(Icons.delete,color: Colors.red,)),
                              InkWell(onTap:(){
                                // delete_services(snapshot.data[index].noti_id);

                              },child: Icon(Icons.edit,color: Colors.lightBlue,)),
                            ],
                          ),

                          title:
                          Card(
                            child: Container(
                              height: 150,
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
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      snapshot.data[index].Service,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Status:',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].Sstatus,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rate:',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].Rate,
                                        style: TextStyle(fontSize: 16.0),
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
    var data = await http.post(Uri.parse(Url+"js_view_services"),body: {
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
      JsService(i['Status'].toString(),i['Service'].toString(),i['Rate'].toString(),i['JS_LID'].toString(),i['S_ID'].toString());
      jokes.add(newname);
    }
    return jokes;
  }





  Future<void>delete_services(nid)async{
    final sh = await SharedPreferences.getInstance();
    try{
      String url = sh.getString("url").toString();


      var data = await http.post(
          Uri.parse(url+"js_delete_services"),
          body: {'sid':nid
          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){
        Fluttertoast.showToast(
            msg: "Services deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.pop(
            context
        );
      }
      else{
        Fluttertoast.showToast(
            msg: "Python error.. pleasse register",
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


class JsService{
  late final String S_id;
  late final String Js_id;
  late final String Service;
  late final String Rate;
  late final String Sstatus;
  JsService(this.Sstatus,this.Service,this.Rate,this.Js_id,this.S_id);
}