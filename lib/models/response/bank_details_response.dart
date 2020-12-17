class BankDetailsResponse {
  bool status;
  Data data1;
  String msg;

  BankDetailsResponse({this.status, this.data1, this.msg});

  BankDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data1 = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data1 = new Map<String, dynamic>();
    data1['status'] = this.status;
    if (this.data1 != null) {
      data1['data'] = this.data1.toJson();
    }
    data1['msg'] = this.msg;
    return data1;
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
    final Map<String, dynamic> data1 = new Map<String, dynamic>();
    data1['acc_type'] = this.acc_type;
    data1['acc_no'] = this.acc_no;
    data1['ifsc'] = this.ifsc;
    data1['bank'] = this.bank;
    data1['status'] = this.status;
    return data1;
  }
}
