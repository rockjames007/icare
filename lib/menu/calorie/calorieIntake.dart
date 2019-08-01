import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalorieIntake extends StatefulWidget {
  @override
  _CalorieIntakeState createState() => _CalorieIntakeState();
}

class Food {
  String category;
  double quantity;
  String type;
  double calorie;

  Food({this.category, this.quantity, this.type, this.calorie});

  static List<Food> getMilk() {
    return <Food>[
      Food(
          category: "Whole Milk",
          quantity: 225.0,
          type: "ml (1 cup)",
          calorie: 150.0),
      Food(
          category: "Paneer (Whole Milk)",
          quantity: 60.0,
          type: "gms",
          calorie: 150.0),
      Food(category: "Butter", quantity: 1.0, type: "tbsp", calorie: 45.0),
      Food(category: "Ghee", quantity: 1.0, type: "tbsp", calorie: 45.0),
    ];
  }

  static List<Food> getFruits() {
    return <Food>[
      Food(category: "Apple", quantity: 1.0, type: "small", calorie: 55),
      Food(category: "Grapes", quantity: 15, type: "small", calorie: 55),
      Food(category: "Mango", quantity: 1.5, type: "small", calorie: 55),
      Food(category: "Musambi", quantity: 1.0, type: "medium", calorie: 55),
      Food(category: "Orange", quantity: 1.0, type: "medium", calorie: 55),
    ];
  }

  static List<Food> getCereals() {
    return <Food>[
      Food(category: "Cooked Cereal", quantity: 1.5, type: "cup", calorie: 80),
      Food(category: "Rice Cooked", quantity: 25, type: "gms", calorie: 80),
      Food(category: "Chapatti", quantity: 1.0, type: "medium", calorie: 80),
    ];
  }

  static List<Food> getVegetables() {
    return <Food>[
      Food(category: "Potato", quantity: 1.0, type: "medium", calorie: 55),
      Food(category: "Dal", quantity: 1.0, type: "large katori", calorie: 75),
      Food(
          category: "Mixed Vegetables",
          quantity: 150,
          type: "gms",
          calorie: 75),
    ];
  }

  static List<Food> getMeats() {
    return <Food>[
      Food(category: "Fish", quantity: 50, type: " gms", calorie: 55),
      Food(category: "Mutton", quantity: 1.0, type: " oz", calorie: 75),
      Food(category: "Egg", quantity: 1.0, type: " item", calorie: 75),
    ];
  }

  static List<Food> getCookedFood() {
    return <Food>[
      Food(category: "Biscuit (Sweet)", quantity: 15, type: "gms", calorie: 70),
      Food(category: "Cake (Plain)", quantity: 50, type: "gms", calorie: 135),
      Food(
          category: "Cake (Rich Chocolate)",
          quantity: 50,
          type: "gms",
          calorie: 225),
      Food(
          category: "Dosa (Plain)i",
          quantity: 1.0,
          type: "medium",
          calorie: 135),
      Food(
          category: "Dosa (Masala)",
          quantity: 1.0,
          type: "medium",
          calorie: 250),
      Food(category: "Pakoras", quantity: 50, type: "gms", calorie: 175),
      Food(category: "Puri", quantity: 1.0, type: "large", calorie: 85),
      Food(category: "Samosa", quantity: 1.0, type: "piece", calorie: 140),
      Food(category: "Vada (Medu)", quantity: 1.0, type: "small", calorie: 70)
    ];
  }

  static List<Food> getMainDishes() {
    return <Food>[
      Food(
          category: "Mutton biriyani",
          quantity: 1.0,
          type: "cup",
          calorie: 225),
      Food(category: "Veg biriyani", quantity: 1.0, type: "cup", calorie: 200),
      Food(category: "Chicken curry", quantity: 100, type: "gms", calorie: 225),
      Food(category: "Veg curry", quantity: 100, type: "gms", calorie: 130),
      Food(category: "Fried fish", quantity: 85, type: "gms", calorie: 140),
      Food(category: "Pulav", quantity: 100, type: "gms", calorie: 130),
    ];
  }

  static List<Food> getBeverages() {
    return <Food>[
      Food(category: "Beer", quantity: 125, type: "fl.oz", calorie: 150),
      Food(category: "Cola", quantity: 200, type: "ml", calorie: 95),
      Food(category: "Wine", quantity: 3.5, type: "fl.oz", calorie: 85),
    ];
  }
}

class _CalorieIntakeState extends State<CalorieIntake> {
  SharedPreferences _prefs;
  String calorie = "";
  double weight;
  double height;
  double age;
  List<Food> milk;
  List<Food> fruits;
  List<Food> cereals;
  List<Food> meats;
  List<Food> vegetables;
  List<Food> maindish;
  List<Food> cookedFood;
  List<Food> bevereges;
  double totalcalorie = 0.0;
  List foods=[];
  bool sort;
  @override
  void initState() {
    // TODO: implement initState
    sort = false;
    milk = Food.getMilk();
    fruits = Food.getFruits();
    cereals = Food.getCereals();
    meats = Food.getMeats();
    vegetables = Food.getVegetables();
    maindish = Food.getMainDishes();
    cookedFood = Food.getCookedFood();
    bevereges = Food.getBeverages();
    foods=[milk,fruits,cereals,meats,vegetables,maindish,cookedFood,bevereges];
    super.initState();
    getUserDataSharedPreference();
  }

  void getUserDataSharedPreference() async {
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => _prefs = prefs);
        if (_prefs.get("gender") == "Male")
          calorie = (66.4730 +
                  13.7516 * double.parse(_prefs.get("weight")) +
                  5.0033 * double.parse(_prefs.get("height")) -
                  6.7550 * double.parse(_prefs.get("age")))
              .toStringAsFixed(2);
        else
          calorie = (655.0955 +
                  9.5634 * double.parse(_prefs.get("weight")) +
                  1.8496 * double.parse(_prefs.get("height")) -
                  4.6756 * double.parse(_prefs.get("age")))
              .toStringAsFixed(2);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Calorie Intake',
              ),
              background: Image.asset(
                "assets/calorie.jpg",
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
                                  text: "To maintain your weight you need",
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
                                  text: calorie + " Kcal",
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
                Card(
                  color: Colors.white,
                  child: Table(
                    border: TableBorder.symmetric(inside: BorderSide(color: Colors.black,width: 1.0)),
                    children: [
                      TableRow(
                          decoration:
                              BoxDecoration(color: Colors.lightBlue[50]),
                          children: [
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: RichText(
                                  text: TextSpan(
                                      text: "Exercise level",
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
                                      text:
                                          "Daily Calories Required (Kcal/day)",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  textAlign: TextAlign.center,
                                )),
                          ]),
                      TableRow(children: [
                        TableCell(
                            child: RichText(
                          text: TextSpan(
                              text: "Little to no exercise",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: RichText(
                              text: TextSpan(
                                  text: (double.parse(calorie) * 1.2)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              textAlign: TextAlign.center,
                            )),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: RichText(
                          text: TextSpan(
                              text: "Light exercise (1–3 days per week)",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: RichText(
                              text: TextSpan(
                                  text: (double.parse(calorie) * 1.375)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              textAlign: TextAlign.center,
                            )),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: RichText(
                          text: TextSpan(
                              text: "Moderate exercise (3–5 days per week)",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: RichText(
                              text: TextSpan(
                                  text: (double.parse(calorie) * 1.55)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              textAlign: TextAlign.center,
                            )),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: RichText(
                          text: TextSpan(
                              text: "Heavy exercise (6–7 days per week)",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: RichText(
                              text: TextSpan(
                                  text: (double.parse(calorie) * 1.725)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              textAlign: TextAlign.center,
                            )),
                      ]),
                      TableRow(children: [
                        TableCell(
                            child: RichText(
                          text: TextSpan(
                              text:
                                  "Very heavy exercise (twice per day, extra heavy workouts)",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: RichText(
                              text: TextSpan(
                                  text: (double.parse(calorie) * 1.9)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              textAlign: TextAlign.center,
                            )),
                      ]),
                    ],
                  ),
                ),
                Container(
                  color: Colors.lightBlueAccent,
                    child:Column(children: <Widget>[
                    Card(child:ListTile(title: Text("Calorie Chart"),)),
                  _buildList()
                ],))
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _sizedBox(_height) {
    return new SizedBox(height: _height);
  }
  Widget _buildList() {
    return ListView.builder(
      // Must have an item count equal to the number of items!
      itemCount: foods.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, int) {
        return _calorieDataTable(foods[int]);
      },
      shrinkWrap: true,
    );
  }
  Widget _calorieDataTable(List<Food> foodsel) {
    return Card(
      color: Colors.white,
      child: DataTable(
        columnSpacing: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.width/500.0:MediaQuery.of(context).size.width/8.0,
        columns: [
          DataColumn(
            label: Text("Food"),
          ),
          DataColumn(
            label: Text("Measure"),
          ),
          DataColumn(
            label: Text("Calories"),
          ),
        ],
        rows: foodsel
            .map(
              (foodsel) => DataRow(cells: [
                DataCell(
                  Text(foodsel.category),
                ),
                DataCell(
                  Text(foodsel.quantity.toString() + " " + foodsel.type),
                ),
                DataCell(
                  Text(foodsel.calorie.toString()),
                ),

              ]),
            )
            .toList(),
      ),
    );
  }
}
