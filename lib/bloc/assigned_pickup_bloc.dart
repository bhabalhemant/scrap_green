import 'package:scrapgreen/models/response/pickup_request_assigned_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;

class AssignedPickupBloc extends Bloc<AssignedPickupEventBase, AssignedPickupState> {
  AssignedPickupBloc();

  @override
  AssignedPickupState get initialState => Empty();

  @override
  Stream<AssignedPickupState> mapEventToState(AssignedPickupEventBase event) async* {
    if (event is AssignedPickupEvent) {
      yield* _mapPickupEvent(event);
    } else if(event is AssignedRequestIdEvent) {
      yield* _mapStoreRequestId(event);
    }
  }

  Stream<AssignedPickupState> _mapPickupEvent(AssignedPickupEvent event) async* {
    yield AssignedPickupLoading();
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
        PickUpRequestAssignedResponse response =
        await Repository.instance.getPickUpRequestAssignedData(params);
        if (response.status) {
          yield AssignedPickupLoaded(response: response);
        } else {
          yield AssignedPickupError(msg: response.msg);
        }
      } else {
        yield AssignedPickupError(msg: 'Failed to get stored vendor data!');
      }
    } catch (e) {
      if (e is String) {
        yield AssignedPickupError(msg: e);
      } else {
        yield AssignedPickupError(msg: '$e');
      }
    }
  }

  Stream<AssignedPickupState> _mapStoreRequestId(AssignedRequestIdEvent event) async* {
    yield AssignedPickupLoading();
    try {
      bool storedData = await Repository.instance.storeRequestId(event.body);
    } catch (e) {
      if (e is String) {
        yield AssignedPickupError(msg: e);
      } else {
        yield AssignedPickupError(msg: '$e');
      }
    }
  }
}

abstract class AssignedPickupEventBase extends Equatable {
  AssignedPickupEventBase();
}

class AssignedPickupEvent extends AssignedPickupEventBase {
  final String startFrom;

  AssignedPickupEvent({@required this.startFrom}) : assert(startFrom != null);

  @override
  List<Object> get props => [startFrom];
}

class AssignedRequestIdEvent extends AssignedPickupEventBase {
  Map<String, dynamic> body;

  AssignedRequestIdEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

abstract class AssignedPickupState extends Equatable {
  AssignedPickupState();

  @override
  List<Object> get props => [];
}

class Empty extends AssignedPickupState {}

class AssignedPickupLoading extends AssignedPickupState {}

class AssignedPickupLoaded extends AssignedPickupState {
  final PickUpRequestAssignedResponse response;

  AssignedPickupLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class AssignedPickupError extends AssignedPickupState {
  final String msg;

  AssignedPickupError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}