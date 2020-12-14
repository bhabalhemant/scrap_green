import 'package:scrapgreen/models/response/pickup_request_success_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;

class SuccessPickupBloc extends Bloc<SuccessPickupEventBase, SuccessPickupState> {
  SuccessPickupBloc();

  @override
  SuccessPickupState get initialState => Empty();

  @override
  Stream<SuccessPickupState> mapEventToState(SuccessPickupEventBase event) async* {
    if (event is SuccessPickupEvent) {
      yield* _mapPickupEvent(event);
    } else if (event is SuccessRequestIdEvent) {
      yield* _mapStoreRequestId(event);
    }
  }

  Stream<SuccessPickupState> _mapPickupEvent(SuccessPickupEvent event) async* {
    yield SuccessPickupLoading();
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
        PickUpRequestSuccessResponse response =
        await Repository.instance.getPickUpRequestSuccessData(params);
        if (response.status) {
          yield SuccessPickupLoaded(response: response);
        } else {
          yield SuccessPickupError(msg: response.msg);
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

  Stream<SuccessPickupState> _mapStoreRequestId(SuccessRequestIdEvent event) async* {
    yield SuccessPickupLoading();
    try {
      bool storedData = await Repository.instance.storeRequestId(event.body);
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

class SuccessRequestIdEvent extends SuccessPickupEventBase {
  Map<String, dynamic> body;

  SuccessRequestIdEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
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