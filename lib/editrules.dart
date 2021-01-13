import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housie/Controller.dart';



class editrules extends StatefulWidget {

  static  of(BuildContext context) => context.findAncestorStateOfType();

  @override
  EditRuleScreen createState() => EditRuleScreen();
}

class EditRuleScreen extends State<editrules> {

  removeItem(int position) {
    setState(() {
      GamevalueController.rulename.removeAt(position);
      GamevalueController.descrp.removeAt(position);
    });
  }

  addedititem(int position, String addrule, String addescrp){
    setState(() {
      if(position==null){
        GamevalueController.rulename.add(addrule);
        GamevalueController.descrp.add(addescrp);
      }
      else{
        GamevalueController.rulename[position]=addrule;
        GamevalueController.descrp[position]=addescrp;
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF2e9eba),
      appBar: AppBar(
        title: const Text('Winning Rules',
          style: TextStyle(
              fontSize: 27,
              fontFamily: 'Times New Roman',
              fontStyle: FontStyle.italic
          ),),
        backgroundColor: Color(0xFF2e9eba),
      ),
      body: Column(
        children: <Widget>[ Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: GamevalueController.rulename.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 11.0,
                margin: new EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(64, 75, 96, .9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      child: Text(
                        (index < 10 ? '0' : '') + (index + 1).toString(),
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                    ),
                    title: Text(
                      GamevalueController.rulename[index],
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),

                    subtitle: Text(GamevalueController.descrp[index],
                        style: TextStyle(color: Colors.white)),
                    trailing:
                    Icon(Icons.menu, color: Colors.white, size: 30.0,),
                    onTap: () {
                      _popaddeditform(index, context);
                    },
                  ),
                ),
              );
            },
          ),
        )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _popaddeditform(null, context);
        },
        child: Icon(Icons.add_circle),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      ),
    );
  }


  _popaddeditform(int position, BuildContext context) {
    TextEditingController tecRule = new TextEditingController();
    TextEditingController tecdesp = new TextEditingController();
    tecRule.text =
    (position == null ? '' : GamevalueController.rulename[position]);
    tecdesp.text =
    (position == null ? '' : GamevalueController.descrp[position]);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: Text((position == null ? 'Add Rule' : 'Edit Rule'),
            style: TextStyle(
                color: Color(0xFF2e9eba), fontWeight: FontWeight.bold),
          ),
          content: Wrap(
            children: <Widget>[
              TextField(
                minLines: 1,
                maxLines: 1,
                controller: tecRule,
                decoration: new InputDecoration.collapsed(
                  hintText: 'Rule Name',
                ),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                minLines: 1,
                maxLines: 15,
                controller: tecdesp,
                decoration: new InputDecoration(
                  hintText: 'Rule Name',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                ),
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                      addedititem(position,tecRule.text,tecdesp.text);
                    },
                    child: Text("Save", style: TextStyle(color: Colors.blue,),),
                  ),

                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                      removeItem(position);
                    },
                    child: Text(
                        "Delete", style: TextStyle(color: Colors.blue,)),
                  ),
                ],
              )
            ],
          ),

        );
      },

    );
  }
}

