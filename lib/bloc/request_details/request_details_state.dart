//import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/complete_request_details_response.dart';
import 'package:scrapgreen/models/response/request_details_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RequestDetailsState extends Equatable {
  RequestDetailsState();

  @override
  List<Object> get props => [];
}

class RequestDetailsEmpty extends RequestDetailsState {}

class RequestDetailsLoading extends RequestDetailsState {}

class RequestDetailsloading extends RequestDetailsState {}

class RequestDetailsLoaded extends RequestDetailsState {
  final RequestDetailsResponse response;

  RequestDetailsLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

//class RequestDetailsItemLoaded extends RequestDetailsState {
//  final DisplayItemsResponse response1;
//
//  RequestDetailsItemLoaded({@required this.response1}) : assert(response1 != null);
//
//  @override
//  List<Object> get props => [response1];
//
//}

class RequestDetailsError extends RequestDetailsState {
  final String msg;

  RequestDetailsError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
class RequestDetailsUpdated extends RequestDetailsState {
  final RequestDetailsResponse response;

  RequestDetailsUpdated({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class RequestDetailsComplete extends RequestDetailsState {
  final CompleteRequestDetailsResponse response;

  RequestDetailsComplete({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class RequestDetailsItemRemoved extends RequestDetailsState {
  final CompleteRequestDetailsResponse response;

  RequestDetailsItemRemoved({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class VendorProfileeEmpty extends RequestDetailsState {}

class VendorProfileeLoading extends RequestDetailsState {}

class VendorProfileeUploading extends RequestDetailsState {}

class VendorProfileeLoaded extends RequestDetailsState {
  final VendorProfileResponse response;

  VendorProfileeLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

class VendorProfileeError extends RequestDetailsState {
  final String msg;

  VendorProfileeError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
