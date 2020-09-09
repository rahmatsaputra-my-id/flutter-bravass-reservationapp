import 'package:bravass_development/src/models/response_get_user.dart';
import 'package:bravass_development/src/models/response_update.dart';
import 'package:bravass_development/src/resources/bravass_provider.dart';
import 'package:bravass_development/src/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilPage extends StatefulWidget {
  final BaseAuth baseAuth;
  final Future<ResponseGetUser> responseGetUser;

  EditProfilPage({Key key, this.baseAuth, this.responseGetUser})
      : super(key: key);

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  String id_member, password, status, foto, flag;

  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerAlamat = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerNik = new TextEditingController();
  TextEditingController controllerNoTelepon = new TextEditingController();
  TextEditingController controllerNpwp = new TextEditingController();

  ResponseUpdateData responseUpdate = ResponseUpdateData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id_member = "";
    password = "";
    status = "Aktif";
    foto = "";
    flag = "";
    controllerNama.text = "";
    controllerEmail.text = "";
    controllerNik.text = "";
    controllerNoTelepon.text = "";
    controllerAlamat.text = "";
    controllerUsername.text = "";
    controllerPassword.text = "";
    controllerNpwp.text = "";

    bool _validate = false;

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profil'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  controller: controllerUsername,
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Username",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  validator: (value) {},
                  onSaved: (String value) {
//        _loginData.email = value;
                  },
                ),
              ),
              textField('Nama', controllerNama),
              textFieldEmail('Email', controllerEmail),
              textFieldNomor('NIK', controllerNik),
              textFieldNomorTelepon('No Telepon', controllerNoTelepon),
              textField('Alamat', controllerAlamat),
              textField('NPWP', controllerNpwp),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    errorText: controllerPassword.text.isEmpty
                        ? 'Data Tidak Boleh Kosong'
                        : null,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  controller: controllerPassword,
                  validator: (value) {},
                  onSaved: (String value) {
//        _loginData.email = value;
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10),
                  child: SizedBox(
                    height: 30.0,
                    child: new RaisedButton(
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.grey,
                      child: new Text('Update Profil',
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.white)),
                      onPressed: () async {
                        if (controllerUsername.text.isEmpty ||
                            controllerNama.text.isEmpty ||
                            controllerEmail.text.isEmpty ||
                            controllerAlamat.text.isEmpty ||
                            controllerNik.text.isEmpty ||
                            controllerNoTelepon.text.isEmpty ||
                            controllerPassword.text.isEmpty ||
                            controllerNpwp.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Lengkapi Seluruh Data",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1);
                        } else {
                          if (!controllerEmail.text.contains('@') &&
                              !controllerEmail.text.contains('.')) {
                            Fluttertoast.showToast(
                                msg: "Email Tidak Sesuai dengan format",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1);
                          } else if (controllerNoTelepon.text.length < 10) {
                            Fluttertoast.showToast(
                                msg: "Nomor Telepon Minimal 10 Digit",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1);
                          } else if (controllerNik.text.length != 16) {
                            Fluttertoast.showToast(
                                msg: "NIK harus 16 Digit",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1);
                          } else {
                            BravassProvider bravassProvider = BravassProvider();
                            responseUpdate = await bravassProvider.updateUser(
                                id_member,
                                controllerUsername.text,
                                controllerPassword.text,
                                status,
                                controllerNik.text,
                                controllerNama.text,
                                controllerNoTelepon.text,
                                controllerEmail.text,
                                controllerAlamat.text,
                                flag,
                                controllerNpwp.text);
                            if (responseUpdate.status == 1) {
                              Fluttertoast.showToast(
                                  msg: "Berhasil Update Profil",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            auth: widget.baseAuth,
                                          )),
                                  ModalRoute.withName("/Home"));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Gagal Update Profil",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1);
                            }
                          }
                        }
                      },
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget textField(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
//        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          labelText: hintText,
          hintText: hintText,
          errorText: controller.text.isEmpty ? 'Data Tidak Boleh Kosong' : null,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        controller: controller,
        validator: (value) {},
        onSaved: (String value) {
//        _loginData.email = value;
        },
      ),
    );
//        (validateEmail(value));
  }

  Widget textFieldNomor(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
          labelText: hintText,
          hintText: hintText,
          errorText: controller.text.isEmpty ? 'Data Tidak Boleh Kosong' : null,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        controller: controller,
        validator: (value) {},
        onSaved: (String value) {
//        _loginData.email = value;
        },
      ),
    );
//        (validateEmail(value));
  }

  Widget textFieldNomorTelepon(
      String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        autofocus: false,
        decoration: InputDecoration(
          labelText: hintText,
          hintText: hintText,
          errorText: controller.text.isEmpty ? 'Data Tidak Boleh Kosong' : null,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        controller: controller,
        validator: (value) {},
        onSaved: (String value) {
//        _loginData.email = value;
        },
      ),
    );
//        (validateEmail(value));
  }

  Widget textFieldEmail(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          labelText: hintText,
          hintText: hintText,
          errorText: controller.text.isEmpty ? 'Data Tidak Boleh Kosong' : null,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        controller: controller,
        validator: (value) {},
        onSaved: (String value) {
//        _loginData.email = value;
        },
      ),
    );
//        (validateEmail(value));
  }

  Future<Null> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_member = preferences.getString("id_member");

      widget.responseGetUser.then((snapshot) {
        controllerNama.text = snapshot.result.namaMember;
        controllerEmail.text = snapshot.result.email;
        controllerNik.text = snapshot.result.nik;
        controllerNoTelepon.text = snapshot.result.noHp;
        controllerAlamat.text = snapshot.result.alamat;
        controllerUsername.text = snapshot.result.username;
        controllerPassword.text = snapshot.result.password;
        controllerNpwp.text = snapshot.result.npwp;
      });
    });
  }
}
