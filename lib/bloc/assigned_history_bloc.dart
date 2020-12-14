import 'package:scrapgreen/models/response/pickup_request_assigned_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;

class AssignedHistoryBloc extends Bloc<AssignedHistoryEventBase, AssignedHistoryState> {
  AssignedHistoryBloc();

  @override
  AssignedHistoryState get initialState => Empty();

  @override
  Stream<AssignedHistoryState> mapEventToState(AssignedHistoryEventBase event) async* {
    if (event is AssignedHistoryEvent) {
      yield* _mapHistoryEvent(event);
    } else if (event is AssignedRequestIdEvent) {
      yield* _mapStoreRequestId(event);
    }
  }

  Stream<AssignedHistoryState> _mapHistoryEvent(AssignedHistoryEvent event) async* {
    yield AssignedHistoryLoading();
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
        PickUpRequestAssignedResponse response =
        await Repository.instance.getPickUpRequestAssignedData(params);
        if (response.status) {
          yield AssignedHistoryLoaded(response: response);
        } else {
          yield AssignedHistoryError(msg: response.msg);
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

  Stream<AssignedHistoryState> _mapStoreRequestId(AssignedRequestIdEvent event) async* {
    print('yesss');
    yield AssignedHistoryLoading();
    try {
      bool storedData = await Repository.instance.storeRequestId(event.body);
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

class AssignedRequestIdEvent extends AssignedHistoryEventBase {
  Map<String, dynamic> body;

  AssignedRequestIdEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
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
