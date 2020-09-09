import 'package:bravass_development/src/models/login__model.dart';
import 'package:bravass_development/src/resources/bravass_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;

  LoginPage({Key key, this.auth, this.loginCallback});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  String _username;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;
  bool passwordVisible;
  bool rememberPassword = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      if (usernameController.text != "" || passwordController.text != "") {
        _errorMessage = "";
        _isLoading = true;
      } else {
//        _errorMessage = "Username dan Password tidak boleh kosong";
        _isLoading = false;
      }
    });

    if (validateAndSave()) {
      String nik = "";
      LoginResponse loginResponse = LoginResponse();
      try {
        if (_isLoginForm) {
          print('Is Login From Bro');
          loginResponse =
              await widget.auth.signIn(_username, _password, rememberPassword);
          nik = loginResponse.result.nik;
          print('Signed in: $nik');
        } else {
//          userId = await widget.auth.signUp(_username, _password);
//          //widget.auth.sendEmailVerification();
//          //_showVerifyEmailSentDialog();
          print('Signed up user: ');
        }
        setState(() {
          _isLoading = false;
        });

        if (nik.length > 0 && nik != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
          showAlertDialog(context);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _errorMessage = "";
    _username = "";
    _password = "";
    usernameController.text = "";
    passwordController.text = "";
    _isLoading = false;
    _isLoginForm = true;
    passwordVisible = true;
    getShared();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Copyright © 2019 - Bravass Creative Space. All rights reserved.\n App Version: 1.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              _showForm(),
              _showCircularProgress(),
            ],
          ),
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
      ));
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            new ListView(
              shrinkWrap: true,
              children: <Widget>[
                showLogo(),
                showEmailInput(),
                showPasswordInput(),
                CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    value: rememberPassword,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text("Remember Me"),
                    onChanged: (bool value) {
                      setState(() {
                        rememberPassword = value;
                        print(
                            "Remember Password " + rememberPassword.toString());
                      });
                    }),
                showPrimaryButton(),
                showText(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Wifi"),
                content: Text("Wifi not detected. Please activate it."),
              ));
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50.0,
          child: Image.asset(
            'images/bravasspngputih.png',
            height: 400,
            width: 400,
          ),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: usernameController,
        decoration: new InputDecoration(
            hintText: 'Username',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
        onSaved: (value) => _username = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: _isLoginForm
            ? TextFormField(
                maxLines: 1,
                obscureText: passwordVisible,
                autofocus: false,
                controller: passwordController,
                decoration: new InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    icon: new Icon(
                      Icons.lock,
                      color: Colors.grey,
                    )),
                validator: (value) =>
                    value.isEmpty ? 'Password can\'t be empty' : null,
                onSaved: (value) => _password = value.trim(),
              )
            : Container());
  }

  Widget showText() {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: new Text(
          'Silahkan masukkan username dan password Anda !',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(_isLoginForm ? 'Lupa Password' : 'Sign in',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.grey,
            child: new Text(_isLoginForm ? 'Login' : 'Lupa Password',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(_errorMessage),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<Null> getShared() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    usernameController.text = sharedPreferences.getString("remember_username");
    passwordController.text = sharedPreferences.getString("remember_password");

    print("Username : " + _username);
    print("Password : " + _password);
  }
}
