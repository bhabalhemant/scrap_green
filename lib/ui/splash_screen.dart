import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scrapgreen/bloc/splash_bloc.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(SplashEvent(fcmId: ''));
    geoloator();
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
    Timer(Duration(seconds: 1), () async {
      if (isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
            Constants.ROUTE_HOME, (Route<dynamic> route) => false);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var localeSaved = prefs.getInt("localeSaved");
        if (localeSaved != null && localeSaved == 1) {
          Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
              Constants.ROUTE_SIGN_IN, (Route<dynamic> route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
              Constants.ROUTE_SELECT_LANGUAGE, (Route<dynamic> route) => false);
        }
      }
    });
  }

  geoloator() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

}
