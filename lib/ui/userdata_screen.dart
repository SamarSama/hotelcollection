import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotelcollection/models/profile_model2.dart';
import 'package:hotelcollection/models/profile_model_respose.dart';
import 'package:image_picker/image_picker.dart';

class userdata_screen extends StatefulWidget {
  const userdata_screen({Key? key}) : super(key: key);

  @override
  _userdata_screenState createState() => _userdata_screenState();
}

class _userdata_screenState extends State<userdata_screen> {
  /// fire helper
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_storage.Reference refStorage;

  late FirebaseDatabase database;
  late FirebaseApp app;
  late DatabaseReference base;

  /// ui
  File? fileImg;
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController addressCon = TextEditingController();
  final TextEditingController mobileCon = TextEditingController();
  ProfileModelRespose? profileModelRespose;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startRealTimeFirebase();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("User Data"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await pickImage();
                    },
                    child: ClipOval(
                      child:
                      fileImg==null?
                      Image.network(
                        profileModelRespose?.imgUrl ?? "",
                        width: 150.r,
                        height: 150.r,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("asset/images/profile.png");
                        },
                      ):Image.file(fileImg!,
                        width: 150.r,
                        height: 150.r,),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: nameCon,
                decoration: InputDecoration(
                  hintText: "name",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: addressCon,
                decoration: InputDecoration(
                  hintText: "Address",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: mobileCon,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Mobile Number",
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                        onPressed: () {

                          uploadImageToFirestore(fileImg);
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 18.sp),
                        )),
                    width: 200.w,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void uploadImageToFirestore(File? imgFile) {


    if (imgFile==null) {


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





      String name = nameCon.text.trim();
      String address = addressCon.text.trim();
      String mobile = mobileCon.text.trim();

      Map<String, dynamic> updateMap = Map();
      updateMap["name"] = name;
      updateMap["address"] = address;
      updateMap["mobile"] = mobile;
      updateMap["email"] = FirebaseAuth.instance.currentUser?.email;
      updateMap["img_url"] = profileModelRespose!.imgUrl;

      base.set(updateMap).whenComplete(() {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("success ")));
      });

    }  else
      {

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

        refStorage
            .child(DateTime.now().microsecondsSinceEpoch.toString())
            .putFile(imgFile)
            .then((p0) async {
          String imgUrl = await p0.ref.getDownloadURL();

          print(imgUrl);

          String name = nameCon.text.trim();
          String address = addressCon.text.trim();
          String mobile = mobileCon.text.trim();

          Map<String, dynamic> updateMap = Map();
          updateMap["name"] = name;
          updateMap["address"] = address;
          updateMap["mobile"] = mobile;
          updateMap["email"] = FirebaseAuth.instance.currentUser?.email;
          updateMap["img_url"] = imgUrl;

          base.set(updateMap).whenComplete(() {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("success ")));
          });
        });
      }


  }



  void startRealTimeFirebase() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);

    base = database
        .reference()
        .child("profiles")
        .child(FirebaseAuth.instance.currentUser!.uid);
    refStorage = storage.ref('/samar_images').child("images");

    base.onValue.listen((event) {


      print(event.snapshot.value.toString());



  setState(() {

    profileModelRespose =ProfileModelRespose.fromJson(event.snapshot.value);
    nameCon.text=profileModelRespose!.name!;
    addressCon.text=profileModelRespose!.address!;
    mobileCon.text=profileModelRespose!.mobile!;

  });
    });

  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }

      setState(() {
        fileImg = File(image.path);
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("failed ")));
    }
  }
}
