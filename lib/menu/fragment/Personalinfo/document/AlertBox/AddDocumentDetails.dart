import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddDocumentDetails extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AddDocumentDetailState();
  }
}
class _AddDocumentDetailState extends State<AddDocumentDetails>
{
  List<String> _types = <String>['PAN Card','Aadhar Card','Passport','License'];
  List<String> _countries = <String>['India','USA'];
  String _country='India';
  String _type='PAN Card';
 FirebaseUser _user;
 DateTime _issuedate=null;
  DateTime _expirydate=null;
 final nameController = TextEditingController();
 final uninumberController = TextEditingController();
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
                      labelText: 'Document Type:',
                    ),
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        value: _type,
                        isDense: true,
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
                  labelText: 'Name as per Document:',
                ),
                controller: nameController,
              ),
            ),
              ListTile(
              title:new TextFormField(
              decoration: const InputDecoration(
              icon: const Icon(Icons.location_city),
              labelText: 'Unique Number:',
               ),
                controller: uninumberController,
               ),
              ),
              ListTile(
                title:Column(
                  children: <Widget>[
                    new InputDecorator(
                      decoration:  InputDecoration(
                        icon:  Icon(Icons.gps_fixed),
                        labelText: 'Country',
                      ),
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton<String>(
                          value: _country,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _country = newValue;
                            });
                          },
                          items: _countries.map((String value) {
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
              title:DateTimePickerFormField( format: DateFormat("dd/MM/yyyy"),
                  textAlign: TextAlign.start,
                  dateOnly: true,
                  decoration: new InputDecoration(icon: const Icon(Icons.calendar_today),labelText: "Date of Issue"),
                  onChanged: (DateTime newValue) {
                    setState(() {
                      _issuedate=newValue;
                    });
                  }
              ) ,
            ),
            ListTile(
              title:DateTimePickerFormField( format: DateFormat("dd/MM/yyyy"),
                  textAlign: TextAlign.start,
                  dateOnly: true,
                  decoration: new InputDecoration(icon: const Icon(Icons.calendar_today),labelText: "Date of Expiry"),
                  onChanged: (DateTime newValue) {
                    setState(() {
                      _expirydate=newValue;
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
                  Firestore.instance.collection("users").document(_user.uid).collection('documents').document(),
                  {
                    'type':_type,
                    'name': nameController.text,
                    'num':uninumberController.text,
                    'country': _country,
                    'issued':_issuedate,
                    'expiry':_expirydate
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
