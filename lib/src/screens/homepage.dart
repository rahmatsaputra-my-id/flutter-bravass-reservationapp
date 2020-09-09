import 'dart:convert';

import 'package:bravass_development/src/resources/bravass_provider.dart';
import 'package:bravass_development/src/screens/home_page_fragment.dart';
import 'package:bravass_development/src/screens/profil_page.dart';
import 'package:bravass_development/src/screens/room_page.dart';
import 'package:bravass_development/src/screens/invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_screen.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String nik;

  final drawerItems = [
    new DrawerItem(
      "Home",
      Icons.home,
    ),
    new DrawerItem("Invoices", Icons.library_books),
    new DrawerItem("Rooms", Icons.airline_seat_legroom_extra),
    new DrawerItem("Profil", Icons.person),
    new DrawerItem("About", Icons.info),
    new DrawerItem("Logout", Icons.power_settings_new)
  ];

  HomePage({Key key, this.auth, this.logoutCallback, this.nik})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String username;
  String email;
  String foto;

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomePageFragment();
      case 1:
        return new InvoicePage();
      case 2:
        return new RoomPage();
      case 3:
        return new ProfilPage(
          auth: widget.auth,
        );

      case 4:
        return new AboutPage();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    username = "";
    email = "";
    foto = "";

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () {
          if (i == 5) {
//            logout();
            signOut();
          } else {
            _onSelectItem(i);
          }
        },
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        elevation: 8,
      ),
      drawer: new Drawer(
        elevation: 8.0,
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/functionHall.png'),
                        fit: BoxFit.fill)),
                currentAccountPicture: ClipOval(
                    child: foto != null
                        ? Container(
                            color: Colors.black,
                            child: Image.memory(base64Decode(foto)))
                        : Container(
                            color: Colors.black,
                            child: Image.asset("images/bravasspngputih.png"))),
                accountName: new Text(username),
                accountEmail: new Text(email)),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

  loadData() async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    setState(() {
      username = (savedPref.getString('nama_member'));
      email = (savedPref.getString('email'));
      foto = savedPref.getString("foto");
    });
  }

  signOut() async {
    try {
      BravassProvider bravassProvider = BravassProvider();
      await bravassProvider.signOut();
      widget.logoutCallback();
    } catch (e) {
      print('Error Broh' + e);
    }
  }
}
