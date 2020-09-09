class LoginResponse {
  Result result;
  String message;
  int status;

  LoginResponse({this.result, this.message, this.status});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    message = json['message'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['message'] = this.message;
    data['Status'] = this.status;
    return data;
  }
}

class Result {
  String idMember;
  String username;
  String password;
  String status;
  String nik;
  String namaMember;
  String noHp;
  String email;
  String alamat;
  String foto;
  String flag;
  String npwp;

  Result(
      {this.idMember,
      this.username,
      this.password,
      this.status,
      this.nik,
      this.namaMember,
      this.noHp,
      this.email,
      this.alamat,
      this.foto,
      this.flag,
      this.npwp});

  Result.fromJson(Map<String, dynamic> json) {
    idMember = json['id_member'];
    username = json['username'];
    password = json['password'];
    status = json['status'];
    nik = json['nik'];
    namaMember = json['nama_member'];
    noHp = json['no_hp'];
    email = json['email'];
    alamat = json['alamat'];
    foto = json['foto'];
    flag = json['flag'];
    npwp = json['npwp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_member'] = this.idMember;
    data['username'] = this.username;
    data['password'] = this.password;
    data['status'] = this.status;
    data['nik'] = this.nik;
    data['nama_member'] = this.namaMember;
    data['no_hp'] = this.noHp;
    data['email'] = this.email;
    data['alamat'] = this.alamat;
    data['foto'] = this.foto;
    data['flag'] = this.flag;
    data['npwp'] = this.npwp;

    return data;
  }
}
