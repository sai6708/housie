import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housie/GameHoster.dart';

class startgame extends StatefulWidget {
  @override
  startgameScreen createState() => startgameScreen();
}

class startgameScreen extends State<startgame> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF2e9eba),
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
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 2, bottom: 5),
              padding: const EdgeInsets.only(
                  left: 9, right: 9, top: 12, bottom: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.5,),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "House Code:",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Times New Roman',
                          fontStyle: FontStyle.italic,
                          color: Colors.white
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              top: 15, right: 15, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 32.5, right: 32.5),
                            child: Text(
                              "123456",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 45,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFF2e9eba),
                              ),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.cyan, // button color

                            child: IconButton(
                              icon: Icon(Icons.share, color: Colors.white),
                              onPressed: null,
                              iconSize: 30,),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Share the ID with your Family or friends to ask them to join",
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),),
            ),
            Text(
              "Players Joined",
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
            GridView.count(
              padding: EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 10),
              crossAxisCount: 5,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              shrinkWrap: true,
              children: List.unmodifiable(() sync* {
                yield* _getplayers();
              }()),
            ),
            MaterialButton(
                onPressed: () =>
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return GameHoster();
                    })),
                child: Text(
                  "Start Game",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    color: Color(0xFF2e9eba),
                  ),
                ),
                color: Colors.white,
                splashColor: Color(0xFF2e9eba),
                padding: EdgeInsets.only(
                    left: 70, right: 70, top: 10, bottom: 10),
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                )
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _getplayers() {
    List<Widget> temp = [];
    for (var i = 20; i >= 1; i--) {
      temp.add(ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 7, maxWidth: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Icon(Icons.add_box, color: Colors.black,),
        ),
      ));
    }
    return temp;
  }
}