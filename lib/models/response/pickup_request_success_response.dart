class PickUpRequestSuccessResponse {
  bool status;
  List<Data3> data3;
  String msg;

  PickUpRequestSuccessResponse({this.status, this.data3, this.msg});

  PickUpRequestSuccessResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data3 = new List<Data3>();
      json['data'].forEach((v) {
        data3.add(new Data3.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data3 = new Map<String, dynamic>();
    data3['status'] = this.status;
    if (this.data3 != null) {
      data3['data'] = this.data3.map((v) => v.toJson()).toList();
    }
    data3['msg'] = this.msg;
//    print(data);
    return data3;
  }
}

class Data3 {
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

  Data3(
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

  Data3.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data3 = new Map<String, dynamic>();
    data3['id'] = this.id;
    data3['user_id'] = this.user_id;
    data3['name'] = this.name;
    data3['mobile'] = this.mobile;
    data3['address_line1'] = this.address_line1;
    data3['address_line2'] = this.address_line2;
    data3['country'] = this.country;
    data3['state'] = this.state;
    data3['city'] = this.city;
    data3['pin_code'] = this.pin_code;
    data3['latitude_longitude'] = this.latitude_longitude;
    data3['schedule_date_time'] = this.schedule_date_time;
    data3['request_status'] = this.request_status;
    data3['vendor_id'] = this.vendor_id;
    data3['pickup_date_time'] = this.pickup_date_time;
    data3['admin_status'] = this.admin_status;
    data3['warehouse_id'] = this.warehouse_id;
    data3['payment_status'] = this.payment_status;
    data3['payment_mode'] = this.payment_mode;
    data3['payment_txn_id'] = this.payment_txn_id;
    data3['total_amount'] = this.total_amount;
    data3['created_on'] = this.created_on;
    data3['created_by'] = this.created_by;
    data3['last_modified_by'] = this.last_modified_by;
    data3['last_modified_on'] = this.last_modified_on;
    return data3;
  }
}
