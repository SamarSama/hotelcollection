import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelcollection/Ui/admin.dart';
import 'package:hotelcollection/Ui/register.dart';
import 'package:hotelcollection/cache_data/cache_data_imp_helper.dart';
import 'package:hotelcollection/utils/data/data_helper.dart';
import 'package:hotelcollection/helperClass/login.dart';
import 'customerdata.dart';

class adminanduserlogin extends StatelessWidget {
  final String text;
  final TextEditingController emailCon = TextEditingController();
  bool isArabic = false;
  Logoin userlogin=Logoin();
  final TextEditingController passwordCon = TextEditingController();
  CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();
  adminanduserlogin( {Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                Center(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
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
                    if(text=="Admin"){
                      if(emailCon.text=="admin" && passwordCon.text=="123")
                        {

                          cacheDataImpHelper.setUserType(DataHelper.ADMIN_TYPE);

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => admin()));
                        }

                    }
                    else{



                      try {
                        // UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        //     email: emailCon.text,
                        //     password: passwordCon.text
                        // );
                        //
                        //
                        //
                        //
                        // cacheDataImpHelper.setUserType(DataHelper.USER_TYPE);
                        // cacheDataImpHelper.setEmail(emailCon.text);
                        // cacheDataImpHelper.setPassword(passwordCon.text);
                        userlogin.UserLogin(emailCon.text, passwordCon.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("s",style: TextStyle(color: Colors.red),)));
                      //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CustomerData()));
                      } on FirebaseAuthException catch (e) {
                        if (e.email!=emailCon.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Email is not exist please try again",style: TextStyle(color: Colors.red),)));
                          return;
                        }
                      }
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: Text("Don't have an account?")
                ),
                Center(
                  child: TextButton(child: Text('Register'), onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => register()));
                  }),
                ),

              ],
            ),
          ),
        ));
  }
}






