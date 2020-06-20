import 'dart:async';

import 'package:dana/bloc/splash_bloc.dart';
import 'package:dana/models/response/profile_response.dart';
import 'package:dana/utils/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(SplashEvent());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true)
      ..init(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: BlocConsumer(
          bloc: BlocProvider.of<SplashBloc>(context),
          listener: (context, state) {
            if (state is SplashLoaded) {
              _navigate(validateData(state.response));
            }
            if (state is SplashError) {
              _navigate(false);
            }
          },
          builder: (context, state) {
            return buildUI();
          },
        ),
      ),
    );
  }

  Widget buildUI() {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(50.0),
      child: Center(
        child: Wrap(
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.fill,
              scale: 2.0,
            ),
          ],
        ),
      ),
    );
  }

  bool validateData(ProfileResponse signInResponse) {
    if (signInResponse != null &&
        signInResponse.data.name != null &&
        signInResponse.data.email != null &&
        signInResponse.data.mobile != null) {
      return true;
    } else {
      return false;
    }
  }

  void _navigate(bool isLoggedIn) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    Timer(Duration(seconds: 1), () {
      if (isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
            Constants.ROUTE_HOME, (Route<dynamic> route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
            Constants.ROUTE_SIGN_IN, (Route<dynamic> route) => false);
      }
    });
  }
}
