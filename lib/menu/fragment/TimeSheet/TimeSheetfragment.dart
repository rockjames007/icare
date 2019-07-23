import 'package:flutter/material.dart';

main() => runApp(TimeSheet());
class TimeSheet extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _TimeSheetState();
  }
}
class _TimeSheetState extends State<TimeSheet>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCarouselItem()
    );
  }
var item;
  List<String> _tasks = <String>[' General -- Common Team Meeting -- Meeting/Discussions ',
  '',
  'General -- Common Team Meeting -- Meeting/Discussions',
  'General -- Leave -- Leave',
  'General -- Self Learning -- Self Learning',
  'General -- Training -- Training',
  'General -- Pre Sales -- Presale Review Meetings/Documentation',
  'General -- Pre Sales -- Demo Preparation & Presentation',
  'General -- Pre Sales -- Time spent in xFact Office',
  'General -- NA -- NA',
  'MCO-ERP-DEV-01 -- Planning -- R&D on Std Ofbiz Processes',
  'MCO-ERP-DEV-01 -- Planning -- Documentation ',
  'MCO-ERP-DEV-01 -- Planning -- Process Workshop / Review',
  'MCO-ERP-DEV-01 -- Planning -- Internal Review Meetings',
  'MCO-ERP-DEV-01 -- Project Management -- Internal Review Meetings',
  'MCO-ERP-DEV-01 -- Project Management -- Customer Meetings/Discussions',
  'MCO-ERP-DEV-01 -- OOS - Upgrade -- Upgrade Tasks',
  'MCO-ERP-DEV-01 -- OOS - Upgrade -- Review / Documentation',
  'MCO-ERP-DEV-01 -- Development & Testing -- Development',
  'MCO-ERP-DEV-01 -- Development & Testing -- Functional Testing',
  'MCO-ERP-DEV-01 -- Development & Testing -- Status Reports',
  'MCO-ERP-DEV-01 -- Development & Testing -- Ecommerce external Link',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->External Site-->Order Confirmation',
  'MCO-ERP-DEV-01 -- Development & Testing -- E Commerce-->Internal Site',
  'MCO-ERP-DEV-01 -- Development & Testing -- External E commerce Website ',
  'MCO-ERP-DEV-01 -- Development & Testing -- External E commerce Website -> Add To Cart ',
  'MCO-ERP-DEV-01 -- Development & Testing -- go to url->homepage->home category',
  'MCO-ERP-DEV-01 -- Development & Testing -- Party > Update Contact Information',
  'MCO-ERP-DEV-01 -- Development & Testing -- Promos',
  'MCO-ERP-DEV-01 -- Development & Testing -- Wishlist '
  ];
  String _task='';
  int pos=9;
  Widget _buildCarouselItem() {
    return Container(
      color: Colors.blue,
        child:
      PageView.builder(
        // store this controller in a State to save the carousel scroll position
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        controller: PageController(initialPage: pos),
        itemBuilder: (BuildContext context, int itemIndex) {

        return _buildCarousel(itemIndex);
        },
      ),
    );
  }
  Widget _buildCarousel(int pos) {
    return Column
      (
    children: <Widget> [
    Card(
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child:ListTile(
          title:RichText(textAlign: TextAlign.center,text: TextSpan(
              children: <TextSpan>[TextSpan(text: '14'),TextSpan(text: '-'),TextSpan(text: '21')]
          )) ,
        )
      ),
    ),
    ListTile(title:Row(children: <Widget>[RaisedButton(onPressed: null,color: Colors.white,)]),),

    Container(
        color: Color.fromRGBO(224, 251, 253, 1.0),
        child:
       ListTile(
         title: Column(
              children: <Widget>[
                InputDecorator(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.receipt),
                    labelText: 'Task Name',
                  ),
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      value: _task,
                      isDense: true,
                      isExpanded: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _task = newValue;
                        });
                      },
                      items: _tasks.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new RichText(text: TextSpan(text: value,style: TextStyle(fontSize: 12.0,color: Colors.black)),),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
        ),
        ),
       ),
       ]
    );
  }
}