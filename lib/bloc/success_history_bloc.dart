import 'package:scrapgreen/models/response/pickup_request_success_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;

class SuccessHistoryBloc extends Bloc<SuccessHistoryEventBase, SuccessHistoryState> {
  SuccessHistoryBloc();

  @override
  SuccessHistoryState get initialState => Empty();

  @override
  Stream<SuccessHistoryState> mapEventToState(SuccessHistoryEventBase event) async* {
    if (event is SuccessHistoryEvent) {
      yield* _mapHistoryEvent(event);
    } else if (event is SuccessRequestIdEvent) {
      yield* _mapStoreRequestId(event);
    }
  }

  Stream<SuccessHistoryState> _mapHistoryEvent(SuccessHistoryEvent event) async* {
    yield SuccessHistoryLoading();
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
        PickUpRequestSuccessResponse response =
        await Repository.instance.getPickUpRequestSuccessData(params);
        if (response.status) {
          yield SuccessHistoryLoaded(response: response);
        } else {
          yield SuccessHistoryError(msg: response.msg);
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

  Stream<SuccessHistoryState> _mapStoreRequestId(SuccessRequestIdEvent event) async* {
    yield SuccessHistoryLoading();
    try {
      bool storedData = await Repository.instance.storeRequestId(event.body);
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

class SuccessRequestIdEvent extends SuccessHistoryEventBase {
  Map<String, dynamic> body;

  SuccessRequestIdEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
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
