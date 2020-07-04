import 'dart:async';

import 'package:dana/base_widgets/app_textstyle.dart';
import 'package:dana/bloc/sign_in_bloc.dart';
import 'package:dana/utils/constants.dart' as Constants;
import 'package:dana/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  void dispose() {
    _mobile.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: buildSignInScreen(),
      ),
    );
  }

  Widget buildSignInScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        reverse: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/scrap_green_logo.png',
                    scale: 2.0,
                  ),
                ),
                SizedBox(
                  height: AppSingleton.instance.getHeight(50),
                ),
                SizedBox(
                  height: AppSingleton.instance.getHeight(45),
                  child: TextFormField(
                    controller: _mobile,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    maxLines: 1,
                    maxLengthEnforced: true,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(
                        RegExp("[0-9]"),
                      ),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25),
                      counterText: '',
                      counterStyle: const TextStyle(fontSize: 0),
                      fillColor: AppSingleton.instance.getLightGrayColor(),
                      border: AppSingleton.instance.getLightGrayOutLineBorder(),
                      focusedBorder:
                          AppSingleton.instance.getLightGrayOutLineBorder(),
                      disabledBorder:
                          AppSingleton.instance.getLightGrayOutLineBorder(),
                      enabledBorder:
                          AppSingleton.instance.getLightGrayOutLineBorder(),
                      errorBorder:
                          AppSingleton.instance.getLightGrayOutLineBorder(),
                      focusedErrorBorder:
                          AppSingleton.instance.getLightGrayOutLineBorder(),
                      filled: true,
                      hintText: 'Mobile',
                      hintStyle: AppTextStyle.regular(
                        Colors.grey,
                        AppSingleton.instance.getSp(14),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSingleton.instance.getHeight(15),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: SizedBox(
                    height: AppSingleton.instance.getHeight(45),
                    child: TextFormField(
                      controller: _password,
                      obscureText: !passwordVisible,
                      maxLines: 1,
                      maxLengthEnforced: true,
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 25),
                        counterText: '',
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        counterStyle: TextStyle(fontSize: 0),
                        fillColor: AppSingleton.instance.getLightGrayColor(),
                        border: AppSingleton.instance.getLightGrayOutLineBorder(),
                        focusedBorder:
                            AppSingleton.instance.getLightGrayOutLineBorder(),
                        disabledBorder:
                            AppSingleton.instance.getLightGrayOutLineBorder(),
                        enabledBorder:
                            AppSingleton.instance.getLightGrayOutLineBorder(),
                        errorBorder:
                            AppSingleton.instance.getLightGrayOutLineBorder(),
                        focusedErrorBorder:
                            AppSingleton.instance.getLightGrayOutLineBorder(),
                        filled: true,
                        hintText: 'Password',
                        hintStyle: AppTextStyle.regular(
                          Colors.grey,
                          AppSingleton.instance.getSp(14),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: AppSingleton.instance.getHeight(45),
                //   child: TextFormField(
                //     controller: _password,
                //     obscureText: true,
                //     maxLines: 1,
                //     maxLengthEnforced: true,
                //     maxLength: 50,
                //     keyboardType: TextInputType.text,
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 25),
                //       counterText: '',
                //       counterStyle: TextStyle(fontSize: 0),
                //       fillColor: AppSingleton.instance.getLightGrayColor(),
                //       border: AppSingleton.instance.getLightGrayOutLineBorder(),
                //       focusedBorder:
                //           AppSingleton.instance.getLightGrayOutLineBorder(),
                //       disabledBorder:
                //           AppSingleton.instance.getLightGrayOutLineBorder(),
                //       enabledBorder:
                //           AppSingleton.instance.getLightGrayOutLineBorder(),
                //       errorBorder:
                //           AppSingleton.instance.getLightGrayOutLineBorder(),
                //       focusedErrorBorder:
                //           AppSingleton.instance.getLightGrayOutLineBorder(),
                //       filled: true,
                //       hintText: 'Password',
                //       hintStyle: AppTextStyle.regular(
                //         Colors.grey,
                //         AppSingleton.instance.getSp(14),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: AppSingleton.instance.getHeight(30),
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppSingleton.instance.getHeight(45),
                  child: BlocConsumer(
                    bloc: BlocProvider.of<SignInBloc>(context),
                    listener: (context, state) {
                      if (state is SignInError) {
                        _showError(state.msg);
                      }
                      if (state is SignInLoaded) {
                        _showSuccessMessage(state.response.msg);
                      }
                    },
                    builder: (context, state) {
                      if (state is SignInLoading) {
                        return AppSingleton.instance
                            .buildCenterSizedProgressBar();
                      }
                      if (state is SignInLoaded) {
                        return AppSingleton.instance
                            .buildCenterSizedProgressBar();
                      }
                      return buildLoginButton();
                    },
                  ),
                ),
                SizedBox(
                  height: AppSingleton.instance.getHeight(50),
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppSingleton.instance.getHeight(45),
                  child: buildCreateAccountButton(),
                ),
                SizedBox(
                  height: AppSingleton.instance.getHeight(20),
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppSingleton.instance.getHeight(20),
                  child: buildForgotPassword(),
                ),
                SizedBox(
                  height: AppSingleton.instance.getHeight(20),
                ),
                Wrap(
                  children: <Widget>[
                    Image.asset(
                      'assets/endtoend.png',
                      fit: BoxFit.fill,
                      scale: 3.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSingleton.instance.getHeight(10),
                ),
              ],
            ),
          )
        ].reversed.toList(),
      ),
    );
  }

  Widget buildLoginButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: AppSingleton.instance.getPrimaryColor(),
        ),
      ),
      onPressed: () {
        if (validate()) {
          scaffoldKey.currentState.hideCurrentSnackBar();
          Map<String, String> body = {
            Constants.PARAM_MOBILE: _mobile.text,
            Constants.PARAM_PASSWORD: _password.text
          };
          BlocProvider.of<SignInBloc>(context).add(SignInEvent(body: body));
        }
      },
      color: AppSingleton.instance.getPrimaryColor(),
      textColor: Colors.white,
      child: Text(
        "Sign In",
        style: AppTextStyle.regular(Colors.white, 14.0),
      ),
    );
  }

  Widget buildCreateAccountButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: AppSingleton.instance.getSecondaryColor()),
      ),
      onPressed: () {
        Navigator.pushNamed(context, Constants.ROUTE_SELECT_TYPE);
      },
      color: AppSingleton.instance.getSecondaryColor(),
      textColor: Colors.white,
      child: Text(
        "Create your account",
        style: AppTextStyle.regular(Colors.white, 14.0),
      ),
    );
  }

  Widget buildForgotPassword() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Constants.ROUTE_FORGOT_PASSWORD);
        },
        child: Text(
          'Forgot Password?',
          style: AppTextStyle.bold(Colors.black87, 14.0),
        ),
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
    } else {
      return true;
    }
  }

  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, Constants.ROUTE_HOME);
    });
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
