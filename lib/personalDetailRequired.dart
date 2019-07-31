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
  String age;
  DateTime dob;

  PersonalDetail({this.email, this.weight, this.gender, this.height,this.dob});
}
class PersonalDataRequired extends StatefulWidget {
  @override
  _PersonalDataRequiredState createState() => _PersonalDataRequiredState();
}

class _PersonalDataRequiredState extends State<PersonalDataRequired> {

  PersonalDetail _detail=new PersonalDetail();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              StreamBuilder(
                  stream:Firestore.instance.collection('users').document(snapshot.data.uid).collection('myprofile').document('basic').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return new CircularProgressIndicator();
                    else {
                      var userDocument = snapshot.data;
                      _detail.email = userDocument['email'];
                      _detail.height = userDocument['height'];
                      _detail.weight = userDocument['weight'];
                      _detail.gender = userDocument['gender'];
                      _detail.dob = userDocument['dob'];
                      print(_detail.dob);
                      if (personalDetailAvailable(_detail)) {
                        storeDate();
                        return new Menu();
                      }
                      else
                        return new CircularProgressIndicator();
                    }
                  }

              );
              return new Container();
            }
            else {
              return new CircularProgressIndicator();
            }
          }
    );
  }
  void storeDate() async{
    String email,height,weight,gender,dob;
    SharedPreferences prefs;
    prefs=await SharedPreferences.getInstance();
    prefs.setString(email, _detail.email);
    prefs.setString(height, _detail.height);
    prefs.setString(weight,  _detail.weight);
    prefs.setString(gender,  _detail.gender);
    prefs.setString(dob, _detail.dob.toIso8601String());
  }
}

bool personalDetailAvailable(PersonalDetail personalDetail) {
  if (personalDetail.email.isNotEmpty &&
      personalDetail.weight.isNotEmpty &&
      personalDetail.gender.isNotEmpty &&
      personalDetail.height.isNotEmpty &&
      personalDetail.dob==null)
    return true;
  else
    return false;
}
