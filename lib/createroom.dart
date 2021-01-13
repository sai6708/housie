import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housie/Controller.dart';
import 'package:housie/editrules.dart';
import 'package:housie/startgame.dart';
import 'dart:math';

class createroom extends StatefulWidget {
  @override
  CreateRoomScreen createState() => CreateRoomScreen();
}

class CreateRoomScreen extends State<createroom> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor:   Color(0xFF2e9eba),
      body: Center(
        child: Column(
          children: <Widget>[
            AppBar(
              title: const Text('Real Time Game',
                style: TextStyle(
                  fontSize: 27,
                  fontFamily: 'Times New Roman',
                  fontStyle: FontStyle.italic
                ),),
              backgroundColor: Color(0xFF2e9eba),
            ),

            Column(
              children: <Widget>[
              Card(
                    elevation: 11.0,
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),

                    child: Container(
                      decoration: BoxDecoration(
                        color:  Color.fromRGBO(64, 75, 96, .9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(width: 1.0, color: Colors.white24))),
                            child: Icon(Icons.group, color: Colors.white, size: 50,),
                          ),
                          title: Text(
                            "House Capacity",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                          ),

                          subtitle:Text("Count of player's can join", style: TextStyle(color: Colors.white)),
                          trailing:
                          DropdownButton<String>(
                              value: GamevalueController.housecapacity,
                              iconSize: 24,
                              icon: Icon(Icons.arrow_downward, color: Colors.white,),
                              elevation: 16,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              onChanged: (String newValue) {
                                setState(() {
                                  GamevalueController.housecapacity = newValue;
                                });
                              },
                              items:  <String>[ '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17',                               '18','19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31',                              '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44',                                 '45', '46', '47', '48', '49','50']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(  color: Colors.black,)),
                                );
                              }).toList(),
                            ),

                      ),
                    ),
                  ),
              Card(
                  elevation: 11.0,
                  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color:  Color.fromRGBO(64, 75, 96, .9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(width: 1.0, color: Colors.white24))),
                          child: Icon(Icons.assignment, color: Colors.white, size: 50,),
                        ),
                        title: Text(
                          "Winning Rules",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),

                        subtitle:Text("Add, Edit Rules", style: TextStyle(color: Colors.white)),
                        trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 40.0,),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                          return editrules();
                        })),
                        ),

                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          label: Text('Create House'),
          onPressed: () => createAroom() ,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  final databaseReference = FirebaseFirestore.instance;
   createAroom() async {
    var batch = databaseReference.batch();
    GamevalueController.ticketids.shuffle();

    batch.set(databaseReference.collection(GamevalueController.useroomcode)
        .doc("Reception")
        ,{
      'rulesize':  GamevalueController.rulename.length.toString(),
      'called_nums': '',
      'roomsize': GamevalueController.housecapacity,
      'creater' : GamevalueController.usercode,
      'started' : 'N',
      'tickets' : GamevalueController.ticketids.sublist(0,int.parse(GamevalueController.housecapacity)).join(','),
      'playersjoined' : 0
    });
     GamevalueController.rulename.asMap().forEach((key, value) {
       batch.set(databaseReference.collection(GamevalueController.useroomcode)
           .doc((key+1).toString()), {'Rulename': value, 'desp' : GamevalueController.descrp[key], 'winner':''});
     });
     /*GamevalueController.tickets.asMap().forEach((key, value) {
       batch.set(databaseReference.collection('ticket')
           .doc((key+1).toString()), {'row_nums': value});
     });*/
    batch.commit().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return startgame();
      }));
    }).catchError((err){
      print('something happened');
    });
  }

}

