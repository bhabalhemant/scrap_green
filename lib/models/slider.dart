class SliderItem {
  String logoPath;
  String title;
  String description;
  String subtitle;

  SliderItem(this.logoPath, this.title, this.description,this.subtitle);

  SliderItem.fromJson(Map<String, dynamic> json) {
    logoPath = json['logoPath'];
    title = json['title'];
    description = json['description'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logoPath'] = this.logoPath;
    data['title'] = this.title;
    data['description'] = this.description;
    data['subtitle'] = this.subtitle;
    return data;
  }
}
