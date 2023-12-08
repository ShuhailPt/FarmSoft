import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/home.dart';

import 'login.dart';

void main() {
  runApp(const Add_product());
}

class Add_product extends StatelessWidget {
  const Add_product({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
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
      home: const Add_product_page(title: 'ADDING PRODUCTS'),
      routes: {
        '/Add_product_page':(context)=>Add_product_page(title: '',),
        '/homepage':(context)=>homepage(title: '',),
      },
    );
  }
}

class Add_product_page extends StatefulWidget {
  const Add_product_page({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Add_product_page> createState() => _Add_product_pageState();
}

class _Add_product_pageState extends State<Add_product_page> {
  final _fmkey=new GlobalKey<FormState>();
  File? uploadimage;

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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
        onWillPop: () async {
          // Navigator.pop(context);
      return false; // Return false to prevent default back button behavior
    },child:Scaffold(
      appBar: AppBar(  leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => home()),
          );

        },
      ),

        // Here we take the value from the Add_product_page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('ADD PRODUCT'),
      ),
      body: Container(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,bottom: 5,right: 10,left: 10),
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
                      keyboardType: TextInputType.number,
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
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: ElevatedButton.icon(onPressed: (){
                      chooseImage();
                    },

                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text('Image'),),
                  ),
                  uploadimage == null?
                  InkWell(onTap: (){
                    chooseImage();
                  },
                      child:Container()
                  ):


                  // CircleAvatar(backgroundImage: FileImage(uploadimage!),radius: 80,),
                  Image.file(uploadimage!,height:150 ,width:150 ,),




                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    if(_fmkey.currentState!.validate()){
                      if(uploadimage==null){
                        Fluttertoast.showToast(
                            msg: "upload image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.red,
                            fontSize: 12.0
                        );

                      }else {
                        SignupJS();
                      }
                    }
                  }, child: Text('Add'))

                ],
              ),
            ),
          ),
        ),
      ),
    ),
      ),
    ));
  }

Future<void>SignupJS()async{
  final ips = await SharedPreferences.getInstance();
  try{
    String url = ips.getString("url").toString();
    String lid = ips.getString("lid").toString();

    String nm = name.text.toString();
    String tp = type.text.toString();
    String prc = price.text.toString();

    final bytes = File(uploadimage!.path).readAsBytesSync();
    String base64Image =  base64Encode(bytes);
    print("img_pan : $base64Image");


    var data = await http.post(
        Uri.parse(url+"far_product_add"),
        body: {
          'nm':nm,
          "tp":tp,
          "prc":prc,
          "photo":base64Image,
          "far_id":lid,


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
        MaterialPageRoute(builder: (context) => const Add_product()),
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
