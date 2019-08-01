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
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 100.0,
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
                  color: Colors.blueGrey,
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
                ),
                Card(
                  child: ListTile(
                    title: Text("Wake up Time"),
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
                ),

                ),
                Container(
                  height: 550.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("https://thumbnails-visually.netdna-ssl.com/10-tips-for-better-sleep_51f6d5c81a107_w1500.jpg"),fit: BoxFit.fill)
                  ),
                )],
            ),
          ))
        ],
      ),
    );
  }
}
