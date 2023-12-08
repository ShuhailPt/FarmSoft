import 'dart:convert';
import 'package:farm_soft/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View_diseas.dart';
import 'chat.dart';

void main() {
  runApp(const Officer_view());
}

class Officer_view extends StatelessWidget {
  const Officer_view({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Officer_view_page(title: ''),
      routes: {
        '/Home':(context)=>home(),

      },
    );
  }
}

class Officer_view_page extends StatefulWidget {
  const Officer_view_page({Key? key, required this.title});

  final String title;

  @override
  State<Officer_view_page> createState() => _Officer_view_pageState();
}

class _Officer_view_pageState extends State<Officer_view_page> {
  String Url='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OFFICER'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.pushNamed(context, '/Home');
              // Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const home()),);
              print("Hello");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ThirdScreen()),
              // );
            },
          )
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
                        height: 370,
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
                              child:  Center(
                                child: Container(
                                  width: 115, // Adjust the width and height as per your requirement
                                  height: 115,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue, // Choose your desired border color
                                      width: 2, // Adjust the border width as per your preference
                                    ),
                                  ),
                                  child: CircleAvatar(radius:70 ,backgroundImage:NetworkImage(Url+snapshot.data[index].photo),),
                                ),
                              ),

                            ),
                            SizedBox(height: 10,),
                            Row(

                              children: [
                                Text('Name:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 61,),
                                Text(
                                  snapshot.data[index].officer_name,

                                ),
                              ],
                            ),
                            // SizedBox(height: 10,),
                            // Text(
                            //   snapshot.data[index].officer_name,
                            //   style: const TextStyle(
                            //     fontSize: 18.0,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Phone:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 59,),
                                Text(
                                  snapshot.data[index].phone,

                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Email:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 65,),
                                Text(
                                  snapshot.data[index].mail,

                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Place:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 65,),
                                Text(
                                  snapshot.data[index].place,

                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('Qualification:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),SizedBox(width: 15,),
                                Text(
                                  snapshot.data[index].qualificatiom,

                                ),
                              ],
                            ),
                            // SizedBox(height: 20,),

                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                ElevatedButton.icon(

                                  onPressed: () async {
                                    final sh = await SharedPreferences.getInstance();
                                    sh.setString("olid", snapshot.data[index].login_id);
                                    sh.setString("name", snapshot.data[index].officer_name);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyChatApp()),
                                    );
                                  },
                                  icon: Icon(Icons.chat_outlined),
                                  label: Text('Chat'),
                                ),
                              ],
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
    );
  }

  Future<List<Agr_officer>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url+"far_officer_view"),body: {

    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<Agr_officer> jokes = [];
    for (var i in jsonData["data"]) {
      print(i);
      Agr_officer newname =
      Agr_officer(i['officer_name'].toString(),i['place'].toString(),i['phone'].toString(),i['qualificatiom'].toString(),i['photo'].toString(),i['login_id'].toString(),i['mail'].toString());
      jokes.add(newname);
    }
    return jokes;
  }

}


class Agr_officer {
  late final String officer_name;
  late final String place;
  late final String phone;
  late final String login_id;
  late final String mail;
  late final String qualificatiom;
  late final String photo;


  Agr_officer(this.officer_name, this.place,this.phone,this.qualificatiom, this.photo,this.login_id, this.mail);
}
