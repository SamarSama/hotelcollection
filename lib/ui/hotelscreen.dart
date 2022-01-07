import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelcollection/Models/hotel.dart';

import 'ProductDetaitlsScreen.dart';

class hotelscreen extends StatefulWidget {
  const hotelscreen({Key? key}) : super(key: key);

  @override
  _hotelscreenState createState() => _hotelscreenState();
}

class _hotelscreenState extends State<hotelscreen> {
  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;
  late final uid;
  List<Hotel> allHotels=[];
  List<Hotel> searchList=[];
  bool isStart=true;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final  FirebaseUser;
  void startRealTimeFirebase()async {
    app  =  await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    User user = await auth.currentUser!;
     uid = user.uid;
    final uemail = user.email;
    base =database.reference().child("hotel");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      Hotel p=Hotel.fromJson(event.snapshot.value);
      allHotels.add(p);
      searchList.add(p);

      setState(() {
      });
    }).onDone(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startRealTimeFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                onChanged: (char) {
                  if (char.isEmpty) {

                    setState(() {
                      allHotels=searchList;
                    });

                  }else
                  {
                    allHotels=[];
                    for(Hotel model in searchList  )
                    {
                      if (model.hotelGovernment!.contains(char)) {
                        allHotels.add(model);
                      }
                    }

                    setState(() {
                    });




                  }



                },
                decoration: InputDecoration(hintText: "search"
                    ,
                    suffixIcon: Icon(Icons.search)
                ),


              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductDetaitlsScreen(allHotels[(allHotels.length - 1) - index]),
                      ));
                    },
                    child: Container(
                      color: Colors.orange.withOpacity(0.5),
                      padding: EdgeInsets.all(12),
                      child: Container(
                        height: 200,
                        child: Column(
                          children: [
                            Image.network(
                              allHotels[(allHotels.length - 1) - index]
                                  .hotelImage!,
                              height: 100,
                              width: 200,
                              fit: BoxFit.fill,
                            ),


                            SizedBox(
                              height: 18,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hotel Name : ${allHotels[(allHotels.length - 1) - index].hotelName}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Government : ${allHotels[(allHotels.length - 1) - index].hotelGovernment}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: allHotels.length,
              ),
            ),
          ],
        )

    );
  }
}

