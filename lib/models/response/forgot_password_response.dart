class ForgotPasswordResponse {
  bool status;
  Data data;
  String msg = '';

  ForgotPasswordResponse({this.status, this.data, this.msg});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  String emailKey;

  Data({this.emailKey});

  Data.fromJson(Map<String, dynamic> json) {
    emailKey = json['email_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_key'] = this.emailKey;
    return data;
  }
}
