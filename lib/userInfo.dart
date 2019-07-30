import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icare/personalDetailRequired.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:icare/menu/menu.dart';

class UserInfoDetail extends StatefulWidget {
  @override
  _UserInfoDetailState createState() => _UserInfoDetailState();
}

class DobFieldValidator {
  static String validate(DateTime value) {
    return value == null ? 'Date of birth can\'t be empty' : null;
  }
}

class WeightFieldValidator {
  static String validate(String value) {
    if (value.isEmpty)
      return 'Weight can\'t be empty';
    else if (double.parse(value) <= 20)
      return 'Weight can\'t be less than 20kg';
    else if (double.parse(value) > 150.0)
      return 'Weight can\'t be more than 150kg';
    return null;
  }
}

class HeightFieldValidator {
  static String validate(String value) {
    if (value.isEmpty)
      return 'Height can\'t be empty';
    else if (double.parse(value) <= 60)
      return 'Height can\'t be less than 60cm';
    else if (double.parse(value) >= 250)
      return 'Height can\'t be more than 250cm';
    return null;
  }
}

class _UserInfoDetailState extends State<UserInfoDetail> {
  PersonalDetail _personalDetail = new PersonalDetail();
  FirebaseUser _firebaseUser;
  final dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> _genders = <String>['Male', 'Female'];
  String _gender = "Male";
  bool _load = false;

  bool validateAndSave() {
    setState(() {
      _load = true;
    });
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() {
      _load = false;
    });
    return false;
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
    Widget loadingIndicator = _load
        ? new Container(
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : new Container();
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              _personalDetail.email = _firebaseUser.email;
              return SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        _sizedBox(30.0),
                        ListTile(
                            title: Text(
                          "Enter your Personal Details:",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                        )),
                        Divider(),
                        _sizedBox(20.0),
                        _emailOutput(),
                        _sizedBox(50.0),
                        _dobInput(),
                        _sizedBox(50.0),
                        _genderInput(),
                        _sizedBox(50.0),
                        _heightInput(),
                        _sizedBox(50.0),
                        _weightInput(),
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

  Widget _heightInput() {
    return new ListTile(
      title: TextFormField(
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Height',
            suffixText: 'cm',
            icon: new Icon(
              Icons.accessibility,
              color: Colors.black,
            ),
            border: OutlineInputBorder()),
        keyboardType: TextInputType.number,
        validator: HeightFieldValidator.validate,
        onSaved: (value) => _personalDetail.height = value,
      ),
    );
  }

  Widget _weightInput() {
    return new ListTile(
      title: TextFormField(
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Weight',
            suffixText: 'kg',
            icon: new Icon(
              Icons.storage,
              color: Colors.black,
            ),
            border: OutlineInputBorder()),
        keyboardType: TextInputType.number,
        onSaved: (value) => _personalDetail.weight = value,
        validator: WeightFieldValidator.validate,
      ),
    );
  }

  Widget _dobInput() {
    final format = DateFormat("dd/MM/yyyy");
    return new ListTile(
      title: DateTimeField(
        format: format,
        readOnly: true,
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
        validator: DobFieldValidator.validate,
        onChanged: (DateTime newValue) {
          setState(() {
            _personalDetail.dob = newValue;
            print(_personalDetail.dob.toString());
          });
        },
      ),
    );
  }

  Widget _genderInput() {
    return new ListTile(
      title: new DropdownButtonHideUnderline(
        child: new InputDecorator(
          decoration: const InputDecoration(
            icon: const Icon(
              Icons.account_box,
              color: Colors.black,
            ),
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
        onPressed: (){
          if(validateAndSave())
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Menu()));
        },
      ),
    );
  }

  Widget _sizedBox(_height) {
    return new SizedBox(height: _height);
  }
}
