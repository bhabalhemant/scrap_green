import 'package:scrapgreen/models/response/rate_card_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RateCardState extends Equatable {
  RateCardState();

  @override
  List<Object> get props => [];
}

class RateCardEmpty extends RateCardState {}

class RateCardLoading extends RateCardState {}

class RateCardUploading extends RateCardState {}

class RateCardLoaded extends RateCardState {
  final RateCardResponse response;

  RateCardLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];

}

class RateCardError extends RateCardState {
  final String msg;

  RateCardError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
class RateCardUpdated extends RateCardState {
  final ProfileUpdateResponse response;

  RateCardUpdated({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}
