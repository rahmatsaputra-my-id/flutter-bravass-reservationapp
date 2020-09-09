import 'package:bravass_development/src/screens/splashscreen_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.black),
      darkTheme:
          ThemeData(brightness: Brightness.dark, accentColor: Colors.black),
      debugShowCheckedModeBanner: false,
      title: 'Bravass Apps',
      home: Scaffold(
        body: SplashScreenPage(),
      ),
    );
  }
}
