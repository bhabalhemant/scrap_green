import 'package:scrapgreen/models/response/pickup_request_schedule_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;


class ScheduleHistoryBloc extends Bloc<ScheduleHistoryEventBase, ScheduleHistoryState> {
  ScheduleHistoryBloc();

  @override
  ScheduleHistoryState get initialState => Empty();

  @override
  Stream<ScheduleHistoryState> mapEventToState(ScheduleHistoryEventBase event) async* {
    if (event is ScheduleHistoryEvent) {
      yield* _mapHistoryEvent(event);
    } else if (event is ScheduleRequestIdEvent) {
      yield* _mapStoreRequestId(event);
    }
  }

  Stream<ScheduleHistoryState> _mapHistoryEvent(ScheduleHistoryEvent event) async* {
    yield ScheduleHistoryLoading();
    try {
      ProfileResponse storedData =
          await Repository.instance.getStoredUserData();
      if (storedData != null && storedData.data.id != null) {
        Map<String, String> params = {
          Constants.PARAM_USER_ID: storedData.data.id,
          Constants.PARAM_START_FROM: event.startFrom,
          Constants.PARAM_REQUEST_STATUS: '0',
          Constants.PARAM_LIMIT: '30',
        };
        PickUpRequestScheduleResponse response =
        await Repository.instance.getPickUpRequestScheduleData(params);
        if (response.status) {
          yield ScheduleHistoryLoaded(response: response);
        } else {
          yield ScheduleHistoryError(msg: response.msg);
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

  Stream<ScheduleHistoryState> _mapStoreRequestId(ScheduleRequestIdEvent event) async* {
    yield ScheduleHistoryLoading();
    try {
      bool storedData = await Repository.instance.storeRequestId(event.body);
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

class ScheduleRequestIdEvent extends ScheduleHistoryEventBase {
  Map<String, dynamic> body;

  ScheduleRequestIdEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
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
