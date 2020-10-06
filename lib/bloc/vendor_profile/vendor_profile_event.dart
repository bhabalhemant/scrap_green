import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class VendorProfileEvent extends Equatable {
  VendorProfileEvent();
}

class GetProfile extends VendorProfileEvent {
  GetProfile();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends VendorProfileEvent {
  Map<String, dynamic> body;

  UpdateProfile({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}
