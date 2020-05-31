import 'package:scrap_green/models/response/otp_verification_response.dart';
import 'package:scrap_green/models/response/resend_otp_response.dart';
import 'package:scrap_green/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc();

  @override
  OtpState get initialState => Empty();

  @override
  Stream<OtpState> mapEventToState(OtpEvent event) async* {
    if (event is OtpVerificationEvent) {
      yield* _mapOtpVerificationEvent(event);
    } else if (event is ResendOtpEvent) {
      yield* _mapResendOtpEvent(event);
    } else if (event is TimerStopEvent) {
      yield* _mapTimerStopEvent(event);
    }
  }

  Stream<OtpState> _mapOtpVerificationEvent(OtpVerificationEvent event) async* {
    yield OtpVerificationLoading();
    try {
      OtpVerificationResponse response =
          await Repository.instance.userOtpVerification(event.body);
      if (response.status) {
        yield OtpVerificationLoaded(response: response);
      } else {
        yield OtpVerificationError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield OtpVerificationError(msg: e);
      } else {
        yield OtpVerificationError(msg: '$e');
      }
    }
  }

  Stream<OtpState> _mapResendOtpEvent(ResendOtpEvent event) async* {
    yield ResendOtpLoading();
    try {
      ResendOtpResponse response =
          await Repository.instance.resendOtp(event.body);
      if (response.status) {
        yield ResendOtpLoaded(response: response);
      } else {
        yield ResendOtpError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield ResendOtpError(msg: e);
      } else {
        yield ResendOtpError(msg: '$e');
      }
    }
  }
  Stream<OtpState> _mapTimerStopEvent(TimerStopEvent event) async* {
    yield TimerStopState(flag: event.flag);
  }
}

abstract class OtpEvent extends Equatable {
  OtpEvent();
}

class OtpVerificationEvent extends OtpEvent {
  Map<String, dynamic> body;

  OtpVerificationEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class ResendOtpEvent extends OtpEvent {
  Map<String, dynamic> body;

  ResendOtpEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class TimerStopEvent extends OtpEvent {
  bool flag;

  TimerStopEvent({@required this.flag}) : assert(flag != null);

  @override
  List<Object> get props => [flag];
}


abstract class OtpState extends Equatable {
  OtpState();

  @override
  List<Object> get props => [];
}

class Empty extends OtpState {}

class OtpVerificationLoading extends OtpState {}

class OtpVerificationLoaded extends OtpState {
  final OtpVerificationResponse response;

  OtpVerificationLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class OtpVerificationError extends OtpState {
  final String msg;

  OtpVerificationError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}

class ResendOtpLoading extends OtpState {}

class ResendOtpLoaded extends OtpState {
  final ResendOtpResponse response;

  ResendOtpLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ResendOtpError extends OtpState {
  final String msg;

  ResendOtpError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}

class TimerStopState extends OtpState {
  final bool flag;

  TimerStopState({@required this.flag}) : assert(flag != null);

  @override
  List<Object> get props => [flag];
}
