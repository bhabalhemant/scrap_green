import 'dart:async';

import 'package:dana/base_widgets/app_textstyle.dart';
import 'package:dana/bloc/forgot_password_bloc.dart';
import 'package:dana/models/response/forgot_password_response.dart';
import 'package:dana/models/response/sign_up_response.dart' as signUp;
import 'package:dana/utils/constants.dart' as Constants;
import 'package:dana/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassWordScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ForgotPassWordScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _retypePassword = TextEditingController();
  bool passwordVisible;
  bool reTypePasswordVisible;

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.of(context).pop(true);
    return false;
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    reTypePasswordVisible = false;
  }

  @override
  void dispose() {
    _mobile.dispose();
    _password.dispose();
    _retypePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Forgot Password'),
          key: scaffoldKey,
          body: buildScreen(),
        ),
      ),
    );
  }

  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
  }

  SizedBox getFormField(
      {@required TextEditingController textController,
      @required String hint,
      TextInputType type,
      int maxLength,
      IconButton suffixIcon,
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
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: AppTextStyle.regular(
            Colors.grey,
            AppSingleton.instance.getSp(14),
          ),
        ),
      ),
    );
  }

  Widget buildScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Column(
              children: <Widget>[
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
                  textController: _password,
                  hint: 'New Password',
                  obscureText: !passwordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _retypePassword,
                  hint: 'Retype Password',
                  obscureText: !reTypePasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      reTypePasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        reTypePasswordVisible = !reTypePasswordVisible;
                      });
                    },
                  ),
                ),
                AppSingleton.instance.getSizedSpacer(30),
                BlocConsumer(
                  bloc: BlocProvider.of<ForgotPasswordBloc>(context),
                  listener: (context, state) {
                    if (state is ForgotPasswordSuccessState) {
                      _showSuccessMessage(state.response);
                    }
                    if (state is ForgotPasswordErrorState) {
                      _showError(state.msg);
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgotPasswordLoadingState) {
                      return AppSingleton.instance.buildCenterSizedProgressBar();
                    }
                    return buildSubmitButton();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool validate() {
    if (_mobile.text.isEmpty) {
      _showError('Please enter your mobile number');
      return false;
    } else if (_mobile.text.length != 10) {
      _showError('Please enter valid mobile number');
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

  Widget buildSubmitButton() {
    return SizedBox(
        width: double.infinity,
        height: AppSingleton.instance.getHeight(45),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(
              color: Colors.green,
            ),
          ),
          onPressed: () async {
            if (validate()) {
              scaffoldKey.currentState.hideCurrentSnackBar();
              BlocProvider.of<ForgotPasswordBloc>(context)
                  .add(ForgotPasswordEvent(mobileNo: _mobile.text));
            }
          },
          color: Colors.green,
          textColor: Colors.white,
          child: Text(
            "Submit",
            style: AppTextStyle.regular(Colors.white, 14.0),
          ),
        ));
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }

  void _showSuccessMessage(ForgotPasswordResponse forgotPasswordResponse) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
        AppSingleton.instance.getSuccessSnackBar(forgotPasswordResponse.msg));
    Timer(Duration(seconds: 1), () {
      signUp.Data data = signUp.Data(
          emailKey: forgotPasswordResponse.data.emailKey,
          msg: 'Success',
          mobile: _mobile.text);
      // data.newPassword = _password.text;
      signUp.SignUpResponse response =
          signUp.SignUpResponse(status: true, msg: 'SUCCESS', data: data);
      Navigator.pushReplacementNamed(context, Constants.ROUTE_OTP,
          arguments: response);
    });
  }

  onError(dynamic o) {
    if (o is String) {
      _showError(o);
    } else {
      _showError('Something went wrong!');
    }
  }
}
