import 'package:scrapgreen/bloc/request_details/request_details_event.dart';
import 'package:scrapgreen/bloc/request_details/request_details_state.dart';
import 'package:scrapgreen/models/response/request_details_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestDetailsBloc extends Bloc<RequestDetailsEvent, RequestDetailsState> {
  RequestDetailsBloc();

  @override
  RequestDetailsState get initialState => RequestDetailsEmpty();

  @override
  Stream<RequestDetailsState> mapEventToState(RequestDetailsEvent event) async* {
    if (event is UpdateRequestDetails) {
//      yield* _mapGetRequestDetailsToState(event);
//    } else if (event is UpdateRequestDetails) {
      yield* _mapUpdateRequestDetailsToState(event);
    }
  }

//  Stream<RequestDetailsState> _mapGetRequestDetailsToState(GetRequestDetails event) async* {
//    yield RequestDetailsLoading();
//    try {
//      ProfileResponse storedData =
//          await Repository.instance.getStoredUserData();
//      if (storedData != null && storedData.data.id != null) {
//        Map<String, String> body = {Constants.PARAM_ID: storedData.data.id};
//        ProfileResponse response = await Repository.instance.getUserData(body);
//        bool isStored =
//            await Repository.instance.storeUserData(response.toJson());
//        if (isStored) {
//          yield RequestDetailsLoaded(response: response);
//        } else {
//          yield RequestDetailsError(msg: 'Failed to store user data!');
//        }
//      } else {
//        yield RequestDetailsError(msg: 'Failed to get stored user data!');
//      }
//    } catch (e) {
//      if (e is String) {
//        yield RequestDetailsError(msg: e);
//      } else {
//        yield RequestDetailsError(msg: '$e');
//      }
//    }
//  }

  Stream<RequestDetailsState> _mapUpdateRequestDetailsToState(UpdateRequestDetails event) async* {
    yield RequestDetailsLoading();
    try {
      RequestDetailsResponse response =
          await Repository.instance.addRequestDetails(event.body);
      if (response.status) {
        yield RequestDetailsUpdated(response: response);
      } else {
        yield RequestDetailsError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield RequestDetailsError(msg: e);
      } else {
        yield RequestDetailsError(msg: '$e');
      }
    }
  }
}
