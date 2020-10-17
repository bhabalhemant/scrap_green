import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/request_details_response.dart';
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
  final ProfileResponse response;

  RequestDetailsLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

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
