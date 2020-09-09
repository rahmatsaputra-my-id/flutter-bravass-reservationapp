import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bravass_development/src/models/invoice_model.dart';
import 'package:bravass_development/src/models/login__model.dart';
import 'package:bravass_development/src/models/response_get_user.dart';
import 'package:bravass_development/src/models/response_update.dart';
import 'package:bravass_development/src/models/room_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

abstract class BaseAuth {
  Future<LoginResponse> signIn(
      String username, String password, bool isRemember);

  Future<String> getCurrentUser();

  Future<void> signOut();

  Future<ResponseUpdateData> updateUser(
      String id_member,
      String username,
      String password,
      String status,
      String nik,
      String nama_member,
      String no_hp,
      String email,
      String alamat,
      String flag,
      String npwp);

  Future<ResponseUpdateData> updateFoto(String id_member, File imageFile);

  Future<ResponseGetUser> getUserById(String id_member);
}

class BravassProvider implements BaseAuth {
  final _baseUrl = "http://ugsistem.com:8090/";

  Future<InvoiceModel> getInvoice(String idMember) async {
    final response = await http
        .get(_baseUrl + 'invoice/get_user_invoice?id_member=' + idMember);
    print('URL BRO ' +
        _baseUrl +
        'invoice/get_user_invoice?id_member=' +
        idMember);
    print('RESPONSENYA' + response.body.toString());

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return InvoiceModel.fromJson(responseJson);
    } else {
      throw Exception('Error bro ' + response.body.toString());
    }
  }

//  ==========================================================================================================
//                         GET DATA  GET DATA GET DATA GET DATA GET DATA GET DATA GET DATA GET DATA
//  ==========================================================================================================

  Future<RoomModel> getRoom() async {
    final response = await http.get(_baseUrl + 'room/get_room_mobile');
    print('RESPONSENYA' + response.body.toString());

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return RoomModel.fromJson(responseJson);
    } else {
      throw Exception('Error bro ' + response.body.toString());
    }
  }

  @override
  Future<ResponseGetUser> getUserById(String id_member) async {
    final response = await http
        .get(_baseUrl + "member/get_id_member?id_member=" + id_member);
    print('RESPONSENYA' + response.body.toString());

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return ResponseGetUser.fromJson(responseJson);
    } else {
      throw Exception('Error bro ' + response.body.toString());
    }
  }

  @override
  Future<String> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('nik');
    return stringValue;
  }

  @override
  Future<LoginResponse> signIn(
      String username, String password, bool isRemember) async {
    final response = await http.get(_baseUrl +
        "member/get_authentication_member?username=$username&password=$password");
    LoginResponse loginResponse = LoginResponse();
    loginResponse =
        LoginResponse.fromJson(json.decode(response.body.toString()));

    if (response.statusCode == 200 && loginResponse.result != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id_member', loginResponse.result.idMember);
      prefs.setString('username', loginResponse.result.username);
      prefs.setString('password', loginResponse.result.password);
      prefs.setString('status', loginResponse.result.status);
      prefs.setString('nik', loginResponse.result.nik);
      prefs.setString('nama_member', loginResponse.result.namaMember);
      prefs.setString('no_hp', loginResponse.result.noHp);
      prefs.setString('email', loginResponse.result.email);
      prefs.setString('alamat', loginResponse.result.alamat);
      prefs.setString('foto', loginResponse.result.foto);
      prefs.setString('flag', loginResponse.result.flag);
      prefs.setString('npwp', loginResponse.result.npwp);

      if (isRemember) {
        prefs.setString("remember_username", username);
        prefs.setString("remember_password", password);
        print("ISREMEMBER");
      } else {
        prefs.setString("remember_username", "");
        prefs.setString("remember_password", "");
      }

      return loginResponse;
    } else if (loginResponse == null) {
      throw Exception('Invalid Username/Password');
    } else {
      throw Exception('Invalid Username/Password');
    }
  }

  @override
  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id_member');
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('status');
    prefs.remove('nik');
    prefs.remove('nama_member');
    prefs.remove('no_hp');
    prefs.remove('email');
    prefs.remove('alamat');
    prefs.remove('foto');
    prefs.remove('flag');
    prefs.remove('npwp');
  }

  @override
  Future<ResponseUpdateData> updateUser(
      String id_member,
      String username,
      String password,
      String status,
      String nik,
      String nama_member,
      String no_hp,
      String email,
      String alamat,
      String flag,
      String npwp) async {
    final response = await http.put(_baseUrl +
        "member/update_member?id_member=$id_member"
            "&username=$username&password=$password&status=$status&nik=$nik&nama_member="
            "$nama_member&no_hp=$no_hp&email=$email&alamat=$alamat"
            "&flag=$flag&npwp=$npwp");
    print(_baseUrl +
        "member/update_member?id_member=$id_member"
            "&username=$username&password=$password&status=$status&nik=$nik&nama_member="
            "$nama_member&no_hp=$no_hp&email=$email&alamat=$alamat"
            "&flag=$flag");
    print(response.body.toString());
    ResponseUpdateData responseUpdateData = ResponseUpdateData();
    print(response.body.toString());
    responseUpdateData =
        ResponseUpdateData.fromJson(json.decode(response.body.toString()));

    print('REsponse Code ' + response.statusCode.toString());

    if (response.statusCode == 200 && responseUpdateData.status == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id_member', id_member);
      prefs.setString('username', username);
      prefs.setString('password', password);
      prefs.setString('status', status);
      prefs.setString('nik', nik);
      prefs.setString('nama_member', nama_member);
      prefs.setString('no_hp', no_hp);
      prefs.setString('email', email);
      prefs.setString('alamat', alamat);
      prefs.setString('npwp', npwp);

      prefs.setString('flag', flag);
      return responseUpdateData;
    } else {
      throw Exception('Gagal Update');
    }
  }

  @override
  Future<ResponseUpdateData> updateFoto(
      String id_member, File imageFile) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(
        _baseUrl + "member/update_foto_member?id_member=" + id_member);

    // create multipart request
    var request = new http.MultipartRequest("PUT", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('foto', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
