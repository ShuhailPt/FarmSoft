import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_soft/login.dart';
import 'package:farm_soft/main.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'Edit_forg_paswd.dart';
import 'customer/Edit_c_paswd.dart';


class Forgot_pswd extends StatefulWidget {
  @override
  _Forgot_pswdState createState() => _Forgot_pswdState();
}

class _Forgot_pswdState extends State<Forgot_pswd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _screeningIdController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the loginpage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('FORGOT PASSWORD'),
      ),
      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/bg5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your email address',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // SizedBox(height: 5.0),
                        // Text(
                        //
                        //   style: TextStyle(
                        //     fontSize: 16.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        SizedBox(height: 16.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: _screeningIdController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Email ID';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(

                                // if (_formKey.currentState!.validate()) {



                                onPressed: () async {


                                  final sh = await SharedPreferences.getInstance();
                                  try{

                                    String screeningid=_screeningIdController.text;
                                    sh.setString("email", screeningid);

                                    String url = sh.getString("url").toString();
                                    // String url="http://192.168.167.202:3000/";

                                    var data = await http.post(
                                        Uri.parse(url+"and_gen_otp"),
                                        body: {'email':screeningid

                                        });
                                    print(data);
                                    var jasondata = json.decode(data.body);
                                    String status=jasondata['status'].toString();

                                    if(status=="ok"){

                                      String otp = jasondata['otp'].toString();
                                      String lid = jasondata['lid'].toString();
                                      sh.setString("otp", otp);
                                      sh.setString("lid", lid);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => OTPPage()),
                                      );





                                    }
                                    else{
                                      Fluttertoast.showToast(
                                          msg: "No screening id",
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








                                },
                                child: Text('Get OTP'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.black54,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );// Edit profile functionality here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController _otpController = TextEditingController();




  Future<void> _submitForm() async {
    final pref = await SharedPreferences.getInstance();
    String otps = _otpController.text;
    String totp=pref.getString("otp").toString();
    String Dname='Result';

    if (otps==totp) {
      // OTP is valid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('OTP is valid!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () async {


                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FChangePasswordPage()),
                  );


                },
              ),
            ],
          );
        },
      );
    } else {
      // OTP is invalid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid OTP'),
            content: Text('Please try again with a valid OTP.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the loginpage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('FORGOT PASSWORD'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/bg5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter the OTP sent to your Email:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                            labelText: 'OTP',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Submit'),
                        ),
                        SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {



                          },
                          child: Text('Not received? Resend OTP'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class FChangePasswordPage extends StatefulWidget {
  @override
  _FChangePasswordPageState createState() => _FChangePasswordPageState();
}

class _FChangePasswordPageState extends State<FChangePasswordPage> {
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();




  Future<void> _submitForm() async {
    final pref = await SharedPreferences.getInstance();
    String password = _password.text;
    String cpassword = _cpassword.text;
    String lid=pref.getString("lid").toString();
    String Dname='Result';
    String jdata= "";
    if (password==cpassword) {


      try{

        String Url = pref.getString("url").toString();
        var data = await http.post(
            Uri.parse(Url+"forgt_password"),body:
        {
          "password":password,
          "lid":lid,
        }
        );
        print(data);
        var jasondata = json.decode(data.body);
        jdata=jasondata['status'].toString();
        if(jdata=="ok") {


          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  login()),
          );

        }
        // else{
        //   Navigator.pushNamed(context, '/signup');
        // }
      }catch(e){
        print("Error--------------"+e.toString());
      }



    } else {
      // OTP is invalid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Missmatch'),
            content: Text('Enter Correct Password.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FChangePasswordPage()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/bg5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create New Password:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the Password';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _cpassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please re-enter the Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Submit'),
                        ),
                        SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {



                          },
                          child: Text('Not received? Resend OTP'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






