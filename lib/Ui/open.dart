import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelcollection/Ui/admin.dart';
import 'package:hotelcollection/Ui/loginscreen.dart';

import 'adminanduserlogin.dart';

class open extends StatelessWidget {
  const open({Key? key}) : super(key: key);

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
}
