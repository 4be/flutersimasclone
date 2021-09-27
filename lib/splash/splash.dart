//@dart=2.9
import 'package:flutter/material.dart';
import 'package:simas/login/login.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Login(),
      imageBackground: AssetImage("assets/images/splash.png"),
      loaderColor: Colors.white,
    );
  }
}
