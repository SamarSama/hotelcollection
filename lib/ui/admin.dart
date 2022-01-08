import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:hotelcollection/Models/hotel.dart';
import 'package:hotelcollection/cache_data/cache_data_imp_helper.dart';
import 'package:hotelcollection/ui/open.dart';
import 'package:image_picker/image_picker.dart';

class admin extends StatefulWidget {

  const admin({Key? key}) : super(key: key);

  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {

  CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();

  Future Pickimage() async {
    try{

      print("1111111111111");
      final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
      print("222222222");
      if(image==null)
        {
          print("3333333333");
          return;
        }

      final current_image=image.path;
      print("44444444444");
      setState(() {
        this.imagge=File(image.path);


        print("55555555555");
        print(imagge?.path);
        picker=File(image.path).toString();
      }

      );


    }on PlatformException catch(e) {
      print(e);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("failed ")));
    }


  }

  var currentPage = 0;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late firebase_storage.Reference refStorage ;


  final TextEditingController HotelNameCon = TextEditingController();
  final TextEditingController HotelStarsCon = TextEditingController();
  final TextEditingController HotelGovernmentCon = TextEditingController();
  final TextEditingController HotelQueryPhoneCon = TextEditingController();
  final TextEditingController HotelAdressCon = TextEditingController();
  final TextEditingController HotelImageCon = TextEditingController();
  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;
  double ratingEnd=0.0;
  File? imagge;


  late String  picker;
  // Pick an image
  

  List<Map<String, Widget>> pages = [

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startRealTimeFirebase();

    refStorage =  storage.ref('/samar_images').child("images");

  }



  void startRealTimeFirebase()async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    // FirebaseUser firebaseUser= await   FirebaseAuth.instance.currentUser();
    base = database.reference().child("hotel");
  }


  @override
  Widget build(BuildContext context) {
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
                    child:ElevatedButton.icon(onPressed: () async{

                      await Pickimage();

                    }

                      ,
                      label: Text("pick image"),
                      icon:Icon(Icons.image) ,




                    )
                ),
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child:

                    Image.file(
                        imagge
                        ?? File("")
                    ,errorBuilder:(context, error, stackTrace) =>
                        Icon(Icons.supervised_user_circle),
                    )
                    ,

                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child:ElevatedButton(onPressed: () {

                      uploadImageToFirestore(imagge!);





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
    return Scaffold(
      appBar: AppBar(
        title: pages[currentPage]["title"], //pages[0]
      ),
      body: SafeArea(
        child: Container(
          child: pages[currentPage]["body"],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {

        cacheDataImpHelper.setEmail("");
        cacheDataImpHelper.setPassword("");
        cacheDataImpHelper.setUserType("");
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => open(),));

      },child: Icon(Icons.logout),),//child safearea =
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

  void uploadImageToFirestore(File imgFile){
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

    refStorage.child(DateTime.now().microsecondsSinceEpoch.toString()).putFile(imgFile).then((p0) async{
      String imgUrl= await p0.ref.getDownloadURL();

      print(imgUrl);

      String HotelName = HotelNameCon.text.trim();
      int HotelStars =int.parse(HotelStarsCon.text.trim()) ;
      String HotelGovernment = HotelGovernmentCon.text.trim();
      String HotelQueryPhone = HotelQueryPhoneCon.text.trim();
      String HotelAdress =HotelAdressCon.text.trim() ;

      Hotel hotel=Hotel(
        hotelName: HotelName,
        hotelStarsNo: HotelStars,
        hotelGovernment: HotelGovernment,
        hotelQueryPhone:HotelQueryPhone,
        hotelAdress:HotelAdress,
        hotelImage:imgUrl,
        // rate: ratingEnd
      );


      base.push().set(hotel.toJson()).whenComplete(() {

        setState(() {
          imagge=null;
        });

      HotelNameCon.text="";
        HotelStarsCon.text="";
        HotelGovernmentCon.text="";
        HotelQueryPhoneCon.text="";
         HotelAdressCon.text="";
         HotelImageCon.text="";

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("success ")));

      });


    });

  }
}

