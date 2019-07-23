import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditQualificationDetails extends StatefulWidget {
  DocumentReference refer;
  EditQualificationDetails(ref)
  {refer=ref;
  }
  State<StatefulWidget> createState() {
    return _EditQualificationDetailState(refer);
  }
}
class _EditQualificationDetailState extends State<EditQualificationDetails>
{  DocumentReference refer;
_EditQualificationDetailState(ref)
{refer=ref;
}
String _type='PAN Card';
int state=0;
DateTime _expirydate=null;
final instController = TextEditingController();
final qualController = TextEditingController();
FirebaseUser _user;
int _state=0;
@override
void dispose() {
  // Clean up the controller when the Widget is disposed
  instController.dispose();
  qualController.dispose();
  super.dispose();
}
@override
Widget build(BuildContext context) {
  return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
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
                    Text('Edit Qualification',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white),textAlign: TextAlign.center, ),
                  ] ),
            ),
            contentPadding:EdgeInsets.all(0.0),
            content: SingleChildScrollView(
                child:StreamBuilder(
                    stream: refer.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicator();
                      else {
                        var userDocument = snapshot.data;
                        if(_state!=1) {
                          _expirydate = userDocument['thrud'];
                          _state = 1;
                        }
                        instController.value = new TextEditingController.fromValue(
                            new TextEditingValue(text: userDocument['inst'])).value;
                      qualController.value = new TextEditingController.fromValue(
                            new TextEditingValue(text: userDocument['qual'])).value;
                        return Container(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title:new TextFormField(
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.location_city),
                                    labelText: 'Institution/Organization:',
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
                                    initialValue: _expirydate,
                                    decoration: new InputDecoration(icon: const Icon(Icons.calendar_today),labelText: "Thru Date:"),
                                    onChanged: (DateTime newValue) {
                                      setState(() {
                                        _expirydate=newValue;
                                      });
                                    }
                                ) ,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                )
            ),

            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                  child: new Text("Save"),
                  onPressed: () {
                    updateData(refer, "inst", instController.text);
                    updateData(refer, "qual", qualController.text);
                    updateData(refer, "thrud", _expirydate);
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
        else
          return CircularProgressIndicator();
      }

  );
}
updateData(refer,field,newValues) {
  DocumentReference refere=refer;
  refere.updateData({field: newValues})
      .catchError((e) {
    print(e);
  });
}

}
