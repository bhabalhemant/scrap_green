import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/models/response/sign_in_vendor_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInVendorBloc extends Bloc<SignInVendorEventBase, SignInVendorState> {
  SignInVendorBloc();

  @override
  SignInVendorState get initialState => Empty();

  @override
  Stream<SignInVendorState> mapEventToState(SignInVendorEventBase event) async* {
    if (event is SignInVendorEvent) {
      yield* _mapSignInVendorEvent(event);
    }
  }

  Stream<SignInVendorState> _mapSignInVendorEvent(SignInVendorEvent event) async* {
    yield SignInVendorLoading();
    try {
      SignInVendorResponse response =
          await Repository.instance.attemptSignInVendor(event.body);
      if (response.status == true) {
        Map<String, String> params = {Constants.PARAM_ID: response.data.id};
        VendorProfileResponse vendorProfileResponse =
            await Repository.instance.getVendorData(response.data.id);
        bool isStored =
            await Repository.instance.storeVendorData(vendorProfileResponse.toJson());
        if (isStored) {
          yield SignInVendorLoaded(response: response);
        } else {
          yield SignInVendorError(msg: 'Failed to store data!');
        }
      } else {
        yield SignInVendorError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield SignInVendorError(msg: e);
      } else {
        yield SignInVendorError(msg: '$e');
      }
    }
  }
}

abstract class SignInVendorEventBase extends Equatable {
  SignInVendorEventBase();
}

class SignInVendorEvent extends SignInVendorEventBase {
  Map<String, dynamic> body;

  SignInVendorEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

abstract class SignInVendorState extends Equatable {
  SignInVendorState();

  @override
  List<Object> get props => [];
}

class Empty extends SignInVendorState {}

class SignInVendorLoading extends SignInVendorState {}

class SignInVendorLoaded extends SignInVendorState {
  final SignInVendorResponse response;

  SignInVendorLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SignInVendorError extends SignInVendorState {
  final String msg;

  SignInVendorError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
