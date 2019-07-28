import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
class SleepTracker extends StatefulWidget {
  @override
  _SleepTrackerState createState() => _SleepTrackerState();
}

class _SleepTrackerState extends State<SleepTracker> {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 236, 247, 1.0),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Sleep',
                style: TextStyle(color: Colors.black),
              ),
              background: Image.asset(
                "assets/sleepcat.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          SliverFillRemaining(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  color: Color.fromRGBO(178, 235, 242, 1.0),
                  child: ListTile(
                    title: Text("Bed Time"),
                    subtitle: Text(
                      "0:18 min", style: TextStyle(fontSize: 20.0),),
                  ),
                ),
                Card(
                  color: Color.fromRGBO(178, 235, 242, 1.0),
                  child: ListTile(
                    title: Text("Sleep Time"),
                    subtitle: DateTimeField(
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.convert(time);
                      },
                    ),
                )
                )],
            ),
          ))
        ],
      ),
    );
  }
}
