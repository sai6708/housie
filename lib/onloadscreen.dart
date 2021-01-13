import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/thatiks/AndroidStudioProjects/housie/housie/android/enterhouse.dart';
import 'package:housie/startgame.dart';

import 'Controller.dart';
import 'createroom.dart';

class onloadscreen extends StatefulWidget {
  @override
  firstscreen createState() => firstscreen();
}

class firstscreen extends State<onloadscreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor:   Color(0xFF2e9eba),
      body: SafeArea(
          child: Container(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                        return enterhouse();
                      })),
                      child: Text(
                       "Join Game",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 30,
                            color:  Color(0xFF2e9eba),
                        ),
                      ),
                      color:  Colors.white,
                      splashColor: Color(0xFF2e9eba),
                      padding: EdgeInsets.only(left: 52.5, right: 52.5, top: 10, bottom: 10),
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                        onPressed: () => searchforuserhouse(),
                        child: Text(
                          "Create House",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 30,
                            color:  Color(0xFF2e9eba),
                          ),
                        ),
                        color:  Colors.white,
                        splashColor: Color(0xFF2e9eba),
                        padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),
                  ],
            ))
          )
      ),
    );
  }

  void searchforuserhouse() async
  {
    await  FirebaseFirestore.instance
        .collection(GamevalueController.useroomcode)
        .doc('Reception')
        .get().then((DocumentSnapshot documentSnapshot){
       if(documentSnapshot.exists)
       {
         print('Hey we got it');
         Navigator.push(context, MaterialPageRoute(builder: (context){
           return startgame();
         }));

       }
       else{
         Navigator.push(context, MaterialPageRoute(builder: (context){
           return createroom();
         }));
       }
    });
  }
}