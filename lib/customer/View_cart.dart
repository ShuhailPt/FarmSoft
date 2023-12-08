import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/customer/payment.dart';

import 'Add_RR.dart';
import 'cart_qnty.dart';
void main() {
  runApp(const View_cart());
}

class View_cart extends StatelessWidget {
  const View_cart({super.key});

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
      home: const View_cart_page(title: ''),
        routes: {
          '/View_cart':(context)=>View_cart_page(title: '',),
        }
    );
  }
}

class View_cart_page extends StatefulWidget {
  const View_cart_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<View_cart_page> createState() => _View_cart_pageState();
}

class _View_cart_pageState extends State<View_cart_page> {


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
          // Here we take the value from the View_cart_page object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('CART'),
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
                                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Name:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].prdct_name,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Type:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].prdct_type,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Price:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].prdct_price,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Quantity:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              snapshot.data[index].quantity+ "" + "  " +'kg',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Total:',

                                            ),SizedBox(width: 15,),
                                            Text(
                                              (int.parse(snapshot.data[index].prdct_price)*int.parse(snapshot.data[index].quantity)).toString(),
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // ElevatedButton(onPressed: ()async{
                                            //   final sh = await SharedPreferences.getInstance();
                                            //   sh.setString("prdct_id", snapshot.data[index].prdct_id);
                                            //
                                            //   Navigator.push( context,
                                            //     MaterialPageRoute(builder: (context) =>  Paymnt_page(title: '',)),);
                                            // }, child: Text('Buy')),
                                            SizedBox(width: 10,),
                                            ElevatedButton(onPressed: ()async{

                                              showDialog(context: context, builder: (context) => AlertDialog(
                                                title: Text('Delete from cart!'),

                                                actions: [
                                                  ElevatedButton(onPressed: () async{
                                                    final sh = await SharedPreferences.getInstance();
                                                    DeleteProdct(snapshot.data[index].prdct_id);
                                                  }, child: Text('Yes'))
                                                ],
                                              ),);

                                            }, child: Text('Delete'),
                                              style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent, // Set the button color to red
                                            ),),
                                          ],
                                        ),

                                        // SizedBox(height: 40,),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                        //   children: [
                                        //     Text("Please Give"),TextButton(onPressed: (){
                                        //       Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(builder: (context) => const Add_RR()),
                                        //       );
                                        //     }, child: Text('Ratings & Reviews')),
                                        //   ],
                                        // ),

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
            ),
        ),
      floatingActionButton:  ElevatedButton(onPressed: ()async{
        final sh = await SharedPreferences.getInstance();
        // sh.setString("prdct_id", snapshot.data[index].prdct_id);

        Navigator.push( context,
          MaterialPageRoute(builder: (context) =>  Paymnt_page(title: '',)),);
      }, child: Text('Buy')),
    );
  }

  Future<void>DeleteProdct(prdct_id)async{
    final ips = await SharedPreferences.getInstance();
    try{
      String url = ips.getString("url").toString();
      String lid = ips.getString("lid").toString();

      var data = await http.post(
          Uri.parse(url+"cust_cart_delete"),
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
        Navigator.pushNamed(context, '/View_cart');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const View_cart()),
        // );


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
  var data = await http.post(Uri.parse(Url+"cust_cart_view"),body: {
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
    JsService(i['prdct_name'].toString(),i['prdct_type'].toString(),i['prdct_photo'].toString(),i['prdct_price'].toString(),i['prdct_id'].toString(),i['quantity'].toString());
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
  late final String quantity;
  JsService(this.prdct_name,this.prdct_type,this.prdct_photo,this.prdct_price,this.prdct_id,this.quantity);
}
