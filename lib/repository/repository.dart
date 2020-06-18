import 'dart:convert';

import 'package:dana/models/response/otp_verification_response.dart';
import 'package:dana/models/response/profile_response.dart';
import 'package:dana/models/response/profile_update_response.dart';
import 'package:dana/models/response/resend_otp_response.dart';
import 'package:dana/models/response/sign_in_response.dart';
import 'package:dana/models/response/sign_up_response.dart';
import 'package:dana/models/response/sign_up_vendor_response.dart';
import 'package:dana/network/api_provider.dart';
import 'package:dana/utils/constants.dart' as Constants;
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

  Future<ProfileUpdateResponse> updateProfile(Map<String, String> body) async {
    final response = await ApiProvider.instance.post("update_profile", body);
    return ProfileUpdateResponse.fromJson(response);
  }

  Future<ProfileResponse> getStoredUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return ProfileResponse.fromJson(
        json.decode(prefs.getString(Constants.PARAM_USER_DATA)));
  }

  Future<bool> storeUserData(Map<String, dynamic> response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        Constants.PARAM_USER_DATA, json.encode(response));
  }
}
