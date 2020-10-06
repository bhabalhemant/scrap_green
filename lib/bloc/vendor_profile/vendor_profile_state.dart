import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class VendorProfileState extends Equatable {
  VendorProfileState();

  @override
  List<Object> get props => [];
}

class VendorProfileEmpty extends VendorProfileState {}

class VendorProfileLoading extends VendorProfileState {}

class VendorProfileUploading extends VendorProfileState {}

class VendorProfileLoaded extends VendorProfileState {
  final VendorProfileResponse response;

  VendorProfileLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

class VendorProfileError extends VendorProfileState {
  final String msg;

  VendorProfileError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
//class VendorProfileUpdated extends VendorProfileState {
//  final VendorProfileUpdateResponse response;
//
//  VendorProfileUpdated({@required this.response}) : assert(response != null);
//
//  @override
//  List<Object> get props => [response];
//}
