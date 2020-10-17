class MaterialItem {
  String id;
  String material;

  MaterialItem(this.id, this.material);

  MaterialItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    material = json['material'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['material'] = this.material;
    return data;
  }
}