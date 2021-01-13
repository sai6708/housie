import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housie/Controller.dart';
import 'package:housie/ticketscreen.dart';


class enterhouse extends StatefulWidget {
  @override
  HouseEnteryScreen createState() => HouseEnteryScreen();
}

class HouseEnteryScreen extends State<enterhouse> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF2e9eba),
      body:
      Wrap(
        children: <Widget>[
          AppBar(
            title: const Text('Exit House',
              style: TextStyle(
                  fontSize: 27,
                  fontFamily: 'Times New Roman',
                  fontStyle: FontStyle.italic
              ),),
            backgroundColor: Color(0xFF2e9eba),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                color: Colors.white,
                elevation: 20,
                //margin: EdgeInsets.only(left: 30,right: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),

                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.only(
                          top: 5, left: 30, right: 30, bottom: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: "Enter Housie Id",
                          fillColor: Color(0xFF2e9eba),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF2e9eba), width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        maxLines: 1,
                        maxLength: 6,
                        style: TextStyle(
                            fontSize: 30.0,
                            height: 2.0,
                            color: Color(0xFF2e9eba)
                        ),
                        onChanged: (Text) {
                          GamevalueController.gamecode = Text;
                          //print( GamevalueController.gamecode);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_forward,
                              color: Color(0xFF2e9eba)),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            fetchhouse(context);
                          },
                          iconSize: 50,)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }


   fetchhouse(context) async {
   await geticket();
   await geticketrows();
   await getgamerules();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      print('movinr to next screen');
      return Ticketpage();
    }));
  }
}

Future<Function> geticket() async {
  DocumentSnapshot snapshot;
  //if (GamevalueController.ticketid == null) {
    var documentReference = FirebaseFirestore.instance.collection(
        't' + GamevalueController.gamecode).doc('Reception');
    print("text field value" + GamevalueController.gamecode);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      snapshot = await transaction.get(documentReference);
      print('snapshot here' + snapshot.data()['playersjoined'].toString());
      GamevalueController.gametickets = snapshot.data()['tickets'].toString().split(",");
      GamevalueController.ticketid = int.parse(snapshot.data()['playersjoined'].toString());
      await transaction.update(documentReference,
          {'playersjoined': (GamevalueController.ticketid + 1)});
    });
  //}
}

Future<Function> geticketrows() async {
  //if(!GamevalueController.rownums.isEmpty)  {
    print('ticket here' + GamevalueController.ticketid.toString());
    print('tickets here' + GamevalueController.gametickets.toString());
    print(GamevalueController.gametickets[GamevalueController.ticketid]);
    await FirebaseFirestore.instance
        .collection('ticket')
        .doc(GamevalueController.gametickets[GamevalueController.ticketid])
        .get().then((results) {
      GamevalueController.rownums = results.data()['row_nums'].split(',').toList();
    });
  //}
  print(GamevalueController.rownums);
}

Future<Function> getgamerules() async {
  //if(!GamevalueController.rownums.isEmpty)  {


  await FirebaseFirestore.instance
      .collection('t' + GamevalueController.gamecode)
      .limit(5)
      .get().then((QuerySnapshot querySnapshot) {
        GamevalueController.rulename = querySnapshot.docs.map((e) => e["Rulename"].toString()).toList();
        GamevalueController.descrp = querySnapshot.docs.map((e) => e["desp"].toString()).toList();
        print(GamevalueController.rulename);
        print(GamevalueController.descrp);
        /*querySnapshot.docs.forEach((doc) {
          print(doc["Rulename"] +" and  "+ doc["desp"]);
        });*/
      });
  //}
}
//void _showToast(BuildContext context) {
//  final scaffold = Scaffold.of(context);
//  Scaffold.currentState.showSnackBar(
//    SnackBar(
//      content: const Text('Added to favorite'),
//      action: SnackBarAction(
//          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
//    ),
//  );
//}

/*
Card(
          color: Colors.white,
          elevation: 20,
          //margin: EdgeInsets.only(left: 30,right: 30),
          child: Column(

            children: <Widget>[

              Text(
                "Enter Housie Id",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Times New Roman',
                    color: Color(0xFF2e9eba)
                ),
              ),
              Card(
                color: Colors.black,
                margin: EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 30.0,
                      height: 2.0,
                      color: Colors.white
                  ),
                ),
              )
            ],
          )
        )
*/
