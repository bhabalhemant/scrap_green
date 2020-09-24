import 'package:scrapgreen/bloc/profile_page/profile_event.dart';
import 'package:scrapgreen/bloc/profile_page/profile_state.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<ProfileEvent, ProfileState> {
  SettingsBloc();

  @override
  ProfileState get initialState => ProfileEmpty();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    print(event);
    if (event is GetProfile) {
      yield* _mapGetProfileToState(event);
    } else if (event is UpdateProfile) {
      yield* _mapUpdateProfileToState(event);
    }
  }

  Stream<ProfileState> _mapGetProfileToState(GetProfile event) async* {
    yield ProfileLoading();
    try {
      ProfileResponse storedData =
          await Repository.instance.getStoredUserData();
      if (storedData != null && storedData.data.id != null) {
        Map<String, String> body = {Constants.PARAM_ID: storedData.data.id};
        ProfileResponse response = await Repository.instance.getUserData(body);
        bool isStored =
            await Repository.instance.storeUserData(response.toJson());
        print('test ${isStored}');
        if (isStored) {
          yield ProfileLoaded(response: response);
        } else {
          yield ProfileError(msg: 'Failed to store user data!');
        }
      } else {
        yield ProfileError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield ProfileError(msg: e);
      } else {
        yield ProfileError(msg: '$e');
      }
    }
  }

  Stream<ProfileState> _mapUpdateProfileToState(UpdateProfile event) async* {
    yield ProfileLoading();
    try {
      ProfileUpdateResponse response =
          await Repository.instance.updateProfile(event.body);
      if (response.status) {
        yield ProfileUpdated(response: response);
      } else {
        yield ProfileError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield ProfileError(msg: e);
      } else {
        yield ProfileError(msg: '$e');
      }
    }
  }
}
