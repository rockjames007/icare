import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HydrateTracker extends StatefulWidget {
  @override
  _HydrateTrackerState createState() => _HydrateTrackerState();
}

class _HydrateTrackerState extends State<HydrateTracker> {
  SharedPreferences _prefs;
  String waterRequire;
  @override
  void initState() {
    super.initState();
    getUserDataSharedPreference();
  }

  void getUserDataSharedPreference() async {
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => _prefs = prefs);
        if (_prefs.get("gender") == "Male")
          waterRequire = (double.parse(_prefs.get("weight"))/30.0)
              .toStringAsFixed(2);
        else
          waterRequire = (double.parse(_prefs.get("weight"))/30.0)
              .toStringAsFixed(2);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.lightBlueAccent,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 100.0,
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
                      color:Colors.white,
                      child: Table(
                        border: TableBorder.all(width: 1.0, color: Colors.black),
                        children: [
                          TableRow(children: [
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: RichText(
                                  text: TextSpan(
                                      text: "Litres of Water needed to drink per day",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  textAlign: TextAlign.center,
                                )),
                            TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: RichText(
                                  text: TextSpan(
                                      text: waterRequire +" litre",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  textAlign: TextAlign.center,
                                )),
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      height: 650.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage("https://i.pinimg.com/originals/ae/28/51/ae2851bf3fc4d8fda78c28307a530a2d.png"),fit: BoxFit.fill)
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
