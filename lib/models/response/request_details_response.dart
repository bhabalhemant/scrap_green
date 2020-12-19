class RequestDetailsResponse {
  bool status;
  Data data;
  String amount;
  List<Data1> data1;
  String msg;

  RequestDetailsResponse({this.status, this.data, this.data1,  this.msg});

  RequestDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['data1'] != null) {
      data1 = new List<Data1>();
      json['data1'].forEach((v) {
        data1.add(new Data1.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final Map<String, dynamic> data1 = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.data1 != null) {
      data['data1'] = this.data1.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
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
  String amount;


  Data({
        this.id,
        this.name,
        this.user_id,
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
        this.amount,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    user_id = json['user_id'];
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
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.user_id;
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
    data['amount'] = this.amount;
    return data;
  }
}

class Data1 {
  String id;
  String request_id;
  String material_id;
  String material_name;
  String unit;
  String unit_qty;
  String rate;
  String amount;
  String created_by;
  String created_on;
  String last_modified_by;
  String last_modified_on;

  Data1({
    this.id,
    this.request_id,
    this.material_id,
    this.material_name,
    this.unit,
    this.unit_qty,
    this.rate,
    this.amount,
    this.created_by,
    this.created_on,
    this.last_modified_by,
    this.last_modified_on,
  });

  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    request_id = json['request_id'];
    material_id = json['material_id'];
    material_name = json['material_name'];
    unit = json['unit'];
    unit_qty = json['unit_qty'];
    rate = json['rate'];
    amount = json['amount'];
    created_by = json['created_by'];
    created_on = json['created_on'];
    last_modified_by = json['last_modified_by'];
    last_modified_on = json['last_modified_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data1 = new Map<String, dynamic>();
    data1['id'] = this.id;
    data1['request_id'] = this.request_id;
    data1['material_id'] = this.material_id;
    data1['material_name'] = this.material_name;
    data1['unit'] = this.unit;
    data1['unit_qty'] = this.unit_qty;
    data1['rate'] = this.rate;
    data1['amount'] = this.amount;
    data1['created_by'] = this.created_by;
    data1['created_on'] = this.created_on;
    data1['last_modified_by'] = this.last_modified_by;
    data1['last_modified_on'] = this.last_modified_on;
    return data1;
  }
}
