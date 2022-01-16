import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelcollection/cache_data/cache_data_imp_helper.dart';
import 'package:hotelcollection/utils/data/data_helper.dart';

import 'hotelareahome.dart';

class hotelhotel extends StatefulWidget {
  const hotelhotel({Key? key}) : super(key: key);

  @override
  _hotelhotelState createState() => _hotelhotelState();
}

class _hotelhotelState extends State<hotelhotel> {
  TextEditingController hotelId=TextEditingController();
  late FirebaseDatabase database;
  String tr="-Mt5Y66I8H_Z5PlPimcS";
  late DatabaseReference Hoteldata;
  CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();

  late FirebaseApp app;
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
                    "Login now to browse your data",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child:    TextField(
                            controller: hotelId,
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.teal)),
                              hintText: 'Enter your code',
                              labelText: 'Hotel code',

                              prefixIcon: const Icon(
                                Icons.code,
                                color: Colors.green,
                              ),
                              //prefixText: ' ',
                              //suffixText: 'USD',
                              //suffixStyle: const TextStyle(color: Colors.green)),
                            )),

                      ),

                    
                    ],
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () async{
                    if(hotelId.text==""){
                      print("null");

                    }else{
                      app  =  await Firebase.initializeApp();
                      database = FirebaseDatabase(app: app);
                      Hoteldata=database.reference().child("hotel");
                      Query t=Hoteldata.orderByChild("HotelId").equalTo(hotelId.text);
                      t.onValue.listen((event) {
                        print(event.snapshot.value.toString());
                        if(event.snapshot.value !=null){
                          cacheDataImpHelper.setUserType(DataHelper.HOTEL_TYPE);
                          cacheDataImpHelper.setHotelCode(hotelId.text);
                          print(hotelId.text);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HotelAreaHome( text: hotelId.text,)));
                        }else{
                          print("not exist");
                        }
                      });
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                

              ],
            ),
          ),
        ));
    }
}
