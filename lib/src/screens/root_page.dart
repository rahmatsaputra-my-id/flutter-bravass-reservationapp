import 'package:bravass_development/src/screens/homepage.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bravass App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}
