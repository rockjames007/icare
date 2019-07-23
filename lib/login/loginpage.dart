import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare/auth.dart';

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(Login());
}
class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class Login extends StatefulWidget {
  Login({Key key, this.title, this.auth, this.onSignedIn}) : super(key: key);
  final VoidCallback onSignedIn;
  final String title;
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
}

class _LoginPageState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool _load = false;
  String _email;
  String _password;
  FormType _formType = FormType.login;
  String _authHint = '';
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
      try {
        String userId = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password);
        setState(() {
          _authHint = 'Signed In\n\nUser id: $userId';
        });
        widget.onSignedIn();
      }
      catch (e) {
        setState(() {
          _authHint = '!Sign In Error , Please check your email or password';
          _load=false;
        });
        print(e);
      }
    } else {
      setState(() {
        _load=false;
        _authHint = '';
      });
    }
  }
  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget loadingIndicator =_load? new Container(
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/backgroundcolor.png"),fit: BoxFit.cover),
            ),
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[_sizedBox(50.0),
                _logo(),
                _sizedBox(50.0),
                _emailInput(),
                _sizedBox(15.0),
                _passwordInput(),
                _sizedBox(100.0),
                _checkErrorInLogin(),
                _submitButton(),
                new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
                ],
              ),
            )));
  }
  Widget _emailInput() {
    return new TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.black,
          )),
      validator: EmailFieldValidator.validate,
      onSaved: (value) => _email = value,
    );
  }

  Widget _passwordInput() {
    return new TextFormField(
      obscureText: true,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Password',
          icon: new Icon(
            Icons.lock,
            color: Colors.black,
          )),
      validator: PasswordFieldValidator.validate,
      onSaved: (value) => _password = value,
    );
  }
  Widget _checkErrorInLogin(){

    return
      new Text(_authHint,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center,
      );

  }
  Widget _submitButton() {
    return
      new SizedBox(
        height: 40.0,
        child:RaisedButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: new Text('Login',
              style:
              new TextStyle(fontSize: 15.0, color: Colors.white)),
          onPressed: validateAndSubmit,),
      );
  }
  Widget _logo() {
    return new Image(
      image:AssetImage('assets/xmplarlogo.png'),
      colorBlendMode: BlendMode.darken,
      width: 150.0,
      height: 150.0,
    );
  }
  Widget _sizedBox(_height) {
    return new SizedBox(height: _height);
  }
}
