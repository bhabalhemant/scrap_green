import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;

class SplashBloc extends Bloc<SplashEventBase, SplashState> {
  SplashBloc();

  @override
  SplashState get initialState => Empty();

  @override
  Stream<SplashState> mapEventToState(SplashEventBase event) async* {
    if (event is SplashEvent) {
      yield* _mapSplashEvent(event);
    }
  }

  Stream<SplashState> _mapSplashEvent(SplashEvent event) async* {
    yield SplashLoading();

    try {
      ProfileResponse storedData = await Repository.instance
          .getStoredUserData();
      VendorProfileResponse vendorData =
      await Repository.instance.getStoredVendorData();

      if (storedData != null &&
          storedData.data != null &&
          storedData.data.id != null) {
        Map<String, String> body = {Constants.PARAM_ID: storedData.data.id};
        Map<String, String> updateBody = {
          Constants.PARAM_USER_ID: storedData.data.id,
          Constants.PARAM_FCM_ID: event.fcmId
        };
        ProfileResponse response = await Repository.instance.getUserData(body);
        bool isStored =
        await Repository.instance.storeUserData(response.toJson());
        await Repository.instance.updateFcmId(updateBody);
        await Repository.instance.storeFcmId(event.fcmId);
        if (isStored) {
          yield SplashLoaded(
              profileResponse: response, vendorProfileResponse: null);
        } else {
          yield SplashError(msg: 'Failed to store user data!');
        }
      } else if (vendorData != null &&
          vendorData.data != null &&
          vendorData.data.id != null) {
        Map<String, String> updateBody = {
          Constants.PARAM_USER_ID: vendorData.data.id,
          Constants.PARAM_FCM_ID: event.fcmId
        };
        VendorProfileResponse response =
        await Repository.instance.getVendorData(vendorData.data.id);
        bool isStored =
        await Repository.instance.storeUserData(response.toJson());
        await Repository.instance.updateFcmId(updateBody);
        await Repository.instance.storeFcmId(event.fcmId);
        if (isStored) {
          yield SplashLoaded(
              profileResponse: null, vendorProfileResponse: response);
        } else {
          yield SplashError(msg: 'Failed to store user data!');
        }
      } else {
        yield SplashError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield SplashError(msg: e);
      } else {
        yield SplashError(msg: '$e');
      }
    }
  }
}

abstract class SplashEventBase extends Equatable {
  SplashEventBase();
}

class SplashEvent extends SplashEventBase {
  final String fcmId;

  SplashEvent({@required this.fcmId}) : assert(fcmId != null);

  @override
  List<Object> get props => [fcmId];
}
// class SplashEvent extends SplashEventBase {
//   final String fcmId;

//   SplashEvent({@required this.fcmId}) : assert(fcmId != null);

//   @override
//   List<Object> get props => [fcmId];
// }

abstract class SplashState extends Equatable {
  SplashState();

  @override
  List<Object> get props => [];
}

class Empty extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  final ProfileResponse profileResponse;
  final VendorProfileResponse vendorProfileResponse;

  SplashLoaded(
      {@required this.profileResponse, @required this.vendorProfileResponse});

  @override
  List<Object> get props => [profileResponse, vendorProfileResponse];
}

class SplashError extends SplashState {
  final String msg;

  SplashError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
