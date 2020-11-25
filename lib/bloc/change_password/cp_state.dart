import 'package:scrapgreen/models/response/password_response.dart';
import 'package:scrapgreen/models/response/password_update_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';

abstract class ChangePasswordState extends Equatable {
  ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordEmpty extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordUploading extends ChangePasswordState {}

class ChangePasswordLoaded extends ChangePasswordState {
  final PasswordResponse response;

  ChangePasswordLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

class VendorIdLoaded extends ChangePasswordState {
  final PasswordResponse response;

  VendorIdLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

class ChangePasswordError extends ChangePasswordState {
  final String msg;

  ChangePasswordError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
class PasswordUpdated extends ChangePasswordState {
  final PasswordUpdateResponse response;

  PasswordUpdated({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}
