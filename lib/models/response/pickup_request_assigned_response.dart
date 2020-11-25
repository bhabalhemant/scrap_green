class PickUpRequestAssignedResponse {
  bool status;
  List<Data2> data2;
  String msg;

  PickUpRequestAssignedResponse({this.status, this.data2, this.msg});

  PickUpRequestAssignedResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data2 = new List<Data2>();
      json['data'].forEach((v) {
        data2.add(new Data2.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data2 = new Map<String, dynamic>();
    data2['status'] = this.status;
    if (this.data2 != null) {
      data2['data'] = this.data2.map((v) => v.toJson()).toList();
    }
    data2['msg'] = this.msg;
//    print(data);
    return data2;
  }
}

class Data2 {
  String id;
  String user_id;
  String name;
  String mobile;
  String address_line1;
  String address_line2;
  String country;
  String state;
  String city;
  String pin_code;
  String latitude_longitude;
  String schedule_date_time;
  String request_status;
  String vendor_id;
  String pickup_date_time;
  String admin_status;
  String warehouse_id;
  String payment_status;
  String payment_mode;
  String payment_txn_id;
  String total_amount;
  String created_on;
  String created_by;
  String last_modified_by;
  String last_modified_on;

  Data2(
      {
        this.id,
        this.user_id,
        this.name,
        this.mobile,
        this.address_line1,
        this.address_line2,
        this.country,
        this.state,
        this.city,
        this.pin_code,
        this.latitude_longitude,
        this.schedule_date_time,
        this.request_status,
        this.vendor_id,
        this.pickup_date_time,
        this.admin_status,
        this.warehouse_id,
        this.payment_status,
        this.payment_mode,
        this.payment_txn_id,
        this.total_amount,
        this.created_on,
        this.created_by,
        this.last_modified_by,
        this.last_modified_on,
      }
      );

  Data2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    address_line1 = json['address_line1'];
    address_line2 = json['address_line2'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pin_code = json['pin_code'];
    latitude_longitude = json['latitude_longitude'];
    schedule_date_time = json['schedule_date_time'];
    request_status = json['request_status'];
    vendor_id = json['vendor_id'];
    pickup_date_time = json['pickup_date_time'];
    admin_status = json['admin_status'];
    warehouse_id = json['warehouse_id'];
    payment_status = json['payment_status'];
    payment_mode = json['payment_mode'];
    payment_txn_id = json['payment_txn_id'];
    total_amount = json['total_amount'];
    created_on = json['created_on'];
    created_by = json['created_by'];
    last_modified_by = json['last_modified_by'];
    last_modified_on = json['last_modified_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data2 = new Map<String, dynamic>();
    data2['id'] = this.id;
    data2['user_id'] = this.user_id;
    data2['name'] = this.name;
    data2['mobile'] = this.mobile;
    data2['address_line1'] = this.address_line1;
    data2['address_line2'] = this.address_line2;
    data2['country'] = this.country;
    data2['state'] = this.state;
    data2['city'] = this.city;
    data2['pin_code'] = this.pin_code;
    data2['latitude_longitude'] = this.latitude_longitude;
    data2['schedule_date_time'] = this.schedule_date_time;
    data2['request_status'] = this.request_status;
    data2['vendor_id'] = this.vendor_id;
    data2['pickup_date_time'] = this.pickup_date_time;
    data2['admin_status'] = this.admin_status;
    data2['warehouse_id'] = this.warehouse_id;
    data2['payment_status'] = this.payment_status;
    data2['payment_mode'] = this.payment_mode;
    data2['payment_txn_id'] = this.payment_txn_id;
    data2['total_amount'] = this.total_amount;
    data2['created_on'] = this.created_on;
    data2['created_by'] = this.created_by;
    data2['last_modified_by'] = this.last_modified_by;
    data2['last_modified_on'] = this.last_modified_on;
    return data2;
  }
}