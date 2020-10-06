import 'package:scrapgreen/models/response/pickup_request_assigned_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignedHistoryBloc extends Bloc<AssignedHistoryEventBase, AssignedHistoryState> {
  AssignedHistoryBloc();

  @override
  AssignedHistoryState get initialState => Empty();

  @override
  Stream<AssignedHistoryState> mapEventToState(AssignedHistoryEventBase event) async* {
    if (event is AssignedHistoryEvent) {
      yield* _mapHistoryEvent(event);
    }
  }

  Stream<AssignedHistoryState> _mapHistoryEvent(AssignedHistoryEvent event) async* {
    yield AssignedHistoryLoading();
    try {
      ProfileResponse storedData =
          await Repository.instance.getStoredUserData();
      if (storedData != null && storedData.data.id != null) {
        PickUpRequestAssignedResponse response =
        await Repository.instance.getPickUpRequestAssignedData(storedData.data.id,event.startFrom);
        if (response.status) {
          yield AssignedHistoryLoaded(response: response);
        } else {
          yield AssignedHistoryError(msg: 'Failed to store user data!');
        }
      } else {
        yield AssignedHistoryError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield AssignedHistoryError(msg: e);
      } else {
        yield AssignedHistoryError(msg: '$e');
      }
    }
  }
}

abstract class AssignedHistoryEventBase extends Equatable {
  AssignedHistoryEventBase();
}

class AssignedHistoryEvent extends AssignedHistoryEventBase {
  final String startFrom;

  AssignedHistoryEvent({@required this.startFrom}) : assert(startFrom != null);

  @override
  List<Object> get props => [startFrom];
}

abstract class AssignedHistoryState extends Equatable {
  AssignedHistoryState();

  @override
  List<Object> get props => [];
}

class Empty extends AssignedHistoryState {}

class AssignedHistoryLoading extends AssignedHistoryState {}

class AssignedHistoryLoaded extends AssignedHistoryState {
  final PickUpRequestAssignedResponse response;

  AssignedHistoryLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class AssignedHistoryError extends AssignedHistoryState {
  final String msg;

  AssignedHistoryError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
