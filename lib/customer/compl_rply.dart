import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const View_cmpl_rply());
}

class View_cmpl_rply extends StatelessWidget {
  const View_cmpl_rply({super.key});

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
      home: const View_cmpl_rply_page(title: 'ORDER'),
    );
  }
}

class View_cmpl_rply_page extends StatefulWidget {
  const View_cmpl_rply_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<View_cmpl_rply_page> createState() => _View_cmpl_rply_pageState();
}

class _View_cmpl_rply_pageState extends State<View_cmpl_rply_page> {


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
        // Here we take the value from the View_cmpl_rply_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('REPLY'),
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
                                height: 250,
                                padding: EdgeInsets.all(16.0),
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
                                    // Expanded(
                                    //   flex: 3,
                                    //   child: Text(
                                    //     'REPLY',
                                    //     // snapshot.data[index].diseas_name,
                                    //     style: TextStyle(
                                    //       fontSize: 18.0,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[index].Date,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 16.0),
                                    Text(
                                      'Complaint:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Flexible(
                                    //   child: SingleChildScrollView(
                                    //     child: Text(
                                    //       snapshot.data[index].complaint,
                                    //       style: const TextStyle(fontSize: 16.0),
                                    //       maxLines: null, // Allow multiple lines
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(height: 10.0),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        child: Text(
                                          snapshot.data[index].complaint,
                                          style: const TextStyle(fontSize: 16.0),
                                          maxLines: null, // Allow multiple lines
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Reply:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        child: Text(
                                          snapshot.data[index].reply,
                                          style: const TextStyle(fontSize: 16.0),
                                          maxLines: null, // Allow multiple lines
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.0),


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
  Future<List<orderView>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"cust_cmplnt_reply_view"),body: {
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
      orderView(i['Date'].toString(),i['complaint'].toString(),i['reply'].toString());
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


class orderView{
  late final String Date;
  late final String complaint;
  late final String reply;
  orderView(this.Date,this.complaint,this.reply);
}
