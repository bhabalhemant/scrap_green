import 'dart:convert';

// <<<<<<< Updated upstream
import 'package:scrapgreen/models/response/otp_verification_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:scrapgreen/models/response/pickup_request_response.dart';
import 'package:scrapgreen/models/response/resend_otp_response.dart';
import 'package:scrapgreen/models/response/sign_in_response.dart';
import 'package:scrapgreen/models/response/sign_up_response.dart';
import 'package:scrapgreen/models/response/sign_up_vendor_response.dart';
import 'package:scrapgreen/models/response/forgot_password_response.dart';
import 'package:scrapgreen/models/response/update_fcm_response.dart';
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

  Future<ResendOtpResponse> resendOtp(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("resend_otp", body);
    return ResendOtpResponse.fromJson(response);
  }

  Future<ProfileResponse> getUserData(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("edit_profile", body);
    return ProfileResponse.fromJson(response);
  }

  Future<PickUpRequestResponse> getPickUpRequestData(String userId,String startFrom) async {
    // final response = await ApiProvider.instance.get("get_user_pickup_request?user_id=4&request_status=0&limit=30&start_from=$startFrom");
        final response = await ApiProvider.instance.get("get_user_pickup_request?user_id=$userId&request_status=0&limit=30&start_from=$startFrom");
    return PickUpRequestResponse.fromJson(response);
  }

  Future<ProfileUpdateResponse> updateProfile(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("pickup_request", body);
    return ProfileUpdateResponse.fromJson(response);
  }

  Future<ProfileUpdateResponse> updateUserProfile(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("update_user_profile", body);
    return ProfileUpdateResponse.fromJson(response);
  }

  Future<ProfileResponse> getStoredUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return ProfileResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_USER_DATA)));
  }

  Future<PickUpRequestResponse> getStoredPickUpRequestData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return PickUpRequestResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_PICKUP_REQUEST_DATA)));
  }

  Future<bool> storeUserData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_USER_DATA, json.encode(response));
  }

  Future<UpdateFcmResponse> updateFcmId(Map<String, String> body) async {
    print(body);
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

  Future<bool> clearAllShardPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
