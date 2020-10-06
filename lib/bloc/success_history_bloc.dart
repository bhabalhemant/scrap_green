import 'package:scrapgreen/models/response/pickup_request_success_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessHistoryBloc extends Bloc<SuccessHistoryEventBase, SuccessHistoryState> {
  SuccessHistoryBloc();

  @override
  SuccessHistoryState get initialState => Empty();

  @override
  Stream<SuccessHistoryState> mapEventToState(SuccessHistoryEventBase event) async* {
    if (event is SuccessHistoryEvent) {
      yield* _mapHistoryEvent(event);
    }
  }

  Stream<SuccessHistoryState> _mapHistoryEvent(SuccessHistoryEvent event) async* {
    yield SuccessHistoryLoading();
    try {
      ProfileResponse storedData =
          await Repository.instance.getStoredUserData();
      if (storedData != null && storedData.data.id != null) {
        PickUpRequestSuccessResponse response =
        await Repository.instance.getPickUpRequestSuccessData(storedData.data.id,event.startFrom);
        if (response.status) {
          yield SuccessHistoryLoaded(response: response);
        } else {
          yield SuccessHistoryError(msg: 'Failed to store user data!');
        }
      } else {
        yield SuccessHistoryError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield SuccessHistoryError(msg: e);
      } else {
        yield SuccessHistoryError(msg: '$e');
      }
    }
  }
}

abstract class SuccessHistoryEventBase extends Equatable {
  SuccessHistoryEventBase();
}

class SuccessHistoryEvent extends SuccessHistoryEventBase {
  final String startFrom;

  SuccessHistoryEvent({@required this.startFrom}) : assert(startFrom != null);

  @override
  List<Object> get props => [startFrom];
}

abstract class SuccessHistoryState extends Equatable {
  SuccessHistoryState();

  @override
  List<Object> get props => [];
}

class Empty extends SuccessHistoryState {}

class SuccessHistoryLoading extends SuccessHistoryState {}

class SuccessHistoryLoaded extends SuccessHistoryState {
  final PickUpRequestSuccessResponse response;

  SuccessHistoryLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SuccessHistoryError extends SuccessHistoryState {
  final String msg;

  SuccessHistoryError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
