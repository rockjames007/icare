import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
class MedicalTracker extends StatefulWidget {
  @override
  _MedicalTrackerState createState() => _MedicalTrackerState();
}

class _MedicalTrackerState extends State<MedicalTracker> {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 236, 247, 1.0),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Medical',
                style: TextStyle(color: Colors.black),
              ),
              background: Image.asset(
                "assets/medical.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 660,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage("https://livelovefruit.com/wp-content/uploads/2017/10/JuiceCures.png"),fit: BoxFit.fill)
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
