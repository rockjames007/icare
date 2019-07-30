import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icare/personalDetailRequired.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class UserInfoDetail extends StatefulWidget {
  @override
  _UserInfoDetailState createState() => _UserInfoDetailState();
}

class _UserInfoDetailState extends State<UserInfoDetail> {
  PersonalDetail _personalDetail = new PersonalDetail();
  FirebaseUser _firebaseUser;
  final formKey = GlobalKey<FormState>();
  List<String> _genders = <String>['', 'Male', 'Female'];
  String _gender = "";
  bool _load = false;
  bool validateAndSave() {
    setState((){
      _load=true;
    });
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState((){
      _load=false;
    });
    return false;
  }
  void validateAndSubmit() async {
    if (validateAndSave()) {


    }
  }
  @override
  void initState() {
    super.initState();
    try {
      FirebaseAuth.instance.currentUser().then((_firebaseUser) => setState(() {
            this._firebaseUser = _firebaseUser;
          }));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_load? new Container(
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              _personalDetail.email = _firebaseUser.email;
              return SingleChildScrollView(
                child: Container(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        _sizedBox(150.0),
                        _emailOutput(),
                        _sizedBox(50.0),
                        _dobInput(),
                        _sizedBox(50.0),
                        _submitButton()
                      ],
                    ),
                  ),
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Widget _emailOutput() {
    return new ListTile(
      title: TextFormField(
        autofocus: false,
        readOnly: true,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.black,
            ),
            border: OutlineInputBorder()),
        initialValue: _personalDetail.email,
      ),
    );
  }

  Widget _dobInput() {
    final format = DateFormat("dd-MM-yyyy");
    return new ListTile(
      title: DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1950),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime.now());
        },
        decoration: new InputDecoration(
            hintText: 'DOB',
            icon: new Icon(
              Icons.calendar_today,
              color: Colors.black,
            ),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget _genderInput() {
    return new ListTile(
      title: new DropdownButtonHideUnderline(
        child: new InputDecorator(
          decoration: const InputDecoration(
            icon: const Icon(Icons.account_box),
            labelText: 'Gender',
          ),
          child: new DropdownButton<String>(
            value: _gender,
            isDense: true,
            onChanged: (String newValue) {
              setState(() {
                _gender = newValue;
              });
            },
            items: _genders.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  Widget _submitButton() {
    return new SizedBox(
      height: 40.0,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.blue,
        child: new Text('Submit',
            style: new TextStyle(fontSize: 15.0, color: Colors.white)),
        onPressed: validateAndSubmit,
      ),
    );
  }

  Widget _sizedBox(_height) {
    return new SizedBox(height: _height);
  }
}
