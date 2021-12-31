import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelcollection/Models/Drawermodel.dart';


class customerdata extends StatefulWidget {
  @override
  _customerdataState createState() => _customerdataState();
}

class _customerdataState extends State<customerdata> {
  var currentPage = 0;
/*  List pages=[
    Center(
      child: Container(
        child: Text("Home",style: TextStyle(fontSize: 30,color: Colors.blue,fontFamily:"Arial"),),
      ),
    ),Center(
      child: Container(
        child: Text("Categories",style: TextStyle(fontSize: 30,color: Colors.blue,fontFamily:"Arial"),),
      ),
    ),Center(
      child: Container(
        child: Text("Search",style: TextStyle(fontSize: 30,color: Colors.blue,fontFamily:"Arial"),),
      ),
    ),
  ];*/

  List drawerMenu1=[
    Drawermodel(Icons.dashboard, "Dashboard",0),
    Drawermodel(Icons.contacts, "Contacts",1),
    Drawermodel(Icons.notes, "Notes",2),
    Drawermodel(Icons.event, "Events",3),
  ];
  List drawerMenu2=[
    Drawermodel(Icons.settings, "Settings",4),
    Drawermodel(Icons.notifications, "Notifications",5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"), //pages[0]
      ),
      body: SafeArea(
        child: Container(

        ),
      ), //child safearea => widget? ,


      //drawerScrimColor: Colors.black,
      onDrawerChanged: (state){
        //ternary operator
       // state? showToast("opened",duration: Duration(seconds: 5),context: context):showToast("closed",duration: Duration(seconds: 5),context: context);
      },
      drawer: SafeArea(
        child: Drawer(
          elevation: 2.3,
          child: ListView(
            // header
            children: [
              DrawerHeader(
                //container with alignment.center
                decoration: BoxDecoration(color: Colors.green),
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          image: AssetImage("assets/images/top-office.jpg"),
                        ),
                      ),
                      radius: 40,
                    ),
                    Text(
                      "Top Office",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "TopOffice@gmai.com",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ), //he
              ...drawerMenu1.map((e) => fmenu1(e)),
              Divider(height: 1,thickness: 0,),
              ...drawerMenu2.map((e) => fmenu1(e)),



            ],
          ),
        ),
      ),
    );
  }
  Widget fmenu1(Drawermodel item){
    return  ListTile(

      leading: Icon(item.drawericon),
      title: Text(item.drawertext),
      subtitle: Text("Open Dashboard"),
      contentPadding: EdgeInsets.symmetric(horizontal: 35,vertical: 0),
      dense: true,

      onTap: (){
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.drawertext)));

        switch(item.index){
          case 0:
           // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.text)));
           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
            break;
          case 1:
            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(item.text)));
           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Contacts()));
            break;
        }
      },
    );
  }

}

