import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


class UploadingImageToFirebaseStorage extends StatefulWidget {
  const UploadingImageToFirebaseStorage({Key? key}) : super(key: key);

  @override
  _UploadingImageToFirebaseStorageState createState() => _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState extends State<UploadingImageToFirebaseStorage> {
  File?imagge;
  Future Pickimage() async {
    try{
      final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null)
        return;
      final current_image=image.path;
      setState(() =>
      imagge=File(image.path)

      );
    }on PlatformException catch(e) {
      print(e);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("failed ")));
    }
  //  Future uploadImageToFirebase(BuildContext context) async {
  //    String fileName = basename(imagge.path);
   //   StorageReference firebaseStorageRef =
    //  FirebaseStorage.instance.ref().child('uploads/$fileName');
     // StorageUploadTask uploadTask = firebaseStorageRef.putFile(imagge);
    //  StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    //  taskSnapshot.ref.getDownloadURL().then(
     //       (value) => print("Done: $value"),
     // );
  //  }


  }

  @override

  Widget build(BuildContext context) {
    return Container();
  }
}
