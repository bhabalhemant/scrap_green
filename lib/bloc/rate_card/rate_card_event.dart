import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RateCardEvent extends Equatable {
  RateCardEvent();
}

class GetRateCard extends RateCardEvent {
  GetRateCard();

  @override
  List<Object> get props => [];
}

class UpdateRateCard extends RateCardEvent {
  Map<String, dynamic> body;

  UpdateRateCard({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}
