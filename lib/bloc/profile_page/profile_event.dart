import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent();
}

class GetProfile extends ProfileEvent {
  GetProfile();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends ProfileEvent {
  Map<String, dynamic> body;

  UpdateProfile({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}
