import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
 import 'package:image_picker/image_picker.dart';
late FirebaseApp app;
late FirebaseDatabase database;
late DatabaseReference base;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

late firebase_storage.Reference refStorage ;
class ImportantFun{
  // Future Pickimage(cc, File imagge) async {
  //
  //   try{
  //     final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image==null)
  //     {
  //       return;
  //     }
  //     setState(() {
  //       imagge=File(image.path);
  //       print(imagge?.path);
  //     }
  //
  //     );
  //
  //
  //   }on PlatformException catch(e) {
  //     print(e);
  //     Navigator.of(cc).pop();
  //     ScaffoldMessenger.of(cc)
  //         .showSnackBar(SnackBar(content: Text("failed ")));
  //   }
  //
  //
  // }
 void startRealTimeFirebase(String dataname)async {
  app = await Firebase.initializeApp();
  database = FirebaseDatabase(app: app);
  base = database.reference().child(dataname);
  refStorage =  storage.ref('/samar_images').child("images");

 }
}