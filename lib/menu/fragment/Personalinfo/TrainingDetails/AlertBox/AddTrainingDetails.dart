import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() => runApp(AddTrainingDetails());
class AddTrainingDetails extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AddTrainingDetailsState();
  }
}
class _AddTrainingDetailsState extends State<AddTrainingDetails>
{  int _currentIndex = 0;
List<String> _trainings = <String>['Certification','Training','Training come Certification'];
String _training = 'Certification';
DateTime _fromdate=null;
DateTime _thrudate=null;
FirebaseUser _user;
final nameController = TextEditingController();
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
            Text('Add Training Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white),textAlign: TextAlign.center, ),
          ] ),
    ),
    contentPadding:EdgeInsets.all(0.0),
    content: SingleChildScrollView(
      child:
      new Container(
        height: 275.0,
        child: Column(
          children: <Widget>[
                ListTile(
                  title:Column(
                    children: <Widget>[
                      new InputDecorator(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.receipt),
                          labelText: 'Training Type',
                        ),
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: _training,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _training = newValue;
                              });
                            },
                            items: _trainings.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value,style: TextStyle(fontSize: 15.0),),
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
              labelText: 'Training Description:',
               ),
                controller: nameController,
               ),
              ),
                ListTile(
                  title:DateTimePickerFormField( format: DateFormat("dd/MM/yyyy"),
                      textAlign: TextAlign.start,
                      dateOnly: true,
                      decoration: new InputDecoration(icon: const Icon(Icons.calendar_today),labelText: "From Date"),
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
                      decoration: new InputDecoration(icon: const Icon(Icons.calendar_view_day),labelText: "Thru Date"),
                      onChanged: (DateTime newValue) {
                        setState(() {
                          _thrudate=newValue;
                        });
                      }
                  ) ,
                )
          ],
        ),
      ),
    ),

    actions: <Widget>[
      // usually buttons at the bottom of the dialog
      new FlatButton(
          child: new Text("Save"),
          onPressed: () {
            if (_fromdate!=null &&_thrudate!=null) {
             Firestore.instance.runTransaction((transaction) async {
               await transaction.set(
                   Firestore.instance.collection("users").document(_user.uid).collection('training').document(),
                   {
                       'type': _training,
                       'name': nameController.text,
                       'fromd': _fromdate,
                       'thrud':_thrudate
                   });
             }
             );
            }
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
