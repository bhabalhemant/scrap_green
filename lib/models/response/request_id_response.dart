class RequestIdResponse {
  String request_id;

  RequestIdResponse(this.request_id);

  RequestIdResponse.fromJson(Map<String, dynamic> json) {
    request_id = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.request_id;
    return data;
  }
}
