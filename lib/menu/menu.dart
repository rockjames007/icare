import 'package:flutter/material.dart';
import 'package:icare/menu/sleep/sleepTracker.dart';
import 'package:icare/menu/medical/medicalTracker.dart';
import 'package:icare/menu/hydrate/hydrateTracker.dart';
import 'package:icare/menu/healthtips/healthTipsInfo.dart';
import 'package:icare/menu/fun/funActivity.dart';
import 'package:icare/menu/calorie/calorieIntake.dart';
import 'package:icare/menu/personalInfo.dart';

class Menu extends StatefulWidget {
  State<StatefulWidget> createState() => _MenuPageState();
}

int _currentIndex =0;

class _MenuPageState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    int count;
    if (MediaQuery.of(context).orientation == Orientation.landscape)
      count = 3;
    else
      count = 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: new SingleChildScrollView(
          child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(1.5),
        crossAxisCount: count,
        childAspectRatio: 0.80,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: cardList(),
        //new Cards()
        shrinkWrap: true,
      )),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // new
          onTap: onTabTapped,
          // new
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: new Text(
                'Setting',
                textScaleFactor: 0.5,
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.notifications),
              title: new Text(
                'Notification',
                textScaleFactor: 0.5,
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text(
                  'Personal Info',
                  textScaleFactor: 0.5,
                ),
            ) //it
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if(_currentIndex==2)
      Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfo()));
    });
  }

  Widget cardBuilder(Color color, String label, IconData icon,_menuItem) {
    return InkWell(
      child: Card(
        color: color,
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(icon), Text(label)],
            )),
      ),
      onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context) => _menuItem));},
    );
  }
  final _cardItemList = [
    CardItem(
        "Sleep", Icons.airline_seat_flat, Color.fromRGBO(244, 236, 247, 1.0)),
    CardItem("Hydrate", Icons.opacity, Color.fromRGBO(249, 235, 234, 1.0)),
    CardItem("Medical", Icons.favorite, Color.fromRGBO(253, 237, 236, 1.0)),
    CardItem(
        "Calorie Intake", Icons.fastfood, Color.fromRGBO(163, 228, 215, 1.0)),
    CardItem("Health Tips", Icons.check, Color.fromRGBO(178, 235, 242, 1.0)),
    CardItem("Fun", Icons.mood, Color.fromRGBO(218, 247, 166, 1.0)),
  ];
  final _menuItem=[SleepTracker(),HydrateTracker(),MedicalTracker(),CalorieIntake(),HealthTipInfo(),FunActivity()];
  List<InkWell> cardList() {
    List<InkWell> cardList = new List<InkWell>();
    for (int i = 0; i < _cardItemList.length; i++) {
      cardList.add(cardBuilder(
          _cardItemList[i].color, _cardItemList[i].title, _cardItemList[i].icon,_menuItem[i]));
    }
    return cardList;
  }

}

class CardItem {
  String title;
  IconData icon;
  Color color;

  CardItem(this.title, this.icon, this.color);
}



