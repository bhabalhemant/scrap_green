import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scrapgreen/models/response/request_id_response.dart';

abstract class RequestDetailsEvent extends Equatable {
  RequestDetailsEvent();
}

class GetRequestDetails extends RequestDetailsEvent {
  GetRequestDetails();

  @override
  List<Object> get props => [];
}

class GetRequestDetailsItems extends RequestDetailsEvent {
  GetRequestDetailsItems();

  @override
  List<Object> get props => [];
}

class UpdateRequestDetails extends RequestDetailsEvent {
  Map<String, dynamic> body;

  UpdateRequestDetails({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class CompleteRequestDetails extends RequestDetailsEvent {
  Map<String, dynamic> body;

  CompleteRequestDetails({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class RemoveItemRequestDetails extends RequestDetailsEvent {
  Map<String, dynamic> body;

  RemoveItemRequestDetails({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class GetRequestDetailsEvent extends RequestDetailsEvent {
  GetRequestDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetVendorProfile extends RequestDetailsEvent {
  GetVendorProfile();

  @override
  List<Object> get props => [];
}