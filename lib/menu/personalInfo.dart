import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icare/root_page.dart';
import 'package:icare/auth.dart';
import 'package:icare/menu/editUserInfo.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  SharedPreferences _prefs;
  @override
  void initState() {
    super.initState();
    getUserDataSharedPreference();
  }

  void getUserDataSharedPreference() async {
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => _prefs = prefs);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Personal Details",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        actions: <Widget>[FloatingActionButton(onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserInfoDetail()));},mini: true,child: Icon(Icons.edit),disabledElevation: 0.0,)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _sizedBox(20.0),
            ListTile(
              title: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    prefix: Text("Email : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    icon: new Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder()),
                controller: TextEditingController(text: _prefs.get("email")),
              ),
            ),
            _sizedBox(50.0),
            ListTile(
              title: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    prefix: Text("Age : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    icon: new Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder()),
                controller: TextEditingController(text: calculateAge(DateTime.parse(_prefs.get("dob"))).toString()+" years"),
              ),
            ),
            _sizedBox(50.0),
            ListTile(
              title: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    prefix: Text("Height : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    icon: new Icon(
                      Icons.accessibility,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder()),
                controller: TextEditingController(text: _prefs.get("height")+"cm"),
              ),
            ),
      _sizedBox(50.0),
            ListTile(
              title: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    prefix: Text("Weight : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    icon: new Icon(
                      Icons.storage,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder()),
                controller: TextEditingController(text: _prefs.get("weight")+"kg"),
              ),
            ),
            _sizedBox(50.0),
            ListTile(
              title: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    prefix: Text("Gender : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    icon: new Icon(
                      Icons.account_box,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder()),
                controller: TextEditingController(text: _prefs.get("gender")),
              ),
            ),
           Divider(),
            SizedBox(
              height: 40.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.blue,
                child: new Text('Sign Out',
                    style: new TextStyle(fontSize: 15.0, color: Colors.white)),
                onPressed: () {
                  _signOut();
                  Route route = MaterialPageRoute(
                      builder: (context) => RootPage(auth: new Auth()));
                  Navigator.pushReplacement(context, route);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
Widget _sizedBox(_height) {
  return new SizedBox(height: _height);
}
calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
void _signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e);
  }
}