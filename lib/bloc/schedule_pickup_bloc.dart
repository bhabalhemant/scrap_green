import 'package:scrapgreen/models/response/pickup_request_schedule_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/models/response/request_id_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;

class SchedulePickupBloc extends Bloc<SchedulePickupEventBase, SchedulePickupState> {
  SchedulePickupBloc();

  @override
  SchedulePickupState get initialState => Empty();

  @override
  Stream<SchedulePickupState> mapEventToState(SchedulePickupEventBase event) async* {
    if (event is SchedulePickupEvent) {
      yield* _mapPickupEvent(event);
    } else if (event is StoreRequestIdEvent) {
      yield* _mapStoreRequestId(event);
    }
  }

  Stream<SchedulePickupState> _mapPickupEvent(SchedulePickupEvent event) async* {
    yield SchedulePickupLoading();
    try {
      VendorProfileResponse storedData =
      await Repository.instance.getStoredVendorData();
      if (storedData != null && storedData.data.id != null) {
        Map<String, String> params = {
          Constants.PARAM_VENDOR_ID: storedData.data.id,
          Constants.PARAM_START_FROM: event.startFrom,
          Constants.PARAM_REQUEST_STATUS: '0',
          Constants.PARAM_LIMIT: '30',
        };
        PickUpRequestScheduleResponse response =
        await Repository.instance.getPickUpRequestScheduleData(params);
        if (response.status) {
          yield SchedulePickupLoaded(response: response);
        } else {
          yield SchedulePickupError(msg: response.msg);
        }
      } else {
        yield SchedulePickupError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield SchedulePickupError(msg: e);
      } else {
        yield SchedulePickupError(msg: '$e');
      }
    }
  }

  Stream<SchedulePickupState> _mapStoreRequestId(StoreRequestIdEvent event) async* {
    yield SchedulePickupLoading();
    try {
      bool storedData = await Repository.instance.storeRequestId(event.body);
    } catch (e) {
      if (e is String) {
        yield SchedulePickupError(msg: e);
      } else {
        yield SchedulePickupError(msg: '$e');
      }
    }
  }
}

abstract class SchedulePickupEventBase extends Equatable {
  SchedulePickupEventBase();
}

class SchedulePickupEvent extends SchedulePickupEventBase {
  final String startFrom;

  SchedulePickupEvent({@required this.startFrom}) : assert(startFrom != null);

  @override
  List<Object> get props => [startFrom];
}

class StoreRequestIdEvent extends SchedulePickupEventBase {
  Map<String, dynamic> body;

  StoreRequestIdEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

abstract class SchedulePickupState extends Equatable {
  SchedulePickupState();

  @override
  List<Object> get props => [];
}

class Empty extends SchedulePickupState {}

class SchedulePickupLoading extends SchedulePickupState {}

class SchedulePickupLoaded extends SchedulePickupState {
  final PickUpRequestScheduleResponse response;

  SchedulePickupLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SchedulePickupError extends SchedulePickupState {
  final String msg;

  SchedulePickupError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}