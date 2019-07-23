import 'package:flutter/material.dart';
import 'package:icare/menu/fragment/Personalinfo/TrainingDetails/AlertBox/AddTrainingDetails.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
void main()=>runApp(TrainingDetailsFragment());

class TrainingDetailsFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrainingDetailsFragmentState();
  }
}
class _TrainingDetailsFragmentState extends State<TrainingDetailsFragment>
{
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
    return new Scaffold(
        floatingActionButton:FloatingActionButton(onPressed:(){showDialog(context: context,builder: (BuildContext context){
          HapticFeedback.vibrate();
          return AddTrainingDetails();
        } );},child: Icon(Icons.add)) ,
        body:new Container(
          color: Color.fromRGBO(13, 80, 121 , 1.0),
          height: MediaQuery.of(context).size.height,
          child:SingleChildScrollView(
           child:new Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                ),
                child:  ListTile(
                  title:Text('Training Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                  dense: true,
                ),
              ),
              StreamBuilder(
                  stream: Firestore.instance.collection('users').document(snapshot.data.uid).collection('training').snapshots(),
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
                                  child:Column(
                                    children: <Widget>[
                                      ListTile(
                                        dense:true,
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                            Container(
                                              height: 30.0,
                                              width: 30.0,
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1.0),
                                              ),
                                              child:RichText(
                                                textAlign: TextAlign.center,
                                                text:TextSpan(text:(index+1).toString(),style: TextStyle(color: Colors.black,fontSize:25.0 )),
                                              ),
                                            ),
                                                FloatingActionButton(
                                                  onPressed:() {
                                                    Firestore.instance.runTransaction((Transaction myTransaction) async {
                                                      await myTransaction.delete(snapshot.data.documents[index].reference);
                                                    });
                                                    } ,
                                                  child: Icon(Icons.delete), mini: true, ),
                                            ]
                                            )
                                          ],
                                        ),

                                      ),
                                      Container(
                                          color: Color.fromRGBO(224, 251, 253, 1.0),
                                          child:
                                          ListTile(
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children:<TextSpan>[TextSpan(text:"Training Type:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                                      TextSpan(text:snapshot.data.documents[index]['type'],style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                                Divider(),
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children:<TextSpan>[TextSpan(text:"Training description: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                                      TextSpan(text:snapshot.data.documents[index]['name'],style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                                Divider(),
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children:<TextSpan>[TextSpan(text:"From Date: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                                      TextSpan(text:DateFormat("dd/MM/yyyy").format(snapshot.data.documents[index]['fromd']),style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                                      ]
                                                  ),
                                                ),
                                                Divider(),
                                                RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children:<TextSpan>[TextSpan(text:"Thru Date: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                                      TextSpan(text:DateFormat("dd/MM/yyyy").format(snapshot.data.documents[index]['thrud']),style: TextStyle(color: Colors.black,fontSize: 13.0)),
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
        )

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
