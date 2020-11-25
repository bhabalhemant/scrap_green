import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_event.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_state.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class VendorProfileBloc extends Bloc<VendorProfileEvent, VendorProfileState> {
  VendorProfileBloc();

  @override
  VendorProfileState get initialState => VendorProfileEmpty();

  @override
  Stream<VendorProfileState> mapEventToState(VendorProfileEvent event) async* {
//    print(event);
    if (event is GetProfile) {
      yield* _mapGetProfileToState(event);
    }
    else if (event is UpdateProfile) {
      yield* _mapUpdateProfileToState(event);
    }
  }

  Stream<VendorProfileState> _mapGetProfileToState(GetProfile event) async* {
    yield VendorProfileLoading();
    try {
      VendorProfileResponse storedData =
          await Repository.instance.getStoredVendorData();
      if (storedData != null && storedData.data.id != null) {
        VendorProfileResponse response = await Repository.instance.getVendorData(storedData.data.id);
        bool isStored =
            await Repository.instance.storeVendorData(response.toJson());
        if (isStored) {
          yield VendorProfileLoaded(response: response);
        } else {
          yield VendorProfileError(msg: 'Failed to store user data!');
        }
      } else {
        yield VendorProfileError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield VendorProfileError(msg: e);
      } else {
        yield VendorProfileError(msg: '$e');
      }
    }
  }

  Stream<VendorProfileState> _mapUpdateProfileToState(UpdateProfile event) async* {
    yield VendorProfileLoading();
    try {
      ProfileUpdateResponse response = await Repository.instance.updateVendorProfile(event.body);
      if (response.status) {
        yield VendorProfileUpdated(response: response);
      } else {
        yield VendorProfileError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield VendorProfileError(msg: e);
      } else {
        yield VendorProfileError(msg: '$e');
      }
    }
  }
}
