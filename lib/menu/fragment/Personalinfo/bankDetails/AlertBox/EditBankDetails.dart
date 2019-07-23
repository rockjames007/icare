import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditBankDetails extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _EditBankDetailState();
  }
}
class _EditBankDetailState extends State<EditBankDetails>
{
FirebaseUser _user;
final nameController = TextEditingController();
final bankController = TextEditingController();
final accountController = TextEditingController();
final ifsController = TextEditingController();
@override
void dispose() {
  // Clean up the controller when the Widget is disposed
  nameController.dispose();
  bankController.dispose();
  accountController.dispose();
  ifsController.dispose();
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
            Text('Add Family Member',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white),textAlign: TextAlign.center, ),
          ] ),
    ),
    contentPadding:EdgeInsets.all(0.0),
    content: SingleChildScrollView(
      child:StreamBuilder(
      stream: Firestore.instance.collection('users').document(snapshot.data.uid).collection('bankdetails').document('accountinfo').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return new CircularProgressIndicator();
        else {
          var userDocument = snapshot.data;

          nameController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: userDocument['name'])).value;
          bankController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: userDocument['bank name'])).value;
          accountController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: userDocument['acc no'])).value;
          ifsController.value = new TextEditingController.fromValue(
              new TextEditingValue(text: userDocument['ifsc'])).value;
          return Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_city),
                      labelText: 'Name On Account:',
                    ),
                    controller: nameController,
                  ),
                ),
                ListTile(
                  title: new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_city),
                      labelText: 'Bank Name:',
                    ),
                    controller: bankController,
                  ),
                ),
                ListTile(
                  title: new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_city),
                      labelText: 'Account Number:',
                    ),
                    controller: accountController,
                  ),
                ),
                ListTile(
                  title: new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_city),
                      labelText: 'IFS Code:',
                    ),
                    controller: ifsController,
                  ),
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
            updateData(snapshot.data.uid, "name", nameController.text);
            updateData(snapshot.data.uid, "bank name", bankController.text);
            updateData(snapshot.data.uid, "acc no", accountController.text);
            updateData(snapshot.data.uid, "ifsc", ifsController.text);
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
updateData(selectedDoc,field,newValues) {
  Firestore.instance
      .collection('users')
      .document(selectedDoc.toString())
      .collection('bankdetails')
      .document('accountinfo')
      .updateData({field: newValues})
      .catchError((e) {
    print(e);
  });
}

}
