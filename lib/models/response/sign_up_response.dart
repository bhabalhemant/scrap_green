class SignUpResponse {
  bool status;
  Data data;
  String msg;

  SignUpResponse({this.status,this.msg, this.data});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String emailKey;
  String mobile;
  String msg;

  Data({this.emailKey, this.mobile, this.msg});

  Data.fromJson(Map<String, dynamic> json) {
    emailKey = json['email_key'];
    mobile = json['mobile'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_key'] = this.emailKey;
    data['mobile'] = this.mobile;
    data['msg'] = this.msg;
    return data;
  }
}
