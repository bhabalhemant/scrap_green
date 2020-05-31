import 'package:scrap_green/models/response/profile_response.dart';
import 'package:scrap_green/models/response/sign_in_response.dart';
import 'package:scrap_green/repository/repository.dart';
import 'package:scrap_green/utils/constants.dart' as Constants;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEventBase, SignInState> {
  SignInBloc();

  @override
  SignInState get initialState => Empty();

  @override
  Stream<SignInState> mapEventToState(SignInEventBase event) async* {
    if (event is SignInEvent) {
      yield* _mapSignInEvent(event);
    }
  }

  Stream<SignInState> _mapSignInEvent(SignInEvent event) async* {
    yield SignInLoading();
    try {
      SignInResponse response =
          await Repository.instance.attemptSignIn(event.body);
      if (response.status == true) {
        ProfileResponse profileResponse =
            await Repository.instance.getUserData(false,response.data.id);
        bool isStored =
            await Repository.instance.storeUserData(profileResponse.toJson());
        if (isStored) {
          yield SignInLoaded(response: response);
        } else {
          yield SignInError(msg: 'Failed to store data!');
        }
      } else {
        yield SignInError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield SignInError(msg: e);
      } else {
        yield SignInError(msg: '$e');
      }
    }
  }
}

abstract class SignInEventBase extends Equatable {
  SignInEventBase();
}

class SignInEvent extends SignInEventBase {
  Map<String, dynamic> body;

  SignInEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

abstract class SignInState extends Equatable {
  SignInState();

  @override
  List<Object> get props => [];
}

class Empty extends SignInState {}

class SignInLoading extends SignInState {}

class SignInLoaded extends SignInState {
  final SignInResponse response;

  SignInLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SignInError extends SignInState {
  final String msg;

  SignInError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
