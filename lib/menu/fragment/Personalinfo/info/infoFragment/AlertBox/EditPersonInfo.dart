import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(EditPersonInfo());
class EditPersonInfo extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _EditPersonInfoState();
  }
}
class _EditPersonInfoState extends State<EditPersonInfo>
{  int _currentIndex = 0;
@override
List<String> _bloods = <String>['','O +ve', 'O -ve', 'A1B +ve', 'A1B -ve', 'A2 +ve','A2 -ve','A1 +ve','A1 -ve','A +ve','A -ve','A2B +ve','A2B -ve','B +ve','B -ve','B1 +ve','AB +ve','AB -ve'];
List<String> _maritals = <String>['','Single', 'Married', 'Separated', 'Divorced', 'Widowed'];

String _marital = '';
String _blood = '';
DateTime date;
DateTime time;
int state=0;
final nameController = TextEditingController();

@override
void dispose() {
  // Clean up the controller when the Widget is disposed
  nameController.dispose();
  super.dispose();
}
Widget build(BuildContext context) {

  return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          return AlertDialog(
            titlePadding: EdgeInsets.all(0.0),
            title: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(13, 80, 121, 1.0),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Edit Personal Info ', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 21.0,color: Colors.white),
                      textAlign: TextAlign.center,),
                    Icon(Icons.edit,color: Colors.white,)
                  ]),
            ),
            contentPadding: EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child:
              StreamBuilder(
                  stream: Firestore.instance.collection('users').document(snapshot.data.uid).collection('myprofile').document('personalinfo').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return new CircularProgressIndicator();
                    else {
                      var userDocument = snapshot.data;
                      if(state==0) {
                        _blood = userDocument['blood'];
                        _marital=userDocument['marital'];
                        date=userDocument['dob'];
                      }
                      nameController.value=new TextEditingController.fromValue(new TextEditingValue(text: userDocument['mothername'])).value;
                      return Container(
                        height: 280.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                                color: Colors.white,
                                child:Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: DateTimePickerFormField(
                                        format: DateFormat("dd/MM/yyyy"),
                                        textAlign: TextAlign.start,
                                        dateOnly: true,
                                        editable: true,
                                        decoration: new InputDecoration(
                                            icon: const Icon(Icons.cake),
                                            labelText: "Date of Birth"),
                                        initialValue: date,
                                        onChanged:(DateTime newValue) {
                                          setState(() {
                                            date = newValue;
                                            state=1;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: Column(
                                        children: <Widget>[
                                          new InputDecorator(
                                            decoration: const InputDecoration(
                                              icon: const Icon(Icons.opacity),
                                              labelText: 'Blood Group',
                                            ),
                                            child: new DropdownButtonHideUnderline(
                                              child: new DropdownButton<String>(
                                                value:_blood,
                                                isDense: true,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    _blood = newValue;
                                                    state=1;
                                                  });
                                                },
                                                items: _bloods.map((String value) {
                                                  return new DropdownMenuItem<String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      title: new TextFormField(
                                        decoration: const InputDecoration(
                                          icon: const Icon(Icons.person),
                                          labelText: 'Mother\'s name',
                                        ),
                                        controller: nameController,
                                      ),
                                    ),
                                    ListTile(
                                      title: Column(
                                        children: <Widget>[
                                          new InputDecorator(
                                            decoration: const InputDecoration(
                                              icon: const Icon(Icons.favorite),
                                              labelText: 'Marital Status',
                                            ),
                                            child: new DropdownButtonHideUnderline(
                                              child: new DropdownButton<String>(
                                                value: _marital,
                                                isDense: true,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    _marital = newValue;
                                                    state=1;
                                                  });
                                                },
                                                items: _maritals.map((String value) {
                                                  return new DropdownMenuItem<String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                            ),
                          ],
                        ),
                      );
                    }
                  }
              ),

            ),

            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Save"),
                onPressed: () {
                  if (date != null) {
                    updateData(snapshot.data.uid, "dob", date);
                    updateData(snapshot.data.uid, "blood", _blood);
                    updateData(
                        snapshot.data.uid, "mothername", nameController.text);
                    updateData(snapshot.data.uid, "marital", _marital);
                    Navigator.of(context).pop();
                  }
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
        else
        {
          return CircularProgressIndicator();
        }
      }
  );
}
updateData(selectedDoc,field,newValues) {
  Firestore.instance
      .collection('users')
      .document(selectedDoc.toString())
      .collection('myprofile')
      .document('personalinfo')
      .updateData({field: newValues})
      .catchError((e) {
    print(e);
  });
}

}