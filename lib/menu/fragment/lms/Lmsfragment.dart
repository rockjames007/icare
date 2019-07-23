import 'package:flutter/material.dart';
void main()=>runApp(lms());
class lms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: null,child: Icon(Icons.add),),
        backgroundColor:Color.fromRGBO(13, 80, 121 , 1.0),
        body:new Container(
          child: new SingleChildScrollView(
            child:Column(
              children: <Widget>[

                SingleChildScrollView(

                  child: Column(
                    children: <Widget>[
                      new Card(
                          color: Colors.blue.shade100,
                          child: new Column(
                              children: <Widget>[
                                 ListTile(
                                   title:Text('Balance',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                                   dense: true,
                                 ),
                                Card(
                                  color: Color.fromRGBO(224, 251, 253, 1.0),
                                  child:
                                Table(
                                    border: TableBorder.all(width: 1.0,color: Color.fromRGBO(13, 80, 121 , 0.7)),
                                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                    children:<TableRow>[
                                      TableRow(
                                        children: <Widget>[
                                          Text(' '),
                                          Text('Opening Balance',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          Text('Leave Accrued',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          Text('Leave Taken',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          Text('Leave Applied',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          Text('Closing Balance',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          Text('Earned Leave',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          Text('2',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                          Text('10.5',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                          Text('2',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                          Text('0.0',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                          Text('10.5',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          Text('Sick Leave',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          Text('6',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                          Text('0',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                          Text('1',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                          Text('0.0',style: TextStyle(fontSize:13.0),textAlign: TextAlign.center,),
                                          Text('5',style: TextStyle(fontSize: 13.0),textAlign: TextAlign.center,),
                                        ],
                                      ),
                                    ]
                                ),
                                ),

                              ]
                          )
                      ),
                      Card(
                        color: Colors.blue.shade100,
                        child:new Column(
                          children: <Widget>[
                            ListTile(
                              title:Text('Waiting For Approval',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                              dense: true,
                            ),
                            Card(
                                color: Color.fromRGBO(224, 251, 253, 1.0),
                            child:ListTile(
                              dense: true,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                    RichText(text: TextSpan(
                                      children:<TextSpan>[
                                        TextSpan(text: "Leave Type: ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 13.0)),
                                        TextSpan(text: "Earned Leave",style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                      ]
                                    )),
                                  Divider(),
                                    RichText(text: TextSpan(
                                        children:<TextSpan>[
                                          TextSpan(text: "Reporting Manager: ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 13.0)),
                                          TextSpan(text: "Sundararajan Aravamudhan",style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                        ]
                                    )),
                                    Divider(),
                                    RichText(text: TextSpan(
                                        children:<TextSpan>[
                                          TextSpan(text: "Duration: ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 13.0)),
                                          TextSpan(text: "22/10/2018",style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                          TextSpan(text: "-",style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                          TextSpan(text: " 22/10/2018",style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                          TextSpan(text: "(1)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 13.0)),
                                        ]
                                    )),
                                    Divider(),
                                    RichText(text: TextSpan(
                                        children:<TextSpan>[
                                          TextSpan(text: "Reason: ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 13.0)),
                                          TextSpan(text: "Going For vacation",style: TextStyle(color: Colors.black,fontSize: 13.0)),
                                        ]
                                    )),
                              ],
                             ),
                            )
                            )
                           ],
                        ),
                    ),
               ],
              ),
            ),
               ],
            ),
          ),
        ),
      );
  }
}
