import 'package:flutter/material.dart';

void main() => runApp(Menu());

class Menu extends StatefulWidget {
  State<StatefulWidget> createState() => _MenuPageState();
}

int _currentIndex = 0;

class _MenuPageState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    int count;
    if (MediaQuery.of(context).orientation == Orientation.landscape)
      count = 4;
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
          type: BottomNavigationBarType.fixed, // new
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
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
                icon: Icon(Icons.info),
                title: Text(
                  'Personal Info',
                  textScaleFactor: 0.5,
                )) //it
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class CardItem {
  String title;
  IconData icon;
  Color color;

  CardItem(this.title, this.icon, this.color);
}

final _cardItemList = [
  CardItem("Mood", Icons.mood, Colors.redAccent),
  CardItem("Mood", Icons.mood, Colors.redAccent),
  CardItem("Mood", Icons.mood, Colors.redAccent),
  CardItem("Mood", Icons.mood, Colors.redAccent),
  CardItem("Mood", Icons.mood, Colors.redAccent),
];

List<Card> cardList() {
  List<Card> cardList = new List<Card>();
  for (int i = 0; i < _cardItemList.length; i++) {
    cardList.add(cardBuilder(
        _cardItemList[i].color, _cardItemList[i].title, _cardItemList[i].icon));
  }
  return cardList;
}

Widget cardBuilder(Color color, String label, IconData icon) {
  return Card(
    color: color,
    child: Container(
      child: Icon(icon),
    ),
  );
}
