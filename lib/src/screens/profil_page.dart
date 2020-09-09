import 'dart:convert';
import 'dart:io';
import 'package:bravass_development/src/models/response_get_user.dart';
import 'package:bravass_development/src/models/response_update.dart';
import 'package:bravass_development/src/resources/bravass_provider.dart';
import 'package:bravass_development/src/screens/edit_profil_page.dart';
import 'package:bravass_development/src/screens/homepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  final BaseAuth auth;

  ProfilPage({Key key, this.auth}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

enum Pages { CAMERA, GALLERY }

class _ProfilPageState extends State<ProfilPage> with WidgetsBindingObserver {
  BravassProvider bravassProvider = new BravassProvider();
  File _image;
  ResponseUpdateData responseUpdate = ResponseUpdateData();

  Future<ResponseGetUser> responseGetUser;
  String idMember;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    responseGetUser = loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print("RESUMED");
      setState(() {
        responseGetUser = loadData();
      });
    }
    print("Current state = $state");
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Center(
      child: FutureBuilder<ResponseGetUser>(
        future: responseGetUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return isPortrait
                ? Column(
                    children: <Widget>[
                      Flexible(
                        flex: isPortrait ? 2 : 8,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ClipOval(
                                          child: InkWell(
                                        onTap: () {
                                          _selectPage();
                                        },
                                        child: Container(
                                            height: 92,
                                            width: 92,
                                            color: Colors.black,
                                            child: snapshot.data.result.foto !=
                                                    null
                                                ? Image.memory(base64Decode(
                                                    snapshot.data.result.foto))
                                                : Image.asset(
                                                    "images/bravasspngputih.png")),
                                      )),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _selectPage();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0, left: 4),
                                        child: Text('Ubah Foto'),
                                      ),
                                    )
                                  ],
                                ),
                                flex: 3,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Text(
                                          snapshot.data.result.namaMember,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 1.0),
                                        child: Text(
                                          snapshot.data.result.nik,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 1.0),
                                        child: Text(
                                          snapshot.data.result.noHp,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                flex: 5,
                              )
                            ],
                          ),
                        ),
                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 25),
//                        child: Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[],
//                        ),
//                      ),
                      Flexible(
                        flex: 6,
                        child: Card(
                          margin: EdgeInsets.only(
                              left: 16, right: 16, bottom: 70, top: 0),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 16),
                                child: Text('Nama'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 7),
                                child: Text(
                                  snapshot.data.result.namaMember,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 7),
                                child: Text('Email'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 7),
                                child: Text(
                                  snapshot.data.result.email,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 7),
                                child: Text('NIK'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 7),
                                child: Text(
                                  snapshot.data.result.nik,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 7),
                                child: Text('No Telpon'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 7),
                                child: Text(
                                  snapshot.data.result.noHp,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 7),
                                child: Text('Alamat'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 7),
                                child: Text(
                                  snapshot.data.result.alamat,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 7),
                                child: Text('NPWP'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 7),
                                child: Text(
                                  snapshot.data.result.npwp,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: new RaisedButton(
                            elevation: 5.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.grey,
                            child: new Text('Update Profil',
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                    context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilPage(
                                            baseAuth: widget.auth,
                                            responseGetUser: responseGetUser,
                                          )
                                  )
                              );
                            }),
                      ),
                    ],
                  )
                : ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ClipOval(
                                            child: InkWell(
                                          onTap: () {
                                            _selectPage();
                                          },
                                          child: Container(
                                              height: 92,
                                              width: 92,
                                              color: Colors.black,
                                              child: snapshot
                                                          .data.result.foto !=
                                                      null
                                                  ? Image.memory(base64Decode(
                                                      snapshot
                                                          .data.result.foto))
                                                  : Image.asset(
                                                      "images/bravasspngputih.png")),
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0, left: 4),
                                        child: Text('Ubah Foto'),
                                      )
                                    ],
                                  ),
                                  flex: 3,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: Text(
                                            snapshot.data.result.namaMember,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1.0),
                                          child: Text(
                                            snapshot.data.result.nik,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1.0),
                                          child: Text(
                                            snapshot.data.result.noHp,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 5,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[],
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, bottom: 10, top: 25),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 16),
                                  child: Text('Nama'),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 7),
                                  child: Text(
                                    snapshot.data.result.namaMember,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16.0, top: 7),
                                  child: Text('Email'),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 7),
                                  child: Text(
                                    snapshot.data.result.email,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16.0, top: 7),
                                  child: Text('NIK'),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 7),
                                  child: Text(
                                    snapshot.data.result.nik,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16.0, top: 7),
                                  child: Text('No Telpon'),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 7),
                                  child: Text(
                                    snapshot.data.result.noHp,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    top: 7,
                                  ),
                                  child: Text('Alamat'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 7, bottom: 15),
                                  child: Text(
                                    snapshot.data.result.alamat,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    top: 7,
                                  ),
                                  child: Text('NPWP'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 15),
                                  child: Text(
                                    snapshot.data.result.npwp,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            child: RaisedButton(
                                elevation: 5.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.grey,
                                child: new Text('Update Profil',
                                    style: new TextStyle(
                                        fontSize: 16.0, color: Colors.white)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfilPage(
                                                baseAuth: widget.auth,
                                                responseGetUser:
                                                    responseGetUser,
                                              )));
                                }),
                          ),
                        ],
                      )
                    ],
                  );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<ResponseGetUser> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
//    ResponseGetUser responseGetUser = new ResponseGetUser();

    idMember = preferences.getString("id_member");
    String username = preferences.getString("remember_username");
    final response = await bravassProvider.getUserById(idMember);
//      print('Base64 ' + _base64Profile);
    if (response.status == 1) {
      return response;
    } else {
      throw Exception('Gagal Get data');
    }
  }

  Future _selectPage() async {
    switch (await showDialog(
        context: context,
        child: SimpleDialog(
          title: Text('Image From...'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Camera'),
              onPressed: () {
                Navigator.pop(context, Pages.CAMERA);
              },
            ),
            SimpleDialogOption(
              child: Text('Gallery'),
              onPressed: () {
                Navigator.pop(context, Pages.GALLERY);
              },
            ),
          ],
        ))) {
      case Pages.CAMERA:
        getImageFromCamera();
        break;
      case Pages.GALLERY:
        getImageFromGallery();
        break;
    }
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 20);
    _image = image;
    List imageBytes = image.readAsBytesSync();
    print('Image Bytes Gallery' + imageBytes.toString());
    String base64Image = base64Encode(imageBytes);
    BravassProvider bravassProvider = new BravassProvider();
    bravassProvider.updateFoto(idMember, _image).then((response) {
      Fluttertoast.showToast(
          msg: "Berhasil Update Foto", gravity: ToastGravity.BOTTOM);
      saveData(base64Image);
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    List imageBytes = image.readAsBytesSync();
    print('Image Bytes Gallery' + imageBytes.toString());
    String base64Image = base64Encode(imageBytes);

    _image = image;
    print('ImageFromGallery' + image.toString());
    print('BASE64 Gallery' + base64Image);
    print('BASE64 Gallery Length' + base64Image.length.toString());
    BravassProvider bravassProvider = new BravassProvider();
    bravassProvider.updateFoto(idMember, _image).then((response) {
      Fluttertoast.showToast(
          msg: "Berhasil Update Foto", gravity: ToastGravity.BOTTOM);
      saveData(base64Image);
    });
  }

  saveData(String value) async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    VoidCallback logoutCallback;
    setState(() {
      savedPref.setString("foto", value);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    auth: widget.auth,
                    logoutCallback: logoutCallback,
                  )));
    });
  }
}
