import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}


class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation,textanimation;
  AnimationController controller,textcontroller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.100,
          0.750,
          curve: Curves.easeIn),))
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  Widget build(BuildContext context) {
    var devicesize=MediaQuery.of(context).size;
    return Center
      (
       child:
       new Column
         (
           children: <Widget>
           [
            Container(
                      alignment:Alignment(0.0, 1.5),
                      height: animation.value,
                      width: animation.value,
                      child:Image.asset("assets/xmplarlogo.png"),
                      ),
           Container
           (
             alignment: Alignment(0.0, 1.0),
             height: devicesize.height*.30,
             child: Text(
                 'KEEP GROWING',
                 textAlign: TextAlign.center,
                 overflow: TextOverflow.clip,
                 textScaleFactor: 1.5,
                 style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.6)),
             ),
           )

           ]


         ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(LogoApp());
}