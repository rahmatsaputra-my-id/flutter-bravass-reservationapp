import 'package:bravass_development/src/resources/bravass_provider.dart';
import 'package:bravass_development/src/screens/homepage.dart';
import 'package:bravass_development/src/screens/login_page.dart';
import 'package:flutter/material.dart';

enum AuthStatus { NOT_DETERMINED, NOT_LOGGED_IN, LOGGED_IN }

class NewRootPage extends StatefulWidget {
  BaseAuth auth;

  NewRootPage({this.auth});

  @override
  _NewRootPageState createState() => _NewRootPageState();
}

class _NewRootPageState extends State<NewRootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _nik = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.auth.getCurrentUser().then((nik) {
      setState(() {
        if (nik != null) {
          _nik = nik;
        }

        authStatus =
            nik == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((nik) {
      setState(() {
        _nik = nik;
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _nik = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_nik.length > 0 && _nik != null) {
          return new HomePage(
            nik: _nik,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
