import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(EditSecondaryContactDetails());
class EditSecondaryContactDetails extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _EditSecondaryContactDetailsState();
  }
}
class StatesIn {
  StatesIn(this.name,this.id);
  String name;
  String id;
}
class _EditSecondaryContactDetailsState extends State<EditSecondaryContactDetails>
{
  StatesIn selectst;
  List<String> _countries = <String>['India','USA'];
  List<StatesIn> _states = <StatesIn>[
    StatesIn('ANDAMAN AND NICOBAR','AN'),
    StatesIn('ANDHRA PRADESH','AP'),
    StatesIn('ARUNACHAL PRADESH','AR'),
    StatesIn('BIHAR','BH'),
    StatesIn('CHANDIGARH','CH'),
    StatesIn('CHHATTISGARH','CT'),
    StatesIn('DADRA AND NAGER HAVELI','DH'),
    StatesIn('DAMAN AND DIU','DD'),
    StatesIn('GUJARAT','GJ'),
    StatesIn('HARYANA','HR'),
    StatesIn('HIMACHAL PRADESH','HP'),
    StatesIn('JAMMU AND KASHMIR','JK'),
    StatesIn('KARNATAKA','KA'),
    StatesIn('KERALA','KL'),
    StatesIn('LAKSHADWEEP','LW'),
    StatesIn('MADHYA PRADESH','MH'),
    StatesIn('MANIPUR','MR'),
    StatesIn('MEGHALAYA','MG'),
    StatesIn('MIZORAM','MZ'),
    StatesIn('NAGALAND','NG'),
    StatesIn('NEW DELHI','DL'),
    StatesIn('ORISSA','OR'),
    StatesIn('PONDICHERRY','PY'),
    StatesIn('PUNJAB','PJ'),
    StatesIn('RAJASTHAN','RJ'),
    StatesIn('SIKKIM','SK'),
    StatesIn('TAMILNADU','TN'),
    StatesIn('TRIPURA','TR'),
    StatesIn('UTTARANCHAL','UT'),
    StatesIn('UTTAR PRADESH','UP'),
    StatesIn('WEST BENGAL','WB'),
  ];
  String _country = 'India';
  int state=0;
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    addressController.dispose();
    cityController.dispose();
    postController.dispose();
    contactController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    selectst=_states[0];
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
                  color: Color.fromRGBO(13, 80, 121, 1.0),
                ),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Update Secondary Contact ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white),textAlign: TextAlign.center, ),
                      Icon(Icons.edit,color: Colors.white,)
                    ] ),
              ),
              contentPadding:EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child:StreamBuilder(
                    stream: Firestore.instance.collection('users').document(snapshot.data.uid).collection('myprofile').document('secondarycontact').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return new CircularProgressIndicator();
                      else {
                        var userDocument = snapshot.data;
                        StatesIn sa;
                        addressController.value=new TextEditingController.fromValue(new TextEditingValue(text: userDocument['add'])).value;
                        cityController.value=new TextEditingController.fromValue(new TextEditingValue(text: userDocument['city'])).value;
                        postController.value=new TextEditingController.fromValue(new TextEditingValue(text: userDocument['postal'])).value;
                        contactController.value=new TextEditingController.fromValue(new TextEditingValue(text: userDocument['contact'])).value;
                        emailController.value=new TextEditingController.fromValue(new TextEditingValue(text: userDocument['emailid'])).value;
                        if(state==0) {
                          selectst=_states[_states.indexWhere((_states)=>_states.id.contains(userDocument['state']))];
                          _country=userDocument['country'];
                        }
                        print(selectst.name);
                        return Container(
                          height: 480.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  color: Colors.white,
                                  child:Column(
                                    children: <Widget>[
                                      ListTile(
                                        title:new TextFormField(
                                          controller: addressController,
                                          decoration:  InputDecoration(
                                            icon:  Icon(Icons.location_on),
                                            labelText: 'Address',
                                          ),
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
                                                      state=1;
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
                                        title:Column(
                                          children: <Widget>[
                                            new InputDecorator(
                                              decoration:  InputDecoration(
                                                icon:  Icon(Icons.gps_not_fixed),
                                                labelText: 'State',
                                              ),
                                              child: new DropdownButtonHideUnderline(
                                                child: new DropdownButton<StatesIn>(
                                                  value: selectst,
                                                  isDense: true,
                                                  onChanged: (StatesIn newValue) {
                                                    setState(() {
                                                      selectst = newValue;
                                                      state=1;
                                                    });
                                                  },
                                                  items: _states.map((StatesIn st) {
                                                    return new DropdownMenuItem<StatesIn>(
                                                      value: st,
                                                      child: new Text(st.name,style: TextStyle(fontSize: 13.0),),
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
                                          controller: cityController,
                                          decoration:  InputDecoration(
                                            icon:  Icon(Icons.location_city),
                                            labelText: 'City',
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title:new TextFormField(
                                          controller: postController,
                                          decoration:  InputDecoration(
                                            icon:  Icon(Icons.markunread_mailbox),
                                            labelText: 'Postal Code',
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title:new TextFormField(
                                          controller: contactController,
                                          decoration:  InputDecoration(
                                            icon:  Icon(Icons.phone),
                                            labelText: 'Contact Number',
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title:new TextFormField(
                                          controller: emailController,
                                          decoration:  InputDecoration(
                                            icon:  Icon(Icons.email),
                                            labelText: 'Email ID',
                                          ),
                                        ),
                                      ),
                                    ],
                                  )

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
                      updateData(snapshot.data.uid, "add", addressController.text);
                      updateData(snapshot.data.uid, "country", _country);
                      updateData(snapshot.data.uid, "state", selectst.id);
                      updateData(snapshot.data.uid, "city", cityController.text);
                      updateData(snapshot.data.uid, "postal", postController.text);
                      updateData(snapshot.data.uid, "contact", contactController.text);
                      updateData(snapshot.data.uid, "emailid", emailController.text);
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
        .document('secondarycontact')
        .updateData({field: newValues})
        .catchError((e) {
      print(e);
    });
  }

}
