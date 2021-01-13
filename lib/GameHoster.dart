import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:housie/Controller.dart';

class GameHoster extends StatefulWidget{
  GameHosterScreen createState() => GameHosterScreen();  
}

class GameHosterScreen extends State<GameHoster>{

  Timer _timer;
  int _start = 0;
  bool startstopvisible = true;
  bool pauseresumevisible = true;
  var $callednumbers =[];
  Color onscreennum = Color(0xFF2e9eba);
  final DocumentReference databaseReference = FirebaseFirestore.instance.collection(GamevalueController.useroomcode).doc('Reception');

  startTimer() async {

    if (_timer != null) {
      _timer.cancel();
    }



    GamevalueController.numbertocall.shuffle();
    GamevalueController.numbertocall.shuffle();
    setState(() {
      _start = GamevalueController.numbertocall.length-1;
      $callednumbers.add( GamevalueController.numbertocall[_start]);
      startstopvisible = false;
      updatenum();
    });

    _timer = new Timer.periodic(
      const Duration(seconds: 3),
          (Timer timer) => setState(
            ()  {
          if (_start == 0) {
            timer.cancel();
          } else {
            _start = _start - 1;
            $callednumbers.add( GamevalueController.numbertocall[_start]);
            updatenum();
          }
        },
      ),
    );
  }

  updatenum() async{
    try {
      await databaseReference
          .set({'called_nums': $callednumbers.join(',')}, SetOptions(merge: true));
    } on Exception catch (e) {
      // TODO
      pauseTimer();
    }
  }

  void pauseTimer() {
    if (_timer != null) _timer.cancel();
    setState(() {
      pauseresumevisible = false;
      onscreennum = Colors.red;
    });
  }

  void unpauseTimer() {
    startTimer();
    setState(() {
      pauseresumevisible = true;
      onscreennum = Color(0xFF2e9eba);
    });
  }

  @override
  void stopTimer() {
    _timer.cancel();
  }



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Real Time Game',
            style: TextStyle(
                fontSize: 27,
                fontFamily: 'Times New Roman',
                fontStyle: FontStyle.italic
            ),),
          backgroundColor: Color(0xFF2e9eba),
        ),
        body: Wrap(children: <Widget>[
          Column(
            children: <Widget>[
               Padding(
                padding: EdgeInsets.only(left: 09, right: 09, top: 5),
                child: Table(
                  border: TableBorder.all(),
                  children: List.unmodifiable(() sync* {
                    yield* _chart($callednumbers);
                  }()),
                ),
              ),
               Card(
                //margin: EdgeInsets.fromLTRB(150, 16, 150, 7),
                child: Padding(
                  padding: const EdgeInsets.all(11),
                  child: Center(
                    child: Text(
                      (_timer != null?GamevalueController.numbertocall[_start].toString():"0"),
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Times New Roman',
                          color: onscreennum),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Visibility(
                    visible: startstopvisible,
                    child: RaisedButton(
                      onPressed: () {
                        startTimer();
                      },
                      child: Text("start"),
                    ),
                  ),
                  Visibility(
                    visible: !startstopvisible,
                    child: RaisedButton(
                      onPressed: () {
                        stopTimer();
                      },
                      child: Text("stop"),
                    ),
                  ),
                  Visibility(
                    visible: pauseresumevisible,
                    child: RaisedButton(
                      onPressed: () {
                        pauseTimer();
                      },
                      child: Text("Pause"),
                    ),
                  ),
                  Visibility(
                    visible: !pauseresumevisible,
                    child: RaisedButton(
                      onPressed: () {
                        unpauseTimer();
                      },
                      child: Text("Unpause"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      backgroundColor: Color(0xFF2e9eba),
    );
  }
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
                          fontSize: 22,
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