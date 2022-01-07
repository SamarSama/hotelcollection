import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:hotelcollection/Models/hotel.dart';
import 'package:image_picker/image_picker.dart';

class admin extends StatefulWidget {

  const admin({Key? key}) : super(key: key);

  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {

  Future Pickimage() async {
    try{
      final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null)
        return;
      final current_image=image.path;
      setState(() =>
        this.imagge=File(image.path)

      );
      picker=File(image.path).toString();

    }on PlatformException catch(e) {
      print(e);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("failed ")));
    }


  }

  var currentPage = 0;
  final TextEditingController HotelNameCon = TextEditingController();
  final TextEditingController HotelStarsCon = TextEditingController();
  final TextEditingController HotelGovernmentCon = TextEditingController();
  final TextEditingController HotelQueryPhoneCon = TextEditingController();
  final TextEditingController HotelAdressCon = TextEditingController();
  final TextEditingController HotelImageCon = TextEditingController();
  late FirebaseDatabase database;
  late FirebaseApp  app;
  double ratingEnd=0.0;
  late DatabaseReference base;
  File?imagge;


  late String  picker;
  // Pick an image
  

  List<Map<String, Widget>> pages = [

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startRealTimeFirebase();
    pages = [
      {
        "body": Center(
          child: Container(
            child: Text(
              "Home",
              style: TextStyle(
                  fontSize: 30, color: Colors.blue, fontFamily: "Arial"),
            ),
          ),
        ),
        "title": Text("Home")
      },
      {
        "body": Center(


          child: Container(
            color: Colors.blue.shade800,
            child: ListView(

              children: [
                Center(
                  child:Text("ِAdd Hotel Data",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
                  ,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: TextField(
                      controller: HotelNameCon,
                      decoration: new InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),

                        hintText: 'Enter Hotel Name',
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelText: 'Hoten Name',
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        //prefixText: ' ',
                        //suffixText: 'USD',
                        //suffixStyle: const TextStyle(color: Colors.green)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: TextField(
                      controller: HotelStarsCon,
                      decoration: new InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),

                        hintText: 'Enter Hotel Stars no',
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelText: 'Hoten stars no',
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: const Icon(
                          Icons.stars,
                          color: Colors.white,
                        ),
                        //prefixText: ' ',
                        //suffixText: 'USD',
                        //suffixStyle: const TextStyle(color: Colors.green)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: TextField(
                      controller: HotelGovernmentCon,
                      decoration: new InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),

                        hintText: 'Enter Government',
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelText: 'Hoten Government',
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: const Icon(
                          Icons.eighteen_mp_rounded,
                          color: Colors.white,
                        ),
                        //prefixText: ' ',
                        //suffixText: 'USD',
                        //suffixStyle: const TextStyle(color: Colors.green)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: TextField(
                      controller: HotelQueryPhoneCon,

                      decoration: new InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),

                        hintText: 'Enter Query phone',
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelText: 'Hoten Query phone',
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        //prefixText: ' ',
                        //suffixText: 'USD',
                        //suffixStyle: const TextStyle(color: Colors.green)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: TextField(
                      controller: HotelAdressCon,

                      decoration: new InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),

                        hintText: 'Enter Hotel Adress',
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelText: 'Hoten Adress ',
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: const Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                        //prefixText: ' ',
                        //suffixText: 'USD',
                        //suffixStyle: const TextStyle(color: Colors.green)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child:ElevatedButton.icon(onPressed: () {
                    Pickimage();

                  }

                  ,
                  label: Text("pick image"),
                  icon:Icon(Icons.image) ,




                  )
                ),
      Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child:imagge!=null?Text(imagge.toString()):Text("ىعنن"),

      ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child:ElevatedButton(onPressed: () {
                       String HotelName = HotelNameCon.text.trim();
                       int HotelStars =int.parse(HotelStarsCon.text.trim()) ;
                       String HotelGovernment = HotelGovernmentCon.text.trim();
                       String HotelQueryPhone = HotelQueryPhoneCon.text.trim();
                       String HotelAdress =HotelAdressCon.text.trim() ;
                       String url =picker ;
                      Hotel hotel=Hotel(
                        hotelName: HotelName,
                        hotelStarsNo: HotelStars,
                        hotelGovernment: HotelGovernment,
                        hotelQueryPhone:HotelQueryPhone,
                        hotelAdress:HotelAdress,
                        hotelImage:url,
                        // rate: ratingEnd
                      );
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        // false = user must tap button, true = tap outside dialog
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: Text('Loading....'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),

                          );
                        },
                      );

                       base.push().set(hotel.toJson()).whenComplete(() {
                       Navigator.of(context).pop();
                       ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("success ")));

                                         });


                    },
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text("Add Hotel",style: TextStyle(color: Colors.white),),
                    )


                ),
              ],
            ),
          ),),

        "title": Text("Add Hotel")
      },
      {
        "body": Center(
          child: Container(
            child: Text(
              "Reports",
              style: TextStyle(
                  fontSize: 30, color: Colors.blue, fontFamily: "Arial"),
            ),
          ),
        ),
        "title": Text("Reports")
      },

    ];


  }
  void startRealTimeFirebase()async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    // FirebaseUser firebaseUser= await   FirebaseAuth.instance.currentUser();
    base = database.reference().child("hotel");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: pages[currentPage]["title"], //pages[0]
      ),
      body: SafeArea(
        child: Container(
          child: pages[currentPage]["body"],
        ),
      ), //child safearea =
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[50],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.redAccent,
        elevation: 100,
        selectedFontSize: 25,
        unselectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        iconSize: 30,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Add Hotel",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ten_k_sharp),
            label: "Reports",
          ),
        ],
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;

          });
        },
      ),
    );
  }
}

