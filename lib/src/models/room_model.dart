class RoomModel {
  List<Result> result;
  String message;
  int status;

  RoomModel({this.result, this.message, this.status});

  RoomModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    message = json['message'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['Status'] = this.status;
    return data;
  }
}

class Result {
  String idRoom;
  String description;
  String room;
  String foto;

  Result({this.idRoom, this.description, this.room, this.foto});

  Result.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    description = json['description'];
    room = json['room'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_room'] = this.idRoom;
    data['description'] = this.description;
    data['room'] = this.room;
    data['foto'] = this.foto;
    return data;
  }
}
