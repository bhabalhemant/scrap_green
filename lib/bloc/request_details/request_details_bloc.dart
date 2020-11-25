import 'package:scrapgreen/bloc/request_details/request_details_event.dart';
import 'package:scrapgreen/bloc/request_details/request_details_state.dart';
import 'package:scrapgreen/models/response/request_details_response.dart';
import 'package:scrapgreen/models/response/request_id_response.dart';
import 'package:scrapgreen/models/response/complete_request_details_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestDetailsBloc extends Bloc<RequestDetailsEvent, RequestDetailsState> {
  RequestDetailsBloc();

  @override
  RequestDetailsState get initialState => RequestDetailsEmpty();

  @override
  Stream<RequestDetailsState> mapEventToState(RequestDetailsEvent event) async* {
      if(event is GetRequestDetailsEvent) {
        yield* _mapGetRequestDetailsToState(event);
      } else if (event is UpdateRequestDetails) {
        yield* _mapUpdateRequestDetailsToState(event);
      } else if (event is CompleteRequestDetails) {
        yield* _mapCompleteRequestDetails(event);
      } else if (event is RemoveItemRequestDetails) {
        yield* _mapRemoveItemRequestDetails(event);
      } else if (event is GetVendorProfile) {
        yield* _mapGetProfileToState(event);
      }
    }

  Stream<RequestDetailsState> _mapGetRequestDetailsToState(GetRequestDetailsEvent event) async* {
    yield RequestDetailsLoading();
    try {
//      _mapGetProfileToState();
      RequestIdResponse storedData = await Repository.instance.getStoredRequestId();
      RequestDetailsResponse response = await Repository.instance.getRequestDetails(storedData.request_id);
      bool isStored = await Repository.instance.storeRequestDetails(response.toJson());

//      DisplayItemsResponse response1 = await Repository.instance.getRequestDetailsItems(storedData.request_id);
      if (isStored) {
//          yield RequestDetailsItemLoaded(response1: response1);
          yield RequestDetailsLoaded(response: response);
      } else {
        yield RequestDetailsError(msg: 'Failed to fetch Request Details!');
      }
    } catch (e) {
      if (e is String) {
        yield RequestDetailsError(msg: e);
      } else {
        yield RequestDetailsError(msg: '$e');
      }
    }
  }

  Stream<RequestDetailsState> _mapGetProfileToState(GetVendorProfile event) async* {
    yield VendorProfileeLoading();
    try {
      VendorProfileResponse storedData = await Repository.instance.getStoredVendorData();
      if (storedData != null && storedData.data.id != null) {
        VendorProfileResponse response = await Repository.instance.getVendorData(storedData.data.id);
        bool isStored =
        await Repository.instance.storeVendorData(response.toJson());
        if (isStored) {
          yield VendorProfileeLoaded(response: response);
        } else {
          yield VendorProfileeError(msg: 'Failed to store user data!');
        }
      } else {
        yield VendorProfileeError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield VendorProfileeError(msg: e);
      } else {
        yield VendorProfileeError(msg: '$e');
      }
    }
  }
//  Stream<RequestDetailsState> _mapGetRequestDetailsItems(GetRequestDetailsItems event) async* {
//    yield RequestDetailsLoading();
//    try {
//      RequestIdResponse storedData = await Repository.instance.getStoredRequestId();
//      DisplayItemsResponse response = await Repository.instance.getRequestDetailsItems(storedData.request_id);
//      bool isStored = await Repository.instance.storeRequestDetailsItems(response.toJson());
//      if (isStored) {
//        yield RequestDetailsItemLoaded(response: response);
//      } else {
//        yield RequestDetailsError(msg: 'Failed to fetch Request Details Items!');
//      }
//    } catch (e) {
//      if (e is String) {
//        yield RequestDetailsError(msg: e);
//      } else {
//        yield RequestDetailsError(msg: '$e');
//      }
//    }
//  }

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
      RequestIdResponse storedReqIdData = await Repository.instance.getStoredRequestId();
      VendorProfileResponse storedVendorData = await Repository.instance.getStoredVendorData();
      print(storedVendorData.data.id);
      print(storedReqIdData.request_id);
      print(event.body);
//      RequestDetailsResponse response = await Repository.instance.addRequestDetails(event.body);
//      if (response.status) {
//        yield RequestDetailsUpdated(response: response);
//      } else {
//        yield RequestDetailsError(msg: response.msg);
//      }
    } catch (e) {
      if (e is String) {
        yield RequestDetailsError(msg: e);
      } else {
        yield RequestDetailsError(msg: '$e');
      }
    }
  }

  Stream<RequestDetailsState> _mapCompleteRequestDetails(CompleteRequestDetails event) async* {
    yield RequestDetailsLoading();
    try {
      CompleteRequestDetailsResponse response = await Repository.instance.completeRequest(event.body);
      if (response.status) {
        yield RequestDetailsComplete(response: response);
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

  Stream<RequestDetailsState> _mapRemoveItemRequestDetails(RemoveItemRequestDetails event) async* {
    yield RequestDetailsLoading();
    try {
      CompleteRequestDetailsResponse response = await Repository.instance.removeItem(event.body);
//      print(response.status);
      if (response.status) {
        yield RequestDetailsItemRemoved(response: response);
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
