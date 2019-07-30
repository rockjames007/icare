import 'package:flutter/material.dart';
import 'package:icare/auth.dart';
import 'package:icare/root_page.dart';
void main() {
  runApp(MainPage());
}
class MainPage extends StatelessWidget
{
  /*AnimationController _controller;
   Animation<double> _animation;
   bool upDown = true;*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp
      ( debugShowCheckedModeBanner: false,
        home: new RootPage(auth: new Auth()),


    );
  }
}