import 'dart:async';

import 'package:bravass_development/src/resources/bravass_provider.dart';
import 'package:bravass_development/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return NewRootPage(
          auth: new BravassProvider(),
        );
      }));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset(
          "images/bravasspngputih.png",
          width: 300,
          height: 150,
        ),
      ),
    );
  }
}
