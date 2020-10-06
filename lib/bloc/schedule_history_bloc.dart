import 'package:scrapgreen/models/response/pickup_request_schedule_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleHistoryBloc extends Bloc<ScheduleHistoryEventBase, ScheduleHistoryState> {
  ScheduleHistoryBloc();

  @override
  ScheduleHistoryState get initialState => Empty();

  @override
  Stream<ScheduleHistoryState> mapEventToState(ScheduleHistoryEventBase event) async* {
    if (event is ScheduleHistoryEvent) {
      yield* _mapHistoryEvent(event);
    }
  }

  Stream<ScheduleHistoryState> _mapHistoryEvent(ScheduleHistoryEvent event) async* {
    yield ScheduleHistoryLoading();
    try {
      ProfileResponse storedData =
          await Repository.instance.getStoredUserData();
      if (storedData != null && storedData.data.id != null) {
        PickUpRequestScheduleResponse response =
        await Repository.instance.getPickUpRequestScheduleData(storedData.data.id,event.startFrom);
        if (response.status) {
          yield ScheduleHistoryLoaded(response: response);
        } else {
          yield ScheduleHistoryError(msg: 'Failed to store user data!');
        }
      } else {
        yield ScheduleHistoryError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield ScheduleHistoryError(msg: e);
      } else {
        yield ScheduleHistoryError(msg: '$e');
      }
    }
  }
}

abstract class ScheduleHistoryEventBase extends Equatable {
  ScheduleHistoryEventBase();
}

class ScheduleHistoryEvent extends ScheduleHistoryEventBase {
  final String startFrom;

  ScheduleHistoryEvent({@required this.startFrom}) : assert(startFrom != null);

  @override
  List<Object> get props => [startFrom];
}

abstract class ScheduleHistoryState extends Equatable {
  ScheduleHistoryState();

  @override
  List<Object> get props => [];
}

class Empty extends ScheduleHistoryState {}

class ScheduleHistoryLoading extends ScheduleHistoryState {}

class ScheduleHistoryLoaded extends ScheduleHistoryState {
  final PickUpRequestScheduleResponse response;

  ScheduleHistoryLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ScheduleHistoryError extends ScheduleHistoryState {
  final String msg;

  ScheduleHistoryError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
