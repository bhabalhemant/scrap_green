import 'package:scrapgreen/bloc/change_password/cp_event.dart';
import 'package:scrapgreen/bloc/change_password/cp_state.dart';
import 'package:scrapgreen/models/response/password_response.dart';
import 'package:scrapgreen/models/response/password_update_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc();

  @override
  ChangePasswordState get initialState => ChangePasswordEmpty();

  @override
  Stream<ChangePasswordState> mapEventToState(ChangePasswordEvent event) async* {
    print(event);
    if (event is GetPassword) {
      yield* _mapGetPasswordToState(event);
    } else if (event is UpdatePassword) {
      yield* _mapUpdatePasswordToState(event);
    } else if (event is GetVendorId) {
      yield* _mapVendorId(event);
    } else if (event is UpdateVendorPassword) {
      yield* _mapUpdateVendorPassword(event);
    }

  }

  Stream<ChangePasswordState> _mapGetPasswordToState(GetPassword event) async* {
    yield ChangePasswordLoading();
    try {
      PasswordResponse storedData =
          await Repository.instance.getStoredUserId();
//      print('storedData');
      if (storedData != null && storedData.data.id != null) {
        print(storedData.data.id);
        Map<String, String> body = {Constants.PARAM_ID: storedData.data.id};
        PasswordResponse response = await Repository.instance.getUserId(body);
        bool isStored =
            await Repository.instance.storeUserData(response.toJson());
//        print('test ${isStored}');
        if (isStored) {
          yield ChangePasswordLoaded(response: response);
        } else {
          yield ChangePasswordError(msg: 'Failed to store user data!');
        }
      } else {
        yield ChangePasswordError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield ChangePasswordError(msg: e);
      } else {
        yield ChangePasswordError(msg: '$e');
      }
    }
  }

  Stream<ChangePasswordState> _mapUpdatePasswordToState(UpdatePassword event) async* {
    yield ChangePasswordLoading();
    try {
      PasswordUpdateResponse response =
          await Repository.instance.updateUserPassword(event.body);
      if (response.status) {
        yield PasswordUpdated(response: response);
      } else {
        yield ChangePasswordError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield ChangePasswordError(msg: e);
      } else {
        yield ChangePasswordError(msg: '$e');
      }
    }
  }

  Stream<ChangePasswordState> _mapVendorId(GetVendorId event) async* {
    yield ChangePasswordLoading();
    try {
      VendorProfileResponse storedData = await Repository.instance.getStoredVendorData();
//      print(storedData.data.id);
      if (storedData != null && storedData.data.id != null) {
        print(storedData.data.id);
//        Map<String, String> body = {Constants.PARAM_ID: storedData.data.id};
        PasswordResponse response = await Repository.instance.getVendorId(storedData.data.id);
//        print(response.data.id);
        bool isStored =
        await Repository.instance.storeUserData(response.toJson());
//        print('test ${isStored}');
        if (isStored) {
          yield VendorIdLoaded(response: response);
        } else {
          yield ChangePasswordError(msg: 'Failed to store user data!');
        }
      } else {
        yield ChangePasswordError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield ChangePasswordError(msg: e);
      } else {
        yield ChangePasswordError(msg: '$e');
      }
    }
  }

  Stream<ChangePasswordState> _mapUpdateVendorPassword(UpdateVendorPassword event) async* {
    yield ChangePasswordLoading();
    try {
      PasswordUpdateResponse response =
      await Repository.instance.updateVendorPassword(event.body);
      if (response.status) {
        yield PasswordUpdated(response: response);
      } else {
        yield ChangePasswordError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield ChangePasswordError(msg: e);
      } else {
        yield ChangePasswordError(msg: '$e');
      }
    }
  }
}
