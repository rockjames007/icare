import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddQualificationDetails extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AddQualificationDetailState();
  }
}
class _AddQualificationDetailState extends State<AddQualificationDetails>
{
  List<String> _types = <String>['Higher Secondary Certificate','Post Graduation','Secondary School Leaving Certificate','Under Graduation'];

  String _type='Secondary School Leaving Certificate';
 FirebaseUser _user;
 DateTime _fromdate=null;
  DateTime _thrudate=null;
 final instController = TextEditingController();
 final qualController = TextEditingController();
@override
void initState(){
  super.initState();
  try {

    FirebaseAuth.instance.currentUser().then(
            (_user) =>
            setState(() {
              this._user = _user;
            }
            )
    );
  }
  catch (e) {
  }
}
@override
Widget build(BuildContext context) {
  return AlertDialog(
    titlePadding: EdgeInsets.all(0.0),
    title:Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(13, 80, 121 , 1.0),
      ),
      child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Add Document',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white),textAlign: TextAlign.center, ),
          ] ),
    ),
    contentPadding:EdgeInsets.all(0.0),
    content: SingleChildScrollView(
      child:
      new Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title:Column(
                children: <Widget>[
                  new InputDecorator(
                    decoration:  InputDecoration(
                      icon:  Icon(Icons.library_books),
                      labelText: 'Qualification Type:',
                    ),
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        value: _type,
                        isDense: true,
                        isExpanded: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _type = newValue;
                          });
                        },
                        items: _types.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ) ,
            ),
            ListTile(
              title:new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.location_city),
                  labelText: 'Institution/Organizatin:',
                ),
                controller: instController,
              ),
            ),
              ListTile(
              title:new TextFormField(
              decoration: const InputDecoration(
              icon: const Icon(Icons.location_city),
              labelText: 'Qualification/Designation:',
               ),
                controller: qualController,
               ),
              ),
            ListTile(
              title:DateTimePickerFormField( format: DateFormat("dd/MM/yyyy"),
                  textAlign: TextAlign.start,
                  dateOnly: true,
                  decoration: new InputDecoration(icon: const Icon(Icons.calendar_today),labelText: "From Date:"),
                  onChanged: (DateTime newValue) {
                    setState(() {
                      _fromdate=newValue;
                    });
                  }
              ) ,
            ),
            ListTile(
              title:DateTimePickerFormField( format: DateFormat("dd/MM/yyyy"),
                  textAlign: TextAlign.start,
                  dateOnly: true,
                  decoration: new InputDecoration(icon: const Icon(Icons.calendar_today),labelText: "Thru Date:"),
                  onChanged: (DateTime newValue) {
                    setState(() {
                      _thrudate=newValue;
                    });
                  }
              ) ,
            ),
          ],
        ),
      ),
    ),

    actions: <Widget>[
      // usually buttons at the bottom of the dialog
      new FlatButton(
          child: new Text("Save"),
          onPressed: () {
            Firestore.instance.runTransaction((transaction) async {
              await transaction.set(
                  Firestore.instance.collection("users").document(_user.uid).collection('qualification').document(),
                  {
                    'type':_type,
                    'status': 'unverified',
                    'qual':qualController.text,
                    'inst': instController.text,
                    'fromd':_fromdate,
                    'thrud':_thrudate
                  });
            }
             );
            Navigator.of(context).pop();
             }
      ),

      new FlatButton(
        child: new Text("Close"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

}
