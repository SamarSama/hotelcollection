import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hotelcollection/models/room.dart';
import 'package:hotelcollection/helperClass/important_fun.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class addroomsscreen extends StatefulWidget {
  final String text;
  const addroomsscreen({Key? key, required this.text}) : super(key: key);
  @override
  _addroomsscreenState createState() => _addroomsscreenState();
}
class _addroomsscreenState extends State<addroomsscreen> {
  @override
  final TextEditingController bednocon=TextEditingController();
  final TextEditingController nightPricecon=TextEditingController();
  final TextEditingController hotelIdcon=TextEditingController();
  final TextEditingController roomTypecon=TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  ImportantFun intialzation=ImportantFun();
  late firebase_storage.Reference refStorage ;
  File ?imagge;
  late DatabaseReference base;
  late FirebaseApp app;

  @override
  void initState(){
    super.initState();
    intialzation.startRealTimeFirebase("rooms");
  }
  Widget build(BuildContext context) {
    Future Pickimage() async {
      try{
        final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
        if(image==null)
        {
          return;
        }
        setState(() {
          this.imagge=File(image.path);
          print(imagge?.path);
        }
        );
      }on PlatformException catch(e) {
        print(e);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("failed ")));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Rooms"),
      ),
      body: Container(
        color: Colors.blue,
        child: ListView(
          children: [
            Center(
              child:Text("ِAdd Hotel Rooms",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
              ,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: TextField(
                  controller: bednocon,
                  decoration: new InputDecoration(

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white),
                    ),

                    hintText: 'Enter Bed No',
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    labelText: 'Room BedNo',
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
                  controller: nightPricecon,
                  decoration: new InputDecoration(

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white),
                    ),

                    hintText: 'Enter Night Price',
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    labelText: 'Night Price',
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
                  controller: roomTypecon,
                  decoration: new InputDecoration(

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white),
                    ),

                    hintText: 'Enter Room Type',
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    labelText: 'Room Type',
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
                child:ElevatedButton.icon(onPressed: () async{
                  await Pickimage();
                }
                ,
                  label: Text("pick image Room"),
                  icon:Icon(Icons.image) ,
                )
            ),
            SizedBox(
              height: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child:
                Image.file(
                  imagge
                      ?? File("")
                  ,errorBuilder:(context, error, stackTrace) =>
                Image.asset("asset/images/uploadimage.jpg"),
                )
                ,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child:ElevatedButton(onPressed: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
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
                    refStorage.child(DateTime.now().microsecondsSinceEpoch.toString()).putFile(imagge!).then((p0) async{
                      String imgUrl= await p0.ref.getDownloadURL();
                      String bedno = bednocon.text.trim();
                      String nightprice =nightPricecon.text.trim() ;
                      String roomtype = roomTypecon.text.trim();
                      String hotelId = widget.text.toString().trim();
                      String RoomId = base.push().key;
                      Room Rooms=Room(
                        roomId: RoomId,
                        hotelId: hotelId,
                        nightPrice: nightprice,
                        roomType:roomtype,
                        bedNo:bedno,
                        roomImage:imgUrl,
                        // rate: ratingEnd
                      );
                      base.push().set(Rooms.toJson()).whenComplete(() {

                        setState(() {
                          imagge=null;
                        });

                        bednocon.text="";
                        nightPricecon.text="";
                        roomTypecon.text="";


                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("success ")));

                      });


                    });






                },
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text("Add Room",style: TextStyle(color: Colors.white),),
                )


            ),
          ],
        ),
      ),
    );
  }
}

