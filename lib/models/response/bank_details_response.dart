class BankDetailsResponse {
  bool status;
  Data data;
  String msg;

  BankDetailsResponse({this.status, this.data, this.msg});

  BankDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  String bank;
  String acc_no;
  String ifsc;
  String acc_type;
  String status;

  Data(
      {
        this.bank,
        this.acc_no,
        this.ifsc,
        this.acc_type,
        this.status,
      }
    );

  Data.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    acc_no = json['acc_no'];
    ifsc = json['ifsc'];
    acc_type = json['acc_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acc_type'] = this.acc_type;
    data['acc_no'] = this.acc_no;
    data['ifsc'] = this.ifsc;
    data['bank'] = this.bank;
    data['status'] = this.status;
    return data;
  }
}
