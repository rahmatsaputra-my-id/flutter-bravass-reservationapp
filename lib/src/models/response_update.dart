class ResponseUpdateData {
  Null result;
  String message;
  int status;

  ResponseUpdateData({this.result, this.message, this.status});

  ResponseUpdateData.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['Status'] = this.status;
    return data;
  }
}
