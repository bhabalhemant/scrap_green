//class DisplayItemsResponse {
//  bool status;
//  List<Data1> data1;
//  String msg;
//
//  DisplayItemsResponse({this.status, this.data1, this.msg});
//
//  DisplayItemsResponse.fromJson(Map<String, dynamic> json) {
//    status = json['status'];
//    if (json['data'] != null) {
//      data1 = new List<Data1>();
//      json['data'].forEach((v) {
//        data1.add(new Data1.fromJson(v));
//      });
//    }
//    msg = json['msg'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data1 = new Map<String, dynamic>();
//    data1['status'] = this.status;
//    if (this.data1 != null) {
//      data1['data'] = this.data1.map((v) => v.toJson()).toList();
//    }
//    data1['msg'] = this.msg;
//    return data1;
//  }
//}
//
//class Data1 {
//  String id;
//  String request_id;
//  String material_id;
//  String unit;
//  String unit_qty;
//  String rate;
//  String amount;
//  String created_by;
//  String created_on;
//  String last_modified_by;
//  String last_modified_on;
//
//  Data1({
//        this.id,
//        this.request_id,
//        this.material_id,
//        this.unit,
//        this.unit_qty,
//        this.rate,
//        this.amount,
//        this.created_by,
//        this.created_on,
//        this.last_modified_by,
//        this.last_modified_on,
//      });
//
//  Data1.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    request_id = json['request_id'];
//    material_id = json['material_id'];
//    unit = json['unit'];
//    unit_qty = json['unit_qty'];
//    rate = json['rate'];
//    amount = json['amount'];
//    created_by = json['created_by'];
//    created_on = json['created_on'];
//    last_modified_by = json['last_modified_by'];
//    last_modified_on = json['last_modified_on'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data1 = new Map<String, dynamic>();
//    data1['id'] = this.id;
//    data1['request_id'] = this.request_id;
//    data1['material_id'] = this.material_id;
//    data1['unit'] = this.unit;
//    data1['unit_qty'] = this.unit_qty;
//    data1['rate'] = this.rate;
//    data1['amount'] = this.amount;
//    data1['created_by'] = this.created_by;
//    data1['created_on'] = this.created_on;
//    data1['last_modified_by'] = this.last_modified_by;
//    data1['last_modified_on'] = this.last_modified_on;
//    return data1;
//  }
//}
