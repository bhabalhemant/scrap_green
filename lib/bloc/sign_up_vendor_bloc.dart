import 'package:scrapgreen/models/response/sign_up_vendor_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpVendorBloc extends Bloc<SignUpVendorEventBase, SignUpVendorState> {
  SignUpVendorBloc();

  @override
  SignUpVendorState get initialState => Empty();

  @override
  Stream<SignUpVendorState> mapEventToState(SignUpVendorEventBase event) async* {
    if (event is SignUpVendorEvent) {
      yield* _mapSignUpVendorEvent(event);
    } else if (event is FileSelectionEvent) {
      yield* _mapFileSelectionEvent(event);
    }
  }

  Stream<SignUpVendorState> _mapSignUpVendorEvent(SignUpVendorEvent event) async* {
    yield SignUpVendorLoading();
    try {
      SignUpVendorResponse response =
          await Repository.instance.attemptSignUpVendor(event.body);
      if (response.status == true) {
        yield SignUpVendorLoaded(response: response);
      } else {
        yield SignUpVendorError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield SignUpVendorError(msg: e);
      } else {
        yield SignUpVendorError(msg: '$e');
      }
    }
  }

  Stream<SignUpVendorState> _mapFileSelectionEvent(FileSelectionEvent event) async* {
    if(event.path!=null&&event.path.isNotEmpty){
      yield FileSelected(path: event.path);
    }else{
      yield FileSelectionFailedState();
    }
  }
}

abstract class SignUpVendorEventBase extends Equatable {
  SignUpVendorEventBase();
}

class SignUpVendorEvent extends SignUpVendorEventBase {
  FormData body;

  SignUpVendorEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

class FileSelectionEvent extends SignUpVendorEventBase {
  String path;

  FileSelectionEvent({@required this.path}) : assert(path != null);

  @override
  List<Object> get props => [path];
}

abstract class SignUpVendorState extends Equatable {
  SignUpVendorState();

  @override
  List<Object> get props => [];
}

class Empty extends SignUpVendorState {}

class SignUpVendorLoading extends SignUpVendorState {}

class SignUpVendorLoaded extends SignUpVendorState {
  final SignUpVendorResponse response;

  SignUpVendorLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SignUpVendorError extends SignUpVendorState {
  final String msg;

  SignUpVendorError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}

class FileSelected extends SignUpVendorState {
  final String path;

  FileSelected({@required this.path}) : assert(path != null);

  @override
  List<Object> get props => [path];
}


class FileSelectionFailedState extends SignUpVendorState {

  FileSelectionFailedState();

  @override
  List<Object> get props => [];
}