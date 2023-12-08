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
  runApp(const Product_view_f());
}

class Product_view_f extends StatelessWidget {
  const Product_view_f({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
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
      home: const Product_view_f_page(title: 'FEEDBACK'),
    );
  }
}

class Product_view_f_page extends StatefulWidget {
  const Product_view_f_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Product_view_f_page> createState() => _Product_view_f_pageState();
}

class _Product_view_f_pageState extends State<Product_view_f_page> {


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
        // Here we take the value from the Product_view_f_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('VIEW PRODUCT'),
      ),
        body: Container(
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
                            Container(height: 250,
                        child: Card(

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar( radius: 50,
                                      backgroundImage: NetworkImage(urlp+snapshot.data[index].prdct_photo),
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot.data[index].prdct_name,
                                                style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        ListTile(trailing: InkWell(child: Icon(Icons.edit,color: Colors.blue,),onTap: ()async{
                                          final sh = await SharedPreferences.getInstance();
                                          sh.setString("prdct_id", snapshot.data[index].prdct_id);

                                          Navigator.push( context,
                                            MaterialPageRoute(builder: (context) =>  Edit_prodct_page(title: '',)),);
                                        },),
                                          title: Row(
                                            children: [
                                              Text('Type:',

                                              ),SizedBox(width: 5,),
                                              Text(
                                                snapshot.data[index].prdct_type,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                       SizedBox(height: 10,),
                                        ListTile(trailing:  InkWell(child: Icon(Icons.delete,color: Colors.red,),onTap: (){
                                          showDialog(context: context, builder: (context) => AlertDialog(
                                            title: Text('Are you sure!'),
                                            actions: [
                                              ElevatedButton(onPressed: () async{
                                                final sh = await SharedPreferences.getInstance();
                                                DeleteProdct(snapshot.data[index].prdct_id);
                                              }, child: Text('Yes'))
                                            ],
                                          ),

                                          );

                                        },),
                                          title: Row(
                                            children: [
                                              Text('Price:',

                                              ),SizedBox(width: 5,),
                                              Text(
                                                snapshot.data[index].prdct_price,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),



                                        Row(
                                          children: [
                                            ElevatedButton.icon(onPressed: ()async{
                                              final sh = await SharedPreferences.getInstance();
                                              sh.setString("prdct_id", snapshot.data[index].prdct_id);

                                              Navigator.push( context,
                                                MaterialPageRoute(builder: (context) =>  Add_Stock_page(title: '',)),);
                                            },  icon: Icon(Icons.add_circle_sharp),
                                                label: Text('Stock'),),
                                            SizedBox(width: 5,),
                                            ElevatedButton(

                                              onPressed: ()async{
                                              final sh = await SharedPreferences.getInstance();
                                              sh.setString("prdct_id", snapshot.data[index].prdct_id);

                                              Navigator.push( context,
                                                MaterialPageRoute(builder: (context) =>  Stock_view_f_page(title: '',)),);
                                            },
                                              child: Text('Stock'),),
                                          ],
                                        ),


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

  Future<void>DeleteProdct(prdct_id)async{
    final ips = await SharedPreferences.getInstance();
    try{
      String url = ips.getString("url").toString();
      String lid = ips.getString("lid").toString();

      var data = await http.post(
          Uri.parse(url+"far_product_delete"),
          body: {
            'prdct_id':prdct_id


          });
      print(data);
      var jasondata = json.decode(data.body);
      String status=jasondata['status'].toString();

      if(status=="ok"){

        Fluttertoast.showToast(
            msg: "success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Product_view_f()),
        );


      }
      else{
        Fluttertoast.showToast(
            msg: " error",
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

}
String urlp='';
Future<List<JsService>> _getdata() async {
  final sh = await SharedPreferences.getInstance();
  String Url = sh.getString("url").toString();
  urlp = sh.getString("url").toString();
  String lid = sh.getString("lid").toString();
  var data = await http.post(Uri.parse(Url+"far_prdct_view"),body: {
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
    JsService(i['prdct_name'].toString(),i['prdct_type'].toString(),i['prdct_photo'].toString(),i['prdct_price'].toString(),i['prdct_id'].toString());
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
  JsService(this.prdct_name,this.prdct_type,this.prdct_photo,this.prdct_price,this.prdct_id);
}
