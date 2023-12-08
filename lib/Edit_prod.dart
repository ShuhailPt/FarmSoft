import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

void main() {
  runApp(const Edit_prodct());
}

class Edit_prodct extends StatelessWidget {
  const Edit_prodct({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
      home: const Edit_prodct_page(title: 'EDIT PRODUCTS'),
    );
  }
}

class Edit_prodct_page extends StatefulWidget {
  const Edit_prodct_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Edit_prodct_page> createState() => _Edit_prodct_pageState();
}

class _Edit_prodct_pageState extends State<Edit_prodct_page> {
  final _fmkey=new GlobalKey<FormState>();
  File? uploadimage;
  String photo='';
  String url='';


  Future<void> chooseImage() async {
    final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  TextEditingController name=new TextEditingController();
  TextEditingController type=new TextEditingController();
  TextEditingController price=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProduct();
  }


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
        // Here we take the value from the Edit_prodct_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('UPDATE PRODUCT'),
      ),
      body:  Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/bg5.jpg'),
    fit: BoxFit.cover,
    ),
    ),
    padding: const EdgeInsets.all(5.0),
    child: Center(
    child: SingleChildScrollView(
        child: Center(

          child: Form(
            key: _fmkey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5 ,right: 10,left: 10),
                  child: TextFormField(
                    controller: name,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Enter Product Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Product Name'


                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5 ,right: 10,left: 10),
                  child: TextFormField(
                    controller: type,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Enter Type';

                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Type'


                    ),

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 5 ,right: 10,left: 10),
                  child: TextFormField(
                    controller: price,
                    validator: (v){
                      if(v!.isEmpty){
                        return 'Enter Price';

                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Price'


                    ),

                  ),
                ),SizedBox(height: 20,),
                uploadimage == null?
                InkWell(onTap: (){
                  chooseImage();

                },
                    child:Container(child: Image.network(url+photo,height:150 ,width:150 ,),)
                ):


                // CircleAvatar(backgroundImage: FileImage(uploadimage!),radius: 80,),
                Image.file(uploadimage!,height:150 ,width:150 ,),




                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  if(_fmkey.currentState!.validate()){


                    SignupJS();

                  }
                }, child: Text('Edit'))

              ],
            ),
          ),
        ),
      ),
    ),
      ),
    );
  }


  Future<void> _getProduct() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    String prdct_id = sh.getString("prdct_id").toString();
    var data = await http.post(Uri.parse(Url+"far_product_data_edit"),body: {
      'prdct_id':prdct_id
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    String nm = jsonData['prdct_name'].toString();
    String prc = jsonData['prdct_price'].toString();
    String pht = jsonData['prdct_photo'].toString();
    String typ = jsonData['prdct_type'].toString();
    String id = jsonData['prdct_id'].toString();

    setState(() {
      name.text=nm.toString();
      price.text = prc.toString();
      type.text=typ.toString();
      photo=pht.toString();
      url = Url;




    });


  }


  Future<void>SignupJS()async{
    final ips = await SharedPreferences.getInstance();
    String url = ips.getString("url").toString();
    String prdct_id = ips.getString("prdct_id").toString();
    if(uploadimage==null){
      try{


        String nm = name.text.toString();
        String tp = type.text.toString();
        String prc = price.text.toString();

        // final bytes = File(uploadimage!.path).readAsBytesSync();
        // String base64Image =  base64Encode(bytes);
        // print("img_pan : $base64Image");



        var data = await http.post(
            Uri.parse(url+"far_product_edit"),
            body: {
              'name':nm,
              "type":tp,
              "price":prc,
              'prdct_id':prdct_id,
              'photo':''


            });
        print(data);
        var jasondata = json.decode(data.body);
        String status=jasondata['status'].toString();

        if(status=="ok"){

          Fluttertoast.showToast(
              msg: " success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0
          );
          Navigator.pop(
            context,

          );


        }
        else{
          Fluttertoast.showToast(
              msg: "Registration error",
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
    else{
      try{


        String nm = name.text.toString();
        String tp = type.text.toString();
        String prc = price.text.toString();

        final bytes = File(uploadimage!.path).readAsBytesSync();
        String base64Image =  base64Encode(bytes);
        print("img_pan : $base64Image");



        var data = await http.post(
            Uri.parse(url+"far_product_edit"),
            body: {
              'name':nm,
              "type":tp,
              "price":prc,
              'prdct_id':prdct_id,
              'photo':base64Image


            });
        print(data);
        var jasondata = json.decode(data.body);
        String status=jasondata['status'].toString();

        if(status=="ok"){

          Fluttertoast.showToast(
              msg: "Edit success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0
          );
          Navigator.pop(
            context,
          );


        }
        else{
          Fluttertoast.showToast(
              msg: "Edit error",
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
}
