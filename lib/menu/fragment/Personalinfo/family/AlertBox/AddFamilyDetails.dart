import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() => runApp(AddFamilyDetails());
class AddFamilyDetails extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AddFamilyDetailState();
  }
}
class _AddFamilyDetailState extends State<AddFamilyDetails>
{  int _currentIndex = 0;
List<String> _types = <String>['Mother','Father','Brother','Sister','Wife','Husband','Son','Daughter'];
String _type = 'Mother';
DateTime _dobdate=null;
FirebaseUser _user;
final nameController = TextEditingController();
final phoneController = TextEditingController();
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
int _value2=0,_value3=0;
void _setvalue2(int value) => setState(() => _value2 = value);
void _setvalue3(int value) => setState(() => _value3 = value);
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
            Text('Add Family Member',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white),textAlign: TextAlign.center, ),
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
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          labelText: 'Relationship Type:',
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
              labelText: 'Name:',
               ),
                controller: nameController,
               ),
              ),
                ListTile(
                  leading: Icon(Icons.person),
                  title:new Row(
                    children: <Widget>[
                      RichText(text: TextSpan(text:"Male:",style: TextStyle(color: Colors.black))),
                      Radio(value: 0, groupValue: _value2, onChanged: _setvalue2),
                      RichText(text: TextSpan(text:"Female:",style: TextStyle(color: Colors.black))),
                      Radio(value: 1, groupValue: _value2, onChanged: _setvalue2),
                    ],
                  ),
                ),
                ListTile(
                  title:DateTimePickerFormField( format: DateFormat("dd/MM/yyyy"),
                      textAlign: TextAlign.start,
                      dateOnly: true,
                      decoration: new InputDecoration(icon: const Icon(Icons.calendar_today),labelText: "Date of Birth"),
                      onChanged: (DateTime newValue) {
                       setState(() {
                         _dobdate=newValue;
                       });
                      }
                  ) ,
                ),
                ListTile(
                  leading: RichText(text: TextSpan(text:"Dependent:",style: TextStyle(color: Colors.black))),
                  title:new Row(
                    children: <Widget>[
                      RichText(text: TextSpan(text:"Yes:",style: TextStyle(color: Colors.black))),
                      Radio(value: 0, groupValue: _value3, onChanged: _setvalue3),
                      RichText(text: TextSpan(text:"No:",style: TextStyle(color: Colors.black))),
                      Radio(value: 1, groupValue: _value3, onChanged: _setvalue3),
                    ],
                  ),
                ),
                ListTile(
                  title:new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      labelText: 'Phone No:',
                    ),
                    controller: phoneController,
                  ),
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
            String gen=null;
            String dep=null;
            if (_dobdate!=null) {
              if(_value2==0)
                gen="Male";
              else
                gen="Female";
              if(_value3==0)
                dep="Yes";
              else
                dep="No";
             Firestore.instance.runTransaction((transaction) async {
               await transaction.set(
                   Firestore.instance.collection("users").document(_user.uid).collection('family').document(),
                   {
                       'type': _type,
                       'name': nameController.text,
                       'gender':gen,
                       'dob': _dobdate,
                       'depend':dep,
                       'phone':phoneController.text
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
