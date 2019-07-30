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
    return Container(
      child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .document(snapshot.data.uid)
                      .collection('myprofile')
                      .document('personalinfo')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      _detail.email = snapshot.data['email'];
                      _detail.height = snapshot.data['height'];
                      _detail.weight = snapshot.data['weight'];
                      _detail.gender = snapshot.data['gender'];
                      _detail.dob = snapshot.data['dob'];
                      if (personalDetailAvailable(_detail)) {
                        storeDate();
                        return new Menu();
                      }
                      else
                        return new UserInfoDetail();
                    }
                    return new UserInfoDetail();
                  });
            } else {
              return new CircularProgressIndicator();
            }
            return new UserInfoDetail();
          }),
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
      personalDetail.dob != null)
    return true;
  else
    return false;
}
