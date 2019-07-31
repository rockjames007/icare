import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icare/menu/menu.dart';
import 'package:icare/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';

class PersonalDetail {
  String email;
  String weight;
  String gender;
  String height;
  DateTime dob;

  PersonalDetail({this.email, this.weight, this.gender, this.height,this.dob});
}
class PersonalDataRequired extends StatefulWidget {
  @override
  _PersonalDataRequiredState createState() => _PersonalDataRequiredState();
}

class _PersonalDataRequiredState extends State<PersonalDataRequired> {
  FirebaseUser _firebaseUser;
  PersonalDetail _detail=new PersonalDetail();
  SharedPreferences _prefs;
  bool _load=true;
  @override
  void initState(){
    super.initState();
    getUserDataSharedPreference();
  }
  void getUserDataSharedPreference() async{
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => _prefs = prefs);
        if(_prefs.get("email")!=null){
          print(_prefs.get("email").toString());
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Menu()));
        }
        else{
          getUserData();
        }
      });
  }
  Future getUserData() async{
    try {
      await FirebaseAuth.instance.currentUser().then((_firebaseUser) =>
          setState(() {
            this._firebaseUser = _firebaseUser;
          }));
    } catch (e) {}
    await Firestore.instance.collection("users").document(
        _firebaseUser.uid).collection('personalinfo')
        .document('basic').
    get().then((documentSnapshot) {
      if(documentSnapshot.exists) {
        _detail.email = documentSnapshot.data['email'];
        _detail.height = documentSnapshot.data['height'];
        _detail.weight = documentSnapshot.data['weight'];
        _detail.gender = documentSnapshot.data['gender'];
        _detail.dob = DateTime.parse(documentSnapshot.data['dob']);
      }
      else{
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserInfoDetail()));
      }
      if (personalDetailAvailable(_detail)) {
        storeDate();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Menu()));
      }
      else{
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserInfoDetail()));
      }
      setState(() {
        _load=false;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_load? new Container(
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();
    return Container(
      color: Colors.white,
      child: new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
    );
  }
  void storeDate() async{
    SharedPreferences prefs;
    prefs=await SharedPreferences.getInstance();
    prefs.setString("email", _detail.email);
    prefs.setString("height", _detail.height);
    prefs.setString("weight",  _detail.weight);
    prefs.setString("gender",  _detail.gender);
    prefs.setString("dob", _detail.dob.toIso8601String());
  }
}

bool personalDetailAvailable(PersonalDetail personalDetail) {
  if (personalDetail.email.isNotEmpty &&
      personalDetail.weight.isNotEmpty &&
      personalDetail.gender.isNotEmpty &&
      personalDetail.height.isNotEmpty &&
      personalDetail.dob!=null)
    return true;
  else
    return false;
}
