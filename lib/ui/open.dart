import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelcollection/Ui/admin.dart';
import 'package:hotelcollection/Ui/loginscreen.dart';
import 'package:hotelcollection/cache_data/cache_data_imp_helper.dart';
import 'package:hotelcollection/ui/customerdata.dart';
import 'package:hotelcollection/utils/data/data_helper.dart';

import 'adminanduserlogin.dart';

class open extends StatefulWidget {

   open({Key? key}) : super(key: key);

  @override
  State<open> createState() => _openState();
}

class _openState extends State<open> {
  CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();
  @override

void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loginCache(context);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Padding(

        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3,right:  MediaQuery.of(context).size.width/3,),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("دخول الفنادق"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String textToSend = "User";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          adminanduserlogin(
                            text: textToSend,
                          ),
                    ));
              },
              child: Text("دخول المستخدمين"),
            ),
            ElevatedButton(
              onPressed: () {
                String textToSend = "Admin";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          adminanduserlogin(
                            text: textToSend,
                          ),
                    ));
              },
              child: Text("دخول المدير"),
            ),
            DropdownButton<String>(
              items: <String>['English', 'Arabic'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            )
          ],
        ),
      ),
      ),
    );
  }

  void loginCache(BuildContext cc)async{

    String userType=cacheDataImpHelper.getUserType();

    if (userType==DataHelper.ADMIN_TYPE) {


      Future.delayed(Duration(microseconds: 200),(){
        Navigator.of(cc).pushReplacement(
            MaterialPageRoute(builder: (cc) => admin()));
      });


    } else if (userType==DataHelper.HOTEL_TYPE){


    }

    else
      {
        try {

          String email=cacheDataImpHelper.getEmail();
          String password=cacheDataImpHelper.getPassword();

          if (email.isEmpty||password.isEmpty) {
            return;

          }
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password
          );




          Navigator.of(cc).pushReplacement(MaterialPageRoute(builder: (context) => CustomerData()));
        } on FirebaseAuthException catch (e) {


        }
      }


  }
}

