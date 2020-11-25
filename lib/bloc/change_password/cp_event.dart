import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ChangePasswordEvent extends Equatable {
  ChangePasswordEvent();
}

class GetPassword extends ChangePasswordEvent {
  GetPassword();

  @override
  List<Object> get props => [];
}

class GetVendorId extends ChangePasswordEvent {
  GetVendorId();

  @override
  List<Object> get props => [];
}

class UpdatePassword extends ChangePasswordEvent {
  Map<String, dynamic> body;

  UpdatePassword({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class UpdateVendorPassword extends ChangePasswordEvent {
  Map<String, dynamic> body;

  UpdateVendorPassword({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}
