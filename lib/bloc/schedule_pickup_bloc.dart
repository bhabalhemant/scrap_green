import 'package:scrapgreen/models/response/pickup_request_schedule_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePickupBloc extends Bloc<SchedulePickupEventBase, SchedulePickupState> {
  SchedulePickupBloc();

  @override
  SchedulePickupState get initialState => Empty();

  @override
  Stream<SchedulePickupState> mapEventToState(SchedulePickupEventBase event) async* {
    if (event is SchedulePickupEvent) {
      yield* _mapPickupEvent(event);
    }
  }

  Stream<SchedulePickupState> _mapPickupEvent(SchedulePickupEvent event) async* {
    yield SchedulePickupLoading();
    try {
      VendorProfileResponse storedData =
          await Repository.instance.getStoredVendorData();
      if (storedData != null && storedData.data.id != null) {
        PickUpRequestScheduleResponse response =
        await Repository.instance.getPickUpRequestScheduleData(storedData.data.id,event.startFrom);
        if (response.status) {
          yield SchedulePickupLoaded(response: response);
        } else {
          yield SchedulePickupError(msg: 'Failed to store user data!');
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
