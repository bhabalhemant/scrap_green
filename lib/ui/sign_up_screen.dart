import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scrap_green/base_widgets/app_textstyle.dart';
import 'package:scrap_green/bloc/sign_up_bloc.dart';
import 'package:scrap_green/models/response/sign_up_response.dart';
import 'package:scrap_green/utils/constants.dart' as Constants;
import 'package:scrap_green/utils/email_validator.dart';
import 'package:scrap_green/utils/singleton.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Position _currentPosition;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _address1 = TextEditingController();
  final _address2 = TextEditingController();
  final _country = TextEditingController();
  final _state = TextEditingController();
  final _city = TextEditingController();
  final _pinCode = TextEditingController();
  final _password = TextEditingController();
  final _retypePassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _mobile.dispose();
    _address1.dispose();
    _address2.dispose();
    _country.dispose();
    _state.dispose();
    _city.dispose();
    _pinCode.dispose();
    _password.dispose();
    _retypePassword.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.of(scaffoldKey.currentContext).pop(true);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Register as User'),
          body: buildSignUpScreen(),
        ),
      ),
    );
  }

  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
  }

  SizedBox getFormField({@required TextEditingController textController,
    @required String hint,
    TextInputType type,
    int maxLength,
    WhitelistingTextInputFormatter restrictFormat,
    TextCapitalization textCap,
    bool obscureText = false}) {
    return SizedBox(
      height: AppSingleton.instance.getHeight(45),
      child: TextFormField(
        controller: textController,
        obscureText: obscureText,
        textCapitalization:
        textCap == null ? TextCapitalization.sentences : textCap,
        keyboardType: type == null ? TextInputType.text : type,
        maxLength: maxLength == null ? null : maxLength,
        inputFormatters: restrictFormat == null ? null : [restrictFormat],
        maxLines: 1,
        maxLengthEnforced: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 25),
          counterText: '',
          counterStyle: TextStyle(fontSize: 0),
          fillColor: AppSingleton.instance.getLightGrayColor(),
          border: AppSingleton.instance.getLightGrayOutLineBorder(),
          focusedBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
          disabledBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
          enabledBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
          errorBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
          focusedErrorBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
          filled: true,
          hintText: hint,
          hintStyle: AppTextStyle.regular(
            Colors.grey,
            AppSingleton.instance.getSp(14),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpScreen() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _name,
                  hint: 'Name',
                  type: TextInputType.text,
                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _email,
                  hint: 'Email',
                  type: TextInputType.emailAddress,
                  textCap: TextCapitalization.none,
                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _mobile,
                  hint: 'Mobile Number',
                  type: TextInputType.number,
                  maxLength: 10,

                  restrictFormat: WhitelistingTextInputFormatter(
                    RegExp("[0-9]"),
                  ),
                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _address1,
                  hint: 'Room No./Street',
                  type: TextInputType.text,

                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _address2,
                  hint: 'Area',
                  type: TextInputType.text,

                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _country,
                  hint: 'Country',
                  type: TextInputType.text,

                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _state,
                  hint: 'State',
                  type: TextInputType.text,

                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _city,
                  hint: 'City',
                  type: TextInputType.text,

                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _pinCode,
                  hint: 'Pin Code',
                  type: TextInputType.number,

                  maxLength: 6,
                  restrictFormat: WhitelistingTextInputFormatter(
                    RegExp("[0-9]"),
                  ),
                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _password,
                  hint: 'Password',
                  obscureText: true,

                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                    textController: _retypePassword,
                    hint: 'Retype Password',

                    obscureText: true),
                AppSingleton.instance.getSizedSpacer(40),
                SizedBox(
                  height: AppSingleton.instance.getHeight(45),
                  width: double.infinity,
                  child: BlocConsumer(
                    bloc: BlocProvider.of<SignUpBloc>(context),
                    listener: (context, state) {
                      if (state is SignUpError) {
                        _showError(state.msg);
                      }
                      if (state is SignUpLoaded) {
                        _showSuccessMessage(
                            state.response.data.msg, state.response);
                      }
                    },
                    builder: (context, state) {
                      if (state is SignUpLoading) {
                        return AppSingleton.instance
                            .buildCenterSizedProgressBar();
                      }
                      if (state is SignUpLoaded) {
                        return AppSingleton.instance
                            .buildCenterSizedProgressBar();
                      }
                      return buildSignUpButton();
                    },
                  ),
                ),
                AppSingleton.instance.getSizedSpacer(30),
                buildSignIn()
              ],
            ),
          ),
        ),
      ),
    );
  }

  onError(dynamic o) {
    if (o is String) {
      _showError(o);
    } else {
      _showError('Something went wrong!');
    }
  }

  Widget buildSignUpButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: AppSingleton.instance.getPrimaryColor(),
        ),
      ),
      onPressed: () async {
        if (validate()) {
          scaffoldKey.currentState.hideCurrentSnackBar();
          // _getCurrentLocation();
          final Geolocator geolocator = Geolocator()
            ..forceAndroidLocationManager;

          geolocator
              .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
              .then((Position position) {
            _currentPosition = position;
            String _position = _currentPosition.latitude.toString() +
                '-' +
                _currentPosition.longitude.toString();

            dio.FormData formData = dio.FormData.fromMap({
              Constants.PARAM_NAME: _name.text,
              Constants.PARAM_EMAIL: _email.text,
              Constants.PARAM_MOBILE: _mobile.text,
              Constants.PARAM_ADDRESS1: _address1.text,
              Constants.PARAM_ADDRESS2: _address2.text,
              Constants.PARAM_COUNTRY: _country.text,
              Constants.PARAM_STATE: _state.text,
              Constants.PARAM_CITY: _city.text,
              Constants.PARAM_PINCODE: _pinCode.text,
              Constants.PARAM_PASSWORD: _password.text,
              Constants.PARAM_LATITUDE_LONGITUDE: _position
            });
            BlocProvider.of<SignUpBloc>(context)
                .add(SignUpEvent(body: formData));
          }).catchError((e) {
            print(e);
          });
        }
      },
      color: AppSingleton.instance.getPrimaryColor(),
      textColor: Colors.white,
      child: Text(
        "Sign Up",
        style: AppTextStyle.regular(Colors.white, 14.0),
      ),
    );
  }

  Widget buildSignIn() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, Constants.ROUTE_SIGN_IN);
        },
        child: Text(
          'Already have an account? Sign IN',
          style: AppTextStyle.bold(
            Colors.black45,
            AppSingleton.instance.getSp(13.0),
          ),
        ),
      ),
    );
  }

  bool validate() {
    if (_address2.text.isEmpty) {
      _showError('Please enter your Area');
      return false;
    } else if (_name.text.isEmpty) {
      _showError('Please enter your name');
      return false;
    } else if (!EmailValidator.validate(_email.text)) {
      _showError('Please enter valid email');
      return false;
    } else if (_mobile.text.isEmpty) {
      _showError('Please enter your mobile number');
      return false;
    } else if (_mobile.text.length < 10) {
      _showError('Please enter valid mobile number');
      return false;
    } else if (_address1.text.isEmpty) {
      _showError('Please enter valid Room No./Street');
      return false;
    } else if (_country.text.isEmpty) {
      _showError('Please enter country');
      return false;
    } else if (_state.text.isEmpty) {
      _showError('Please enter state');
      return false;
    } else if (_city.text.isEmpty) {
      _showError('Please enter city');
      return false;
    } else if (_pinCode.text.isEmpty) {
      _showError('Please enter pincode');
      return false;
    } else if (_password.text.isEmpty) {
      _showError('Please enter password');
      return false;
    } else if (_retypePassword.text.isEmpty) {
      _showError('Please retype password');
      return false;
    } else if (_password.text != _retypePassword.text) {
      _showError('Password not matched');
      return false;
    } else {
      return true;
    }
  }

  void _showSuccessMessage(String message, SignUpResponse response) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
    Timer(Duration(seconds: 1), () {
      if (response != null && response.data.emailKey != null) {
        Navigator.pushReplacementNamed(context, Constants.ROUTE_OTP,
            arguments: response);
      }
    });
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
