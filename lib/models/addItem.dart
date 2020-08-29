class AddItem {
  String material;
  String quantity;
  String rupees;

  AddItem(this.material, this.quantity, this.rupees);

  AddItem.fromJson(Map<String, dynamic> json) {
    material = json['material'];
    quantity = json['quantity'];
    rupees = json['rupees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['material'] = this.material;
    data['quantity'] = this.quantity;
    data['rupees'] = this.rupees;
    return data;
  }
}
