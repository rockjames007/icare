import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
class HydrateTracker extends StatefulWidget {
  @override
  _HydrateTrackerState createState() => _HydrateTrackerState();
}

class _HydrateTrackerState extends State<HydrateTracker> {
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
                'Hydrate'
              ),
              background: Image.asset(
                "assets/hydrate.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
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
