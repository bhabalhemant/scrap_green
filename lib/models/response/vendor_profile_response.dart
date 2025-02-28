class VendorProfileResponse {
  bool status;
  Data data;
  String msg;

  VendorProfileResponse({this.status, this.data, this.msg});

  VendorProfileResponse.fromJson(Map<String, dynamic> json) {
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
    print(data);
    return data;
  }
}

class Data {
  String id;
  String name;
  String email;
  String mobile;
  String address_line1;
  String address_line2;
  String country;
  String state;
  String city;
  String pin_code;
  String logo;
  String logo_original;

  Data({
        this.id,
        this.name,
        this.email,
        this.mobile,
        this.address_line1,
        this.address_line2,
        this.country,
        this.state,
        this.city,
        this.pin_code,
        this.logo,
        this.logo_original,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address_line1 = json['address_line1'];
    address_line2 = json['address_line2'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pin_code = json['pin_code'];
    logo = json['logo'];
    logo_original = json['logo_original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address_line1'] = this.address_line1;
    data['address_line2'] = this.address_line2;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pin_code'] = this.pin_code;
    data['logo'] = this.logo;
    data['logo_original'] = this.logo_original;
    return data;
  }
}
