import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelcollection/Ui/admin.dart';
import 'package:hotelcollection/Ui/customerdata.dart';
import 'package:hotelcollection/Ui/register.dart';
import 'package:hotelcollection/cache_data/cache_data_imp_helper.dart';
import 'package:hotelcollection/main.dart';

class loginscreen extends StatefulWidget {
  final String text;
  loginscreen( {Key? key, required this.text}) : super(key: key);


  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final TextEditingController emailCon = TextEditingController();
  bool isArabic = false;
  final TextEditingController passwordCon = TextEditingController();
  CacheDataImpHelper cacheDataImpHelper= CacheDataImpHelper();

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      // TODO: implement initState
      super.initState();


    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5,
                      left: MediaQuery.of(context).size.width / 15),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 15),
                  child: Text(
                    "Login now to browse our hot offers",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        child:    TextField(
                            controller: emailCon,
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.teal)),
                              hintText: 'Enter your email',
                              labelText: 'User Email',

                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                              //prefixText: ' ',
                              //suffixText: 'USD',
                              //suffixStyle: const TextStyle(color: Colors.green)),
                            )),

                      ),

                      TextField(
                          controller: passwordCon,
                          obscureText: true,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            hintText: 'Enter your Password',
                            labelText: 'User password',
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Colors.green,
                            ),
                            //prefixText: ' ',
                            //suffixText: 'USD',
                            //suffixStyle: const TextStyle(color: Colors.green)),
                          ))
                    ],
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () async{



                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: Text("Don't have an account?"),
                ),
                Center(
                  child: TextButton(child: Text('Register'), onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => register()));
                  }),
                )
              ],
            ),
          ),
        ));
  }
}
