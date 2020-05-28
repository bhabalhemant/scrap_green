class Arguments {
  String id;
  String name;
  String logo;
  String description;
  String mobile;
  String email;
  String address;

  Arguments(this.id, this.name, this.logo);

  Arguments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    description = json['description'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    return data;
  }
}
