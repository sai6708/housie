import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housie/Controller.dart';





class Ticketpage extends StatefulWidget {
  @override
  TicketScreen createState() => TicketScreen();
}

class TicketScreen extends State<Ticketpage> {


  var $recentlycalled = [0, 0, 0, 0, 0];
  var $callednumbers =[];
  bool $view = true;
  var $backcolor = {};
  var $numbercal = "0";
  Widget $chartview;
  Widget $numbercallcards;

  DocumentReference documentReference ;
  StreamSubscription<QuerySnapshot> streamSub_callednums ;

  numberaction(num) {
    setState(() {
      $backcolor[num] = Color(0xFF2e9eba);
    });
  }

  recentlycalled(numcall) {
    if(!($recentlycalled.indexOf(numcall) >= 0)){
      setState(() {
        $callednumbers.add(numcall);
        $recentlycalled.removeAt(0);
        $recentlycalled.add(numcall);
        $numbercal = numcall.toString();
      });
    }
  }

  viewcontroller(newview) {
    setState(() {
      $view = newview;
    });
  }



 @override
  Future<void> initState()  {

    super.initState();


  /*  if(GamevalueController.rownums.isEmpty)
    {
      print('ticket here' + GamevalueController.ticketid.toString());
      print('tickets here' + GamevalueController.gametickets.toString());
      print(GamevalueController.gametickets[GamevalueController.ticketid]);
      FirebaseFirestore.instance
          .collection('ticket')
          .doc(GamevalueController.gametickets[GamevalueController.ticketid])
          .get().then((results) {
        GamevalueController.rownums = results.data()['row_nums'].split(',').toList();
        print(GamevalueController.rownums);
      });
    }

    if(!GamevalueController.rownums.isEmpty){
      setState(() {
        GamevalueController.rownums = GamevalueController.rownums.map((data) => int.parse(data)).toList();
      });
    }

    streamSub_callednums = FirebaseFirestore.instance
        .collection('t'+GamevalueController.gamecode)
        .where('id', isEqualTo: 'called_nums')
        .snapshots()
        .listen((event) {
      print('Counter: ${event.docs[0]['value'].split(',').last}');
      recentlycalled(int.parse(event.docs[0]['value'].split(',').last));
    });*/
  }

  void _onAfterBuild(BuildContext context){
    print("hey its done");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAfterBuild(context));
    return Scaffold(

      body: SafeArea(child: Column(
        children: <Widget>[
          Column(
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

              Visibility(
                  visible: $view,
                  child: Card(
                    margin: EdgeInsets.fromLTRB(10, 16, 10, 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          $numbercal,
                          style: TextStyle(
                              fontSize: 150,
                              fontFamily: 'Times New Roman',
                              color: Color(0xFF2e9eba)),
                        ),

                      ),
                    ),
                  )),
              Visibility( 
                  visible: $view,
                  child: GridView.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 5,
                    physics: ScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true,
                    children: List.unmodifiable(() sync* {
                      yield* _recentlycallednums($recentlycalled);
                    }()),
                  )),
              Visibility(
                  visible: !$view,
                  child: Padding(
                    padding: EdgeInsets.only(left: 09, right: 09, top: 5),
                    child: Table(
                      border: TableBorder.all(),
                      children: List.unmodifiable(() sync* {
                        yield* _chart($callednumbers);
                      }()),
                    ),

                  )),
              Visibility(
                  visible: !$view,
                  child: Card(
                    margin: EdgeInsets.fromLTRB(150, 16, 150, 3),
                    child: Padding(
                      padding: const EdgeInsets.all(11),
                      child: Center(
                        child: Text(
                          $numbercal,
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Times New Roman',
                              color: Color(0xFF2e9eba)),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          Column(
            children: <Widget>[
              GridView.count(
                crossAxisCount: (GamevalueController.rulename.length/2).ceil(),

                crossAxisSpacing: 1,
                shrinkWrap: true,
                children: List.unmodifiable(() sync* {
                  yield* _getrulechips();
                }()),
              ),
            ],
          ),
          Expanded(
            child:           Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Switch(value: $view, activeColor: Colors.white,onChanged: (newview){ viewcontroller(newview);}),
                      IconButton(icon: Icon(Icons.flag, color: Colors.white), onPressed: null, iconSize: 50,)
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(9, 0, 9, 16),
                  color: Color(0xFF434343),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Ticket",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontFamily: 'Times New Roman',
                                fontStyle: FontStyle.italic),
                          ),
                          GridView.count(
                            crossAxisCount: 9,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                            physics:
                            ScrollPhysics(), // to disable GridView's scrolling
                            shrinkWrap: true,
                            children: List.unmodifiable(() sync* {
                              yield* _getrow(GamevalueController.rownums);
                            }()),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      )),
      backgroundColor: Color(0xFF2e9eba),
    );
  }

  List<Widget> _getrulechips() {
    List<Widget> temp = [];
    for (var ind = 0; ind < GamevalueController.rulename.length; ind++) {
      temp.add(
          InputChip(
            avatar: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Text('D'),
            ),
            label: Text(GamevalueController.rulename[ind]),
            onPressed: () {
              print('David got clicked');
            },
          )
      );
    }
    return temp;
  }

  List<Widget> _getrow(numlist) {

    List<Widget> temp = [];
    for (var ind = 0; ind < numlist.length; ind++) {

      if (numlist[ind] == 0 || numlist[ind] == '0') {
        temp.add(ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 36, maxWidth: 28),
          child: Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Colors.white,
            ),
          ),
        ));
      } else {
        temp.add(MaterialButton(
          onPressed: () => ($callednumbers.indexOf(numlist[ind]) >= 0?numberaction(numlist[ind]):""),
          child: Text(
            numlist[ind].toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          color: ($backcolor[numlist[ind]] == null
              ? Colors.white
              : $backcolor[numlist[ind]]),
          splashColor: Colors.grey,
          padding: EdgeInsets.only(left: 10, right: 10),
          textColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));
      }
    }

    return temp;
  }
}

List<Widget> _recentlycallednums($recentlycalled) {
  List<Widget> tempcalled = [];
  for (var looper = 0; looper < $recentlycalled.length; looper++) {
    tempcalled.add(Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Center(
          child: Text(
            $recentlycalled[looper].toString(),
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Times New Roman',
                color: Color(0xFF2e9eba)),
          ),
        ),
      ),
    ));
  }
  return tempcalled;
}

List<TableRow> _chart($callednumbers){
  List<TableRow> temp = [];
  for(var rowlooper = 10; rowlooper <= 90; rowlooper+=10){
    temp.add(
        TableRow(
          children: [
            for(var collooper = (rowlooper - 9); collooper <= rowlooper; collooper++)


              Container(
                padding: const EdgeInsets.all(2) ,
                decoration: BoxDecoration(
                    color: ($callednumbers.contains(collooper)  ?Colors.white: null)
                ),
                child: Center(
                  child: Text(collooper.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Times New Roman',
                          color: ($callednumbers.contains(collooper)  ?Color(0xFF2e9eba): Colors.black)
                      )
                  ),
                ),
              ) ,
          ],
        )
    );
  }
  return temp;
}

/*
StreamBuilder(
stream: FirebaseFirestore.instance.collection('ticket').snapshots(),
builder: (context, snapshot){
if(!snapshot.hasData) return Text("Loading Data....");
return GridView.count(
crossAxisCount: 9,
mainAxisSpacing: 1,
crossAxisSpacing: 1,
physics:
ScrollPhysics(), // to disable GridView's scrolling
shrinkWrap: true,
children: List.unmodifiable(() sync* {
yield* _getrow(snapshot.data.docs[0]['first_row'].split(','));
yield* _getrow(secondtrownums);
yield* _getrow(thirdrownums);
}()),
);
}
)*/

/*
Text(
$numbercal,
style: TextStyle(
fontSize: 150,
fontFamily: 'Times New Roman',
color: Color(0xFF2e9eba)),
)*/
