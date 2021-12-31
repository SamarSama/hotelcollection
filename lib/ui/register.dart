
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customerdata.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final TextEditingController emailCon = TextEditingController();
  bool isArabic = false;
  final TextEditingController passwordCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
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
                    "Register",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 15),
                  child: Text(
                    "Register now to browse our hot offers",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                            controller: emailCon,
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
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
                  onPressed: () async {
                    if (emailCon.text == "" && passwordCon.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(

                          SnackBar(content: Text("Please Enter data",style: TextStyle(color: Colors.red),)));
                      return;
                    }else if(passwordCon.text.length<6 )
                      {
                        ScaffoldMessenger.of(context).showSnackBar(

                            SnackBar(content: Text("Weak Password",style: TextStyle(color: Colors.red),)));
                        return;
                      }else if(!EmailValidator.validate(emailCon.text))
                        {
                          ScaffoldMessenger.of(context).showSnackBar(

                              SnackBar(content: Text("Please Enter Email Form",style: TextStyle(color: Colors.red),)));
                          return;
                        }
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                              email: emailCon.text,
                          password: passwordCon.text);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CustomerData()));
                    } on FirebaseAuthException catch (e) {
                        if (e.email == emailCon.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Email is Already exist",style: TextStyle(color: Colors.red),)));
                      }
                    } catch (e) {
                     // print(e.toString());
                      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Email is Already exist",style: TextStyle(color: Colors.red),)));

                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
