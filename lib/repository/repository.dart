import 'dart:convert';
import 'package:scrapgreen/models/response/otp_verification_response.dart';
import 'package:scrapgreen/models/response/otp_vendor_verification_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:scrapgreen/models/response/pickup_request_response.dart';
import 'package:scrapgreen/models/response/resend_otp_response.dart';
import 'package:scrapgreen/models/response/resend_otp_vendor_response.dart';
import 'package:scrapgreen/models/response/sign_in_response.dart';
import 'package:scrapgreen/models/response/sign_up_response.dart';
import 'package:scrapgreen/models/response/sign_up_vendor_response.dart';
import 'package:scrapgreen/models/response/forgot_password_response.dart';
import 'package:scrapgreen/models/response/update_fcm_response.dart';
import 'package:scrapgreen/models/response/password_response.dart';
import 'package:scrapgreen/models/response/password_update_response.dart';
import 'package:scrapgreen/models/response/contact_us_response.dart';
import 'package:scrapgreen/models/response/rate_card_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/models/response/pickup_request_schedule_response.dart';
import 'package:scrapgreen/models/response/pickup_request_assigned_response.dart';
import 'package:scrapgreen/models/response/pickup_request_success_response.dart';
import 'package:scrapgreen/models/response/request_details_response.dart';
import 'package:scrapgreen/models/response/request_id_response.dart';
import 'package:scrapgreen/models/response/complete_request_details_response.dart';
import 'package:scrapgreen/network/api_provider.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/models/response/sign_in_vendor_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Repository._privateConstructor();

  static final Repository instance = Repository._privateConstructor();

  Future<SignUpResponse> attemptSignUp(FormData body) async {
    final response =
        await ApiProvider.instance.postFormData("user_registration", body);
    return SignUpResponse.fromJson(response);
  }

  Future<SignUpVendorResponse> attemptSignUpVendor(FormData body) async {
    final response =
        await ApiProvider.instance.postFormData("vendor_registration", body);
    return SignUpVendorResponse.fromJson(response);
  }

  Future<SignInResponse> attemptSignIn(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("user_login", body);
    return SignInResponse.fromJson(response);
  }

  Future<ContactUsResponse> attemptContactUs(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("contact_us", body);
    return ContactUsResponse.fromJson(response);
  }

  Future<SignInVendorResponse> attemptSignInVendor(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("vendor_login", body);
    return SignInVendorResponse.fromJson(response);
  }

  Future<OtpVerificationResponse> userOtpVerification(
      Map<String, String> body) async {
    final response =
        await ApiProvider.instance.post("user_otp_verification", body);
    return OtpVerificationResponse.fromJson(response);
  }

  Future<OtpVendorVerificationResponse> vendorOtpVerification(
      Map<String, String> body) async {
    final response = await ApiProvider.instance.post("vendor_otp_verification", body);
    return OtpVendorVerificationResponse.fromJson(response);
  }

  Future<ResendOtpResponse> resendOtp(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("resend_otp", body);
    return ResendOtpResponse.fromJson(response);
  }

  Future<ResendOtpVendorResponse> resendOtpVendor(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("resend_vendor_otp", body);
    return ResendOtpVendorResponse.fromJson(response);
  }

  Future<ProfileResponse> getUserData(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("edit_profile", body);
    return ProfileResponse.fromJson(response);
  }

  Future<VendorProfileResponse> getVendorData(String userId) async {
    final response = await ApiProvider.instance.get("get_vendor_profile/$userId");
    return VendorProfileResponse.fromJson(response);
  }

  Future<VendorProfileResponse> getStoredVendorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = prefs.getString(Constants.PARAM_VENDOR_DATA);
    if(response!=null){
      return VendorProfileResponse.fromJson(
          json.decode(response));
    }else{
      return null;
    }
  }

  Future<PasswordResponse> getUserId(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("edit_profile", body);
    return PasswordResponse.fromJson(response);
  }

  Future<PasswordResponse> getVendorId(String userId) async {
    final response = await ApiProvider.instance.get("get_vendor_profile/$userId");
    return PasswordResponse.fromJson(response);
  }

  Future<CompleteRequestDetailsResponse> completeRequest(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("add_total_amount", body);
    return CompleteRequestDetailsResponse.fromJson(response);
  }

  Future<CompleteRequestDetailsResponse> removeItem(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("remove_item", body);
    return CompleteRequestDetailsResponse.fromJson(response);
  }

  Future<PickUpRequestResponse> getPickUpRequestData(String userId,String startFrom) async {
    // final response = await ApiProvider.instance.get("get_user_pickup_request?user_id=4&request_status=0&limit=30&start_from=$startFrom");
        final response = await ApiProvider.instance.get("get_user_pickup_request?user_id=$userId&request_status=0&limit=30&start_from=$startFrom");
    return PickUpRequestResponse.fromJson(response);
  }

//  Future<DisplayItemsResponse> getRequestDetailsItems(String request_id) async {
//        final response = await ApiProvider.instance.get("get_pickup_request_item_details/1");
//    return DisplayItemsResponse.fromJson(response);
//  }

  Future<RequestDetailsResponse> getRequestDetails(String requestId) async {
    print('asdfghj');
    final response = await ApiProvider.instance.get("get_pickup_request_details/$requestId");
    return RequestDetailsResponse.fromJson(response);
  }

  Future<PickUpRequestScheduleResponse> getPickUpRequestScheduleData(String userId,String startFrom) async {
    final response = await ApiProvider.instance.get("get_scheduled_pickup_request?user_id=$userId&request_status=0&limit=30&start_from=$startFrom");

    return PickUpRequestScheduleResponse.fromJson(response);
  }

  Future<PickUpRequestAssignedResponse> getPickUpRequestAssignedData(String userId,String startFrom) async {
//    print('assign');
    final response = await ApiProvider.instance.get("get_assigned_pickup_request?user_id=$userId&request_status=0&limit=30&start_from=$startFrom");
    return PickUpRequestAssignedResponse.fromJson(response);
  }

  Future<PickUpRequestSuccessResponse> getPickUpRequestSuccessData(String userId,String startFrom) async {
//    print('success');
    final response = await ApiProvider.instance.get("get_other_pickup_request?user_id=$userId&request_status=0&limit=30&start_from=$startFrom");
    return PickUpRequestSuccessResponse.fromJson(response);
  }

  Future<ProfileUpdateResponse> updateProfile(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("pickup_request", body);
    return ProfileUpdateResponse.fromJson(response);
  }

  Future<RequestDetailsResponse> addRequestDetails(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("add_pickup_items", body);
    return RequestDetailsResponse.fromJson(response);
  }

  Future<ProfileUpdateResponse> updateUserProfile(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("update_user_profile", body);
    return ProfileUpdateResponse.fromJson(response);
  }

  Future<ProfileUpdateResponse> updateVendorProfile(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("update_vendor_profile", body);
    return ProfileUpdateResponse.fromJson(response);
  }

  Future<PasswordUpdateResponse> updateUserPassword(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("change_user_password", body);
    return PasswordUpdateResponse.fromJson(response);
  }

  Future<PasswordUpdateResponse> updateVendorPassword(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("change_vendor_password", body);
    return PasswordUpdateResponse.fromJson(response);
  }

  Future<ProfileResponse> getStoredUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = prefs.getString(Constants.PARAM_USER_DATA);
    if(response!=null){
      return ProfileResponse.fromJson(json.decode(response));
    }else{
      return null;
    }
  }

  Future<PasswordResponse> getStoredUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return PasswordResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_USER_DATA)));
  }

  Future<RateCardResponse> getStoredRateCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(json.decode(prefs.getString(Constants.PARAM_RATE_CARD_DATA)));
    return RateCardResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_RATE_CARD_DATA)));
  }

  Future<RequestIdResponse> getStoredRequestId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return RequestIdResponse.fromJson(json.decode(prefs.getString(Constants.PARAM_REQUEST_ID)));
  }

  Future<RateCardResponse> getAllRateCards() async {
    final response = await ApiProvider.instance.get("get_all_rate_cards");
    return RateCardResponse.fromJson(response);
  }

  Future<PickUpRequestResponse> getStoredPickUpRequestData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return PickUpRequestResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_PICKUP_REQUEST_DATA)));
  }

  Future<PickUpRequestResponse> getStoredPickUpRequestScheduledData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return PickUpRequestResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_PICKUP_REQUEST_SCHEDULE_DATA)));
  }

  Future<PickUpRequestResponse> getStoredPickUpRequestAssignedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return PickUpRequestResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_PICKUP_REQUEST_ASSIGNED_DATA)));
  }

  Future<PickUpRequestResponse> getStoredPickUpRequestSuccessData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return PickUpRequestResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_PICKUP_REQUEST_SUCCESS_DATA)));
  }

  Future<bool> storeUserData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_USER_DATA, json.encode(response));
  }

  Future<bool> storeVendorData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_VENDOR_DATA, json.encode(response));
  }

  Future<bool> storeRateCardData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_RATE_CARD_DATA, json.encode(response));
  }

  Future<bool> storeRequestId(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(response);
    return await prefs.setString(Constants.PARAM_REQUEST_ID, json.encode(response));
  }

  Future<bool> storeRequestDetails(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(Constants.PARAM_REQUEST_DETAILS, json.encode(response));
  }

  Future<bool> storeRequestDetailsItems(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(Constants.PARAM_REQUEST_DETAILS_ITEMS, json.encode(response));
  }

  Future<UpdateFcmResponse> updateFcmId(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("update_fcm_id", body);
    return UpdateFcmResponse.fromJson(response);
  }

  Future<bool> storeFcmId(String response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(Constants.PARAM_FCM_ID, response);
  }

  Future<ForgotPasswordResponse> forgotPassword(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("forgot_password", body);
    return ForgotPasswordResponse.fromJson(response);
  }

  Future<bool> storePickUpData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_PICKUP_REQUEST_DATA, json.encode(response));
  }

  Future<bool> storePickUpScheduleData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_PICKUP_REQUEST_SCHEDULE_DATA, json.encode(response));
  }

  Future<bool> storePickUpAssignedData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_PICKUP_REQUEST_ASSIGNED_DATA, json.encode(response));
  }

  Future<bool> storePickUpSuccessData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_PICKUP_REQUEST_SUCCESS_DATA, json.encode(response));
  }

  Future<bool> clearAllShardPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
