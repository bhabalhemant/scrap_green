import 'package:dana/models/response/profile_response.dart';
import 'package:dana/repository/repository.dart';
import 'package:dana/utils/constants.dart' as Constants;
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEventBase, SplashState> {
  SplashBloc();

  @override
  SplashState get initialState => Empty();

  @override
  Stream<SplashState> mapEventToState(SplashEventBase event) async* {
    if (event is SplashEvent) {
      yield* _mapSplashEvent(event);
    }
  }

  Stream<SplashState> _mapSplashEvent(SplashEvent event) async* {
    yield SplashLoading();
    try {
      ProfileResponse storedData =
      await Repository.instance.getStoredUserData();
      if (storedData != null && storedData.data.id != null) {
        Map<String, String> body = {Constants.PARAM_ID: storedData.data.id};
        ProfileResponse response = await Repository.instance.getUserData(body);
        bool isStored =
        await Repository.instance.storeUserData(response.toJson());
        if (isStored) {
          yield SplashLoaded(response: response);
        } else {
          yield SplashError(msg: 'Failed to store user data!');
        }
      } else {
        yield SplashError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield SplashError(msg: e);
      } else {
        yield SplashError(msg: '$e');
      }
    }
  }
}

abstract class SplashEventBase extends Equatable {
  SplashEventBase();
}

class SplashEvent extends SplashEventBase {
  SplashEvent();

  @override
  List<Object> get props => [];
}

abstract class SplashState extends Equatable {
  SplashState();

  @override
  List<Object> get props => [];
}

class Empty extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  final ProfileResponse response;

  SplashLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SplashError extends SplashState {
  final String msg;

  SplashError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
