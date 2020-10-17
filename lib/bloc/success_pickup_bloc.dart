import 'package:scrapgreen/models/response/pickup_request_success_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessPickupBloc extends Bloc<SuccessPickupEventBase, SuccessPickupState> {
  SuccessPickupBloc();

  @override
  SuccessPickupState get initialState => Empty();

  @override
  Stream<SuccessPickupState> mapEventToState(SuccessPickupEventBase event) async* {
    if (event is SuccessPickupEvent) {
      yield* _mapPickupEvent(event);
    }
  }

  Stream<SuccessPickupState> _mapPickupEvent(SuccessPickupEvent event) async* {
    yield SuccessPickupLoading();
    try {
      VendorProfileResponse storedData =
          await Repository.instance.getStoredVendorData();
      if (storedData != null && storedData.data.id != null) {
        PickUpRequestSuccessResponse response =
        await Repository.instance.getPickUpRequestSuccessData(storedData.data.id,event.startFrom);
        if (response.status) {
          yield SuccessPickupLoaded(response: response);
        } else {
          yield SuccessPickupError(msg: 'Failed to store user data!');
        }
      } else {
        yield SuccessPickupError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield SuccessPickupError(msg: e);
      } else {
        yield SuccessPickupError(msg: '$e');
      }
    }
  }
}

abstract class SuccessPickupEventBase extends Equatable {
  SuccessPickupEventBase();
}

class SuccessPickupEvent extends SuccessPickupEventBase {
  final String startFrom;

  SuccessPickupEvent({@required this.startFrom}) : assert(startFrom != null);

  @override
  List<Object> get props => [startFrom];
}

abstract class SuccessPickupState extends Equatable {
  SuccessPickupState();

  @override
  List<Object> get props => [];
}

class Empty extends SuccessPickupState {}

class SuccessPickupLoading extends SuccessPickupState {}

class SuccessPickupLoaded extends SuccessPickupState {
  final PickUpRequestSuccessResponse response;

  SuccessPickupLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SuccessPickupError extends SuccessPickupState {
  final String msg;

  SuccessPickupError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
