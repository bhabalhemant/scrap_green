import 'package:scrapgreen/models/response/pickup_request_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryBloc extends Bloc<HistoryEventBase, HistoryState> {
  HistoryBloc();

  @override
  HistoryState get initialState => Empty();

  @override
  Stream<HistoryState> mapEventToState(HistoryEventBase event) async* {
    if (event is HistoryEvent) {
      yield* _mapHistoryEvent(event);
    }
  }

  Stream<HistoryState> _mapHistoryEvent(HistoryEvent event) async* {
    yield HistoryLoading();
    try {
      ProfileResponse storedData =
          await Repository.instance.getStoredUserData();
      if (storedData != null && storedData.data.id != null) {
        PickUpRequestResponse response =
        await Repository.instance.getPickUpRequestData(storedData.data.id,event.startFrom);
        if (response.status) {
          yield HistoryLoaded(response: response);
        } else {
          yield HistoryError(msg: 'Failed to store user data!');
        }
      } else {
        yield HistoryError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield HistoryError(msg: e);
      } else {
        yield HistoryError(msg: '$e');
      }
    }
  }
}

abstract class HistoryEventBase extends Equatable {
  HistoryEventBase();
}

class HistoryEvent extends HistoryEventBase {
  final String startFrom;

  HistoryEvent({@required this.startFrom}) : assert(startFrom != null);

  @override
  List<Object> get props => [startFrom];
}

abstract class HistoryState extends Equatable {
  HistoryState();

  @override
  List<Object> get props => [];
}

class Empty extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final PickUpRequestResponse response;

  HistoryLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class HistoryError extends HistoryState {
  final String msg;

  HistoryError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
