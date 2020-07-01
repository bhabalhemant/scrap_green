class LocalNotification {
  String title;
  String body;
  String icon;
  LocalNotification(this.title, this.body, this.icon);

  LocalNotification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['icon'] = this.icon;
    return data;
  }
}
