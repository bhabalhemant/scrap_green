import 'package:scrapgreen/models/response/otp_vendor_verification_response.dart';
import 'package:scrapgreen/models/response/resend_otp_vendor_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVendorBloc extends Bloc<OtpVendorEvent, OtpVendorState> {
  OtpVendorBloc();

  @override
  OtpVendorState get initialState => Empty();

  @override
  Stream<OtpVendorState> mapEventToState(OtpVendorEvent event) async* {
    if (event is OtpVendorVerificationEvent) {
      yield* _mapOtpVerificationEvent(event);
    } else if (event is ResendOtpVendorEvent) {
      yield* _mapResendOtpVendorEvent(event);
    } else if (event is TimerStopEvent) {
      yield* _mapTimerStopEvent(event);
    }
  }

  Stream<OtpVendorState> _mapOtpVerificationEvent(OtpVendorVerificationEvent event) async* {
    yield OtpVendorVerificationLoading();
    try {
      OtpVendorVerificationResponse response =
          await Repository.instance.vendorOtpVerification(event.body);
      if (response.status) {
        yield OtpVendorVerificationLoaded(response: response);
      } else {
        yield OtpVendorVerificationError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield OtpVendorVerificationError(msg: e);
      } else {
        yield OtpVendorVerificationError(msg: '$e');
      }
    }
  }

  Stream<OtpVendorState> _mapResendOtpVendorEvent(ResendOtpVendorEvent event) async* {
    yield ResendOtpVendorLoading();
    try {
      ResendOtpVendorResponse response =
          await Repository.instance.resendOtpVendor(event.body);
      if (response.status) {
        yield ResendOtpVendorLoaded(response: response);
      } else {
        yield ResendOtpVendorError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield ResendOtpVendorError(msg: e);
      } else {
        yield ResendOtpVendorError(msg: '$e');
      }
    }
  }
  Stream<OtpVendorState> _mapTimerStopEvent(TimerStopEvent event) async* {
    yield TimerStopState(flag: event.flag);
  }
}

abstract class OtpVendorEvent extends Equatable {
  OtpVendorEvent();
}

class OtpVendorVerificationEvent extends OtpVendorEvent {
  Map<String, dynamic> body;

  OtpVendorVerificationEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class ResendOtpVendorEvent extends OtpVendorEvent {
  Map<String, dynamic> body;

  ResendOtpVendorEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class TimerStopEvent extends OtpVendorEvent {
  bool flag;

  TimerStopEvent({@required this.flag}) : assert(flag != null);

  @override
  List<Object> get props => [flag];
}


abstract class OtpVendorState extends Equatable {
  OtpVendorState();

  @override
  List<Object> get props => [];
}

class Empty extends OtpVendorState {}

class OtpVendorVerificationLoading extends OtpVendorState {}

class OtpVendorVerificationLoaded extends OtpVendorState {
  final OtpVendorVerificationResponse response;

  OtpVendorVerificationLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class OtpVendorVerificationError extends OtpVendorState {
  final String msg;

  OtpVendorVerificationError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}

class ResendOtpVendorLoading extends OtpVendorState {}

class ResendOtpVendorLoaded extends OtpVendorState {
  final ResendOtpVendorResponse response;

  ResendOtpVendorLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ResendOtpVendorError extends OtpVendorState {
  final String msg;

  ResendOtpVendorError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}

class TimerStopState extends OtpVendorState {
  final bool flag;

  TimerStopState({@required this.flag}) : assert(flag != null);

  @override
  List<Object> get props => [flag];
}
