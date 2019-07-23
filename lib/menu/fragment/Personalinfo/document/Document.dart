import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:icare/menu/fragment/Personalinfo/document/AlertBox/AddDocumentDetails.dart';
void main()=>runApp(Document());

class Document extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DocumentState();
  }
}
class _DocumentState extends State<Document>
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){ showDialog(context: context,
          builder: (BuildContext context) {
            HapticFeedback.vibrate();
            return AddDocumentDetails();
          }); },child: Icon(Icons.add),),
      backgroundColor:Color.fromRGBO(13, 80, 121 , 1.0),
      body:new Container(
      child: new SingleChildScrollView(
      child:Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
              ),
              child:  ListTile(
                dense: true,
                title:Text('Document',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
              ),
            ),
            SingleChildScrollView(

              child: Column(
                children: <Widget>[
                StreamBuilder(
                stream: Firestore.instance.collection('users').document(snapshot.data.uid).collection('documents').snapshots(),
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
                            title: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        FloatingActionButton(onPressed: null, child: Icon(Icons.remove_red_eye), mini: true, ),
                                        FloatingActionButton(onPressed: (){ Firestore.instance.runTransaction((Transaction myTransaction) async {
                                          await myTransaction.delete(snapshot.data.documents[index].reference);
                                        });}, child: Icon(Icons.delete), mini: true, ),
                                      ],
                                    )
                                  ],
                                ),
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
                                      text: TextSpan(children: <TextSpan>
                                      [
                                        TextSpan(text:"Document Type: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                        TextSpan(text:snapshot.data.documents[index]['type'],style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                      ]
                                      ),
                                    ),
                                    Divider(),
                                    RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(children: <TextSpan>
                                      [
                                        TextSpan(text:"Unique Number: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                        TextSpan(text:snapshot.data.documents[index]['num'],style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                      ]
                                      ),
                                    ),
                                    Divider(),
                                    RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(children: <TextSpan>
                                      [
                                        TextSpan(text:"Country Issued: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                        TextSpan(text:snapshot.data.documents[index]['country'],style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                      ]
                                      ),
                                    ),
                                    Divider(),
                                    RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(children: <TextSpan>
                                      [
                                        TextSpan(text:"Issue Date: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                        TextSpan(text:DateFormat("dd/MM/yyyy").format(snapshot.data.documents[index]['issued']),style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                      ]
                                      ),
                                    ),
                                    Divider(),
                                    RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(children: <TextSpan>
                                      [
                                        TextSpan(text:"Expiry Date: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0)),
                                        TextSpan(text:DateFormat("dd/MM/yyyy").format(snapshot.data.documents[index]['expiry']),style: TextStyle(color: Colors.black,fontSize: 13.0)),
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
