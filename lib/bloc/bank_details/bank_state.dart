import 'package:scrapgreen/models/response/bank_details_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BankState extends Equatable {
  BankState();

  @override
  List<Object> get props => [];
}

class BankEmpty extends BankState {}

class BankLoading extends BankState {}

class BankUploading extends BankState {}

class BankLoaded extends BankState {
  final BankDetailsResponse response;

  BankLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

class BankError extends BankState {
  final String msg;

  BankError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
class BankUpdated extends BankState {
  final ProfileUpdateResponse response;

  BankUpdated({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}
