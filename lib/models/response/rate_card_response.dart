class RateCardResponse {
  bool status;
  List<Data> data;
  String msg;

  RateCardResponse({this.status, this.data, this.msg});

  RateCardResponse.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Data {
  String id;
  String icon;
  String icon_original;
  String material;
  String unit;
  String unit_qty;
  String rate;
  String status;
  String created_on;
  String created_by;
  String last_modified_on;
  String last_modified_by;

  Data(
      {
        this.id,
        this.icon,
        this.icon_original,
        this.material,
        this.unit,
        this.unit_qty,
        this.rate,
        this.status,
        this.created_on,
        this.created_by,
        this.last_modified_on,
        this.last_modified_by
      }
      );

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    icon_original = json['icon_original'];
    material = json['material'];
    unit = json['unit'];
    unit_qty = json['unit_qty'];
    rate = json['rate'];
    status = json['status'];
    created_on = json['created_on'];
    created_by = json['created_by'];
    last_modified_on = json['last_modified_on'];
    last_modified_by = json['last_modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['icon_original'] = this.icon_original;
    data['material'] = this.material;
    data['unit'] = this.unit;
    data['unit_qty'] = this.unit_qty;
    data['rate'] = this.rate;
    data['status'] = this.status;
    data['created_on'] = this.created_on;
    data['created_by'] = this.created_by;
    data['last_modified_on'] = this.last_modified_on;
    data['last_modified_by'] = this.last_modified_by;
    return data;
  }
}
