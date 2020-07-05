import 'package:scrapgreen/models/response/forgot_password_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEventBase, ForgotPasswordStateBase> {
  ForgotPasswordBloc();

  @override
  ForgotPasswordStateBase get initialState => ForgotPasswordEmptyState();

  @override
  Stream<ForgotPasswordStateBase> mapEventToState(
      ForgotPasswordEventBase event) async* {
    if (event is ForgotPasswordEvent) {
      yield* _mapForgotPasswordEvent(event);
    }
  }

  Stream<ForgotPasswordStateBase> _mapForgotPasswordEvent(
      ForgotPasswordEvent event) async* {
    yield ForgotPasswordLoadingState();
    try {
      Map<String, String> body = {Constants.PARAM_MOBILE: event.mobileNo};
      ForgotPasswordResponse response =
          await Repository.instance.forgotPassword(body);
      if (response.status) {
        yield ForgotPasswordSuccessState(response: response);
      } else {
        yield ForgotPasswordErrorState(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield ForgotPasswordErrorState(msg: e);
      } else {
        yield ForgotPasswordErrorState(msg: '$e');
      }
    }
  }
}

//Events
abstract class ForgotPasswordEventBase extends Equatable {
  ForgotPasswordEventBase();
}

class ForgotPasswordEvent extends ForgotPasswordEventBase {
  final String mobileNo;

  ForgotPasswordEvent({@required this.mobileNo})
      : assert(mobileNo != null);

  @override
  List<Object> get props => [mobileNo];
}

//Events

//States
abstract class ForgotPasswordStateBase extends Equatable {
  ForgotPasswordStateBase();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmptyState extends ForgotPasswordStateBase {}

class ForgotPasswordLoadingState extends ForgotPasswordStateBase {}

class ForgotPasswordSuccessState extends ForgotPasswordStateBase {
  final ForgotPasswordResponse response;

  ForgotPasswordSuccessState({@required this.response})
      : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ForgotPasswordErrorState extends ForgotPasswordStateBase {
  final String msg;

  ForgotPasswordErrorState({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
