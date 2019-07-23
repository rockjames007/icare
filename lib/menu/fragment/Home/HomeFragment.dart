import 'package:flutter/material.dart';
import 'package:icare/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() => runApp(HomeFragment());

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: new FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
           builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
           if (snapshot.hasData) {
            return SingleChildScrollView(
            child: new Column
            (
              children: <Widget>
              [
                new ConstrainedBox
                  (
                  constraints: new BoxConstraints
                    (
                      maxHeight: MediaQuery.of(context).size.height,
                      maxWidth: double.infinity,
                      minHeight: MediaQuery.of(context).size.height,
                      minWidth: double.infinity
                    ),
                  child: new DecoratedBox(
                    decoration: new BoxDecoration
                      (
                      color: Color.fromRGBO(194, 204, 207, 0.7),
                      border: new Border.all(color: Color.fromRGBO(13, 80, 121, 1.0), width: 5.0),
                      ),
                    child: new Column
                      (
                      children: <Widget>[
                        new Column(
                          children: <Widget>
                          [new Container(
                                color: Color.fromRGBO(13, 80, 121, 0.9),
                                child: new ListTile(
                                    dense: true,
                                    title: Row(children: <Widget>[
                                      Icon(
                                        Icons.dashboard, color: Colors.white,),
                                      Text("Dash Board", style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                    ],
                                    )
                                )
                            ),
                            StreamBuilder(
                            stream: Firestore.instance.collection('users').document(snapshot.data.uid).snapshots(),
                            builder: (context, snapshot) {
                             if (!snapshot.hasData)
                             return new CircularProgressIndicator();
                             else {
                               var userDocument = snapshot.data;
                               return ListTile(
                               title:new InkWell(
                                 onTap:(){Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Menu(1)),
                                   );},
                                child: new Card(
                                  color: Color.fromRGBO(85, 180, 255,1.0),
                                  child: new Column(
                                      children: <Widget>[
                                        ListTile(
                                          dense:true,
                                          title:
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>
                                              [
                                                Icon(Icons.person,size: 40.0,color: Colors.white,),
                                                Text("Logged in as ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                              ]
                                          ),
                                        ),
                                        Card(
                                            color: Colors.white,
                                            child:ListTile(
                                              dense: true,
                                              title: Text("Check My Profile"),
                                            )
                                        ),
                                      ]
                                  ),
                                ),
                              )
                              ,
                            );
                           }
                           }
                            ),
                             new ListTile(
                           title: new InkWell(
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => Menu(2)),);
                             },
                             child: new Card(
                               color: Color.fromRGBO(255, 183, 85, 1.0),
                               child: new Column(
                                   children: <Widget>[
                                     ListTile(
                                       dense: true,
                                       title:
                                       Row(
                                           mainAxisAlignment: MainAxisAlignment
                                               .spaceBetween,
                                           children: <Widget>
                                           [
                                             Icon(
                                               Icons.perm_contact_calendar,
                                               size: 40.0,
                                               color: Colors.white,),
                                             Text("LMS", style: TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.white),),
                                           ]
                                       ),
                                     ),
                                     Card(
                                         color: Colors.white,
                                         child: Table(
                                             border: TableBorder.all(
                                                 width: 1.0,
                                                 color: Color.fromRGBO(
                                                     13, 80, 121, 0.7)),
                                             defaultVerticalAlignment: TableCellVerticalAlignment
                                                 .middle,
                                             children: <TableRow>[
                                               TableRow(
                                                 children: <Widget>[
                                                   Text(' '),
                                                   Text('Opening Balance',
                                                     style: TextStyle(
                                                         fontSize: 10.0,
                                                         fontWeight: FontWeight
                                                             .bold),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('Leave Accrued',
                                                     style: TextStyle(
                                                         fontSize: 10.0,
                                                         fontWeight: FontWeight
                                                             .bold),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('Leave Taken',
                                                     style: TextStyle(
                                                         fontSize: 10.0,
                                                         fontWeight: FontWeight
                                                             .bold),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('Leave Applied',
                                                     style: TextStyle(
                                                         fontSize: 10.0,
                                                         fontWeight: FontWeight
                                                             .bold),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('Closing Balance',
                                                     style: TextStyle(
                                                         fontSize: 10.0,
                                                         fontWeight: FontWeight
                                                             .bold),
                                                     textAlign: TextAlign
                                                         .center,),
                                                 ],
                                               ),
                                               TableRow(
                                                 children: <Widget>[
                                                   Text('Earned Leave',
                                                     style: TextStyle(
                                                         fontSize: 10.0,
                                                         fontWeight: FontWeight
                                                             .bold),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('2',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('10.5',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('2',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('0.0',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('10.5',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                 ],
                                               ),
                                               TableRow(
                                                 children: <Widget>[
                                                   Text('Sick Leave',
                                                     style: TextStyle(
                                                         fontSize: 10.0,
                                                         fontWeight: FontWeight
                                                             .bold),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('6',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('0',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('1',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('0.0',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                   Text('5',
                                                     style: TextStyle(
                                                         fontSize: 15.0),
                                                     textAlign: TextAlign
                                                         .center,),
                                                 ],
                                               ),
                                             ]
                                         )
                                     ),
                                   ]
                               ),
                             ),
                           )

                            ),
                            new ListTile(
                              title: new InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu(3)),
                                  );
                                },
                                child: new Card(
                                  color: Color.fromRGBO(151, 255, 74, 0.5),
                                  child: new Column(
                                      children: <Widget>[
                                        ListTile(
                                          dense: true,
                                          title:
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>
                                              [
                                                Icon(Icons.timeline, size: 40.0,
                                                  color: Colors.white,),
                                                Text("My TimeSheets",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.white),),
                                              ]
                                          ),
                                        ),
                                        Card(
                                            color: Colors.white,
                                            child: ListTile(
                                              dense: true,
                                              title: Text(
                                                  "Review My TimeSheet"),
                                            )
                                        ),
                                      ]
                                  ),
                                ),
                              )
                              ,
                            ),
                            new ListTile(
                              title: new InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu(4)),
                                  );
                                },
                                child: new Card(
                                  color: Color.fromRGBO(255, 126, 126, 1.0),
                                  child: new Column(
                                      children: <Widget>[
                                        ListTile(
                                          dense: true,
                                          title:
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>
                                              [
                                                Icon(Icons.payment, size: 40.0,
                                                  color: Colors.white,),
                                                Text("Pay Statements",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.white),),
                                              ]
                                          ),
                                        ),
                                        Card(
                                            color: Colors.white,
                                            child: ListTile(
                                              dense: true,
                                              title: Text(
                                                  "Check My Monthly Payslip"),
                                            )
                                        ),
                                      ]
                                  ),
                                ),
                              )
                              ,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]
          ),


        );
      }
      else {
        return CircularProgressIndicator();
      }
        }
        )

    );

  }
}
