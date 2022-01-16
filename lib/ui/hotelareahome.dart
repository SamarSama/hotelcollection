import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelcollection/cache_data/cache_data_imp_helper.dart';
import 'package:hotelcollection/ui/addroomsscreen.dart';

import 'open.dart';

class HotelAreaHome extends StatefulWidget {
  final String text;

  const HotelAreaHome({Key? key,required this.text}): super(key: key);

  @override
  _HotelAreaHomeState createState() => _HotelAreaHomeState();
}

class _HotelAreaHomeState extends State<HotelAreaHome> {
  CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Hotel Area"),
),
      body: Container(
        child: Text(widget.text),
      ),
      drawer:Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(child: Text('Drawer Header',style: TextStyle(fontSize: 20,color: Colors.white),)),
            ),
            ListTile(
              title: const Text('Add Hotel Services'),
              trailing:Icon(Icons.add) ,

              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(height: 1,thickness: 1,),

            ListTile(
              title: const Text('Add Hotel Rooms'),
              trailing:Icon(Icons.save) ,

              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>addroomsscreen( text: widget.text,),));
              },
            ),
            Divider(height: 1,thickness: 1,),

            ListTile(
              title: const Text('Users Booking'),
              trailing:Icon(Icons.book) ,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(height: 1,thickness: 1,),

            ListTile(
              title: const Text('Logout'),
              trailing:Icon(Icons.logout) ,

              onTap: () {
                cacheDataImpHelper.setHotelCode("");
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => open(),));
              },
              //"-Mt56By1k7uyBUh-dvvI"
            ),
          ],
        ),
      ) ,
    );
  }
}

