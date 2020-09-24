import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProfileState extends Equatable {
  ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileEmpty extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUploading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileResponse response;

  ProfileLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

class ProfileError extends ProfileState {
  final String msg;

  ProfileError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
class ProfileUpdated extends ProfileState {
  final ProfileUpdateResponse response;

  ProfileUpdated({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}
