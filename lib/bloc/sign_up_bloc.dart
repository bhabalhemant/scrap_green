import 'package:dana/models/response/sign_up_response.dart';
import 'package:dana/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEventBase, SignUpState> {
  SignUpBloc();

  @override
  SignUpState get initialState => Empty();

  @override
  Stream<SignUpState> mapEventToState(SignUpEventBase event) async* {
    if (event is SignUpEvent) {
      yield* _mapSignUpEvent(event);
    } else if (event is FileSelectionEvent) {
      yield* _mapFileSelectionEvent(event);
    }
  }

  Stream<SignUpState> _mapSignUpEvent(SignUpEvent event) async* {
    yield SignUpLoading();
    try {
      SignUpResponse response =
          await Repository.instance.attemptSignUp(event.body);
      if (response.status == true) {
        yield SignUpLoaded(response: response);
      } else {
        yield SignUpError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield SignUpError(msg: e);
      } else {
        yield SignUpError(msg: '$e');
      }
    }
  }

  Stream<SignUpState> _mapFileSelectionEvent(FileSelectionEvent event) async* {
    if(event.path!=null&&event.path.isNotEmpty){
      yield FileSelected(path: event.path);
    }else{
      yield FileSelectionFailedState();
    }
  }
}

abstract class SignUpEventBase extends Equatable {
  SignUpEventBase();
}

class SignUpEvent extends SignUpEventBase {
  FormData body;

  SignUpEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class FileSelectionEvent extends SignUpEventBase {
  String path;

  FileSelectionEvent({@required this.path}) : assert(path != null);

  @override
  List<Object> get props => [path];
}

abstract class SignUpState extends Equatable {
  SignUpState();

  @override
  List<Object> get props => [];
}

class Empty extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {
  final SignUpResponse response;

  SignUpLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SignUpError extends SignUpState {
  final String msg;

  SignUpError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}

class FileSelected extends SignUpState {
  final String path;

  FileSelected({@required this.path}) : assert(path != null);

  @override
  List<Object> get props => [path];
}


class FileSelectionFailedState extends SignUpState {

  FileSelectionFailedState();

  @override
  List<Object> get props => [];
}