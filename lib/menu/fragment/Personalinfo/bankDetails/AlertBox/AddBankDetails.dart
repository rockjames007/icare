import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddBankDetails extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AddBankDetailState();
  }
}
class _AddBankDetailState extends State<AddBankDetails>
{
FirebaseUser _user;
final nameController = TextEditingController();
final bankController = TextEditingController();
final accountController = TextEditingController();
final ifsController = TextEditingController();
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
              title:new TextFormField(
              decoration: const InputDecoration(
              icon: const Icon(Icons.location_city),
              labelText: 'Name On Account:',
               ),
                controller: nameController,
               ),
              ),
              ListTile(
                title:new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.location_city),
                    labelText: 'Bank Name:',
                  ),
                  controller: bankController,
                ),
              ),
              ListTile(
                title:new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.location_city),
                    labelText: 'Account Number:',
                  ),
                  controller: accountController,
                ),
              ),
              ListTile(
                title:new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.location_city),
                    labelText: 'IFS Code:',
                  ),
                  controller: ifsController,
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
            Firestore.instance.runTransaction((transaction) async {
              await transaction.set(
                  Firestore.instance.collection("users").document(_user.uid).collection('bankdetails').document('accountinfo'),
                  {

                    'name': nameController.text,
                    'acc no':accountController.text,
                    'bank name': bankController.text,
                    'ifsc':ifsController.text
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
