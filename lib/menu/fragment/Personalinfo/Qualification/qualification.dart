import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:icare/menu/fragment/Personalinfo/Qualification/AlertBox/AddQualificationDetails.dart';
import 'package:icare/menu/fragment/Personalinfo/Qualification/AlertBox/EditQualificationDetails.dart';
void main()=>runApp(Qualification());

class Qualification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QualiState();
  }
}
class _QualiState extends State<Qualification>
{
  bool _load=false;
  FirebaseUser _user;
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
    return FutureBuilder(
    future: FirebaseAuth.instance.currentUser(),
    builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
    if (snapshot.hasData) {
         return Scaffold(
            floatingActionButton:FloatingActionButton(onPressed:(){ showDialog(context: context,
            builder: (BuildContext context) {
            HapticFeedback.vibrate();
            return AddQualificationDetails();
            }); },child: Icon(Icons.add),),
                 backgroundColor:Color.fromRGBO(13, 80, 121 , 1.0),
                 body:new Container(
                   child:new SingleChildScrollView(
                     child:Column(
                       children: <Widget>[
                         Container(
                         decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          ),
                           child: ListTile(
                           dense: true,
                           title:Text('Qualification',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                          ),
                         ),
                         SingleChildScrollView(
                         child: Column(
                          children: <Widget>[
                            StreamBuilder(
                           stream: Firestore.instance.collection('users').document(snapshot.data.uid).collection('qualification').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return new CircularProgressIndicator();
                            else {
                              return Container(
                               child:ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, int index) {
                                return Card(
                                child: Container(
                                  color: Colors.blue.shade100.withOpacity(0.3),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1.0),
                                                      ),
                                                      child: RichText(
                                                        textAlign: TextAlign
                                                            .center,
                                                        text: TextSpan(
                                                            text: (index+1).toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 25.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    FloatingActionButton(onPressed:(){showDialog(context:context,builder:(BuildContext context){HapticFeedback.vibrate();return EditQualificationDetails(snapshot.data.documents[index].reference);});}, child: Icon(Icons.edit), mini: true, ),
                                                    FloatingActionButton(onPressed:(){
                                                      Firestore.instance.runTransaction((Transaction myTransaction) async {
                                                        await myTransaction.delete(snapshot.data.documents[index].reference);
                                                      });
                                                    },
                                                      child: Icon(Icons.delete),
                                                      mini: true, ),
                                                    FloatingActionButton(
                                                      onPressed: null,
                                                      child: Icon(
                                                          Icons.remove_red_eye),
                                                      mini: true,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          color: Color.fromRGBO(
                                              224, 251, 253, 1.0),
                                          child: ListTile(
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>
                                                      [
                                                        TextSpan(
                                                            text: "Qualification Type: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 13.0)),
                                                        TextSpan(
                                                            text: snapshot.data.documents[index]['type'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                                Divider(),
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>
                                                      [
                                                        TextSpan(
                                                            text: "Institution/Organization: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 13.0)),
                                                        TextSpan(
                                                            text: snapshot.data.documents[index]['inst'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                                Divider(),
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>
                                                      [
                                                        TextSpan(
                                                            text: "Qualification/Designation: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 13.0)),
                                                        TextSpan(
                                                            text: snapshot.data.documents[index]['qual'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                                Divider(),
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "From Date: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 13.0)),
                                                        TextSpan(
                                                            text: DateFormat("dd/MM/yyyy").format(snapshot.data.documents[index]['fromd']),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                                Divider(),
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "Thru Date: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 13.0)),
                                                        TextSpan(
                                                            text: DateFormat("dd/MM/yyyy").format(snapshot.data.documents[index]['thrud']),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                                Divider(),
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "Status: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 13.0)),
                                                        TextSpan(
                                                            text: snapshot.data.documents[index]['status'].toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              );
                                }
                            ),
                              );
                          }
                          }
                            )
                          ],
                         ),
                         )
                       ],
                     ),
                   ),
                 ),
         );
          }
          else
            {
              return CircularProgressIndicator();
            }
        }
        );
  }
}
