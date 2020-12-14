import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BankEvent extends Equatable {
  BankEvent();
}

class GetBank extends BankEvent {
  GetBank();

  @override
  List<Object> get props => [];
}

class UpdateBank extends BankEvent {
  Map<String, dynamic> body;

  UpdateBank({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}
