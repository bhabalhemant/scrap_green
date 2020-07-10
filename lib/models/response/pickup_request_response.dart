class PickUpRequestResponse {
  bool status;
  List<Data> data;
  String msg;

  PickUpRequestResponse({this.status, this.data, this.msg});

  PickUpRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    print(data);
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id; 
    data['user_id'] = this.user_id; 
    data['name'] = this.name; 
    data['mobile'] = this.mobile; 
    data['address_line1'] = this.address_line1; 
    data['address_line2'] = this.address_line2; 
    data['country'] = this.country; 
    data['state'] = this.state; 
    data['city'] = this.city; 
    data['pin_code'] = this.pin_code; 
    data['latitude_longitude'] = this.latitude_longitude; 
    data['schedule_date_time'] = this.schedule_date_time; 
    data['request_status'] = this.request_status; 
    data['vendor_id'] = this.vendor_id; 
    data['pickup_date_time'] = this.pickup_date_time; 
    data['admin_status'] = this.admin_status; 
    data['warehouse_id'] = this.warehouse_id; 
    data['payment_status'] = this.payment_status; 
    data['payment_mode'] = this.payment_mode; 
    data['payment_txn_id'] = this.payment_txn_id; 
    data['total_amount'] = this.total_amount; 
    data['created_on'] = this.created_on; 
    data['created_by'] = this.created_by; 
    data['last_modified_by'] = this.last_modified_by; 
    data['last_modified_on'] = this.last_modified_on; 
    print(data);
    return data;
  }
}
