import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RequestDetailsEvent extends Equatable {
  RequestDetailsEvent();
}

class GetRequestDetails extends RequestDetailsEvent {
  GetRequestDetails();

  @override
  List<Object> get props => [];
}

class UpdateRequestDetails extends RequestDetailsEvent {
  Map<String, dynamic> body;

  UpdateRequestDetails({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}
