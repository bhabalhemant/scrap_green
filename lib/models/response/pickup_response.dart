class PickUpResponse {
  bool status;
  Data data;
  String msg;

  PickUpResponse({this.status, this.data, this.msg});

  PickUpResponse.fromJson(Map<String, dynamic> json) {
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
  String id;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String mobile;
  String aadharNumber;
  String panNumber;
  String address;

  Data(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.email,
        this.mobile,
        this.aadharNumber,
        this.panNumber,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    aadharNumber = json['aadhar_number'];
    panNumber = json['pan_number'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['aadhar_number'] = this.aadharNumber;
    data['pan_number'] = this.panNumber;
    data['address'] = this.address;
    return data;
  }
}
