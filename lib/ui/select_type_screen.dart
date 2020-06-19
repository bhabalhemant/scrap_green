import 'package:dana/base_widgets/app_textstyle.dart';
import 'package:dana/utils/constants.dart' as Constants;
import 'package:dana/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectTypeScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SelectTypeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: buildSelectTypeScreen(),
      ),
    );
  }

  Widget buildSelectTypeScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/scrap_green_logo.png',
              scale: 2.0,
            ),
          ),
          AppSingleton.instance.getSizedSpacer(30),
          Text(
            'Select your type',
            style: AppTextStyle.bold(Colors.black87, 20.0),
          ),
          AppSingleton.instance.getSizedSpacer(30),
          buildTypes('INS',onVendor),
          AppSingleton.instance.getSizedSpacer(20),
          buildTypes('INDVIDUAL',onUser),
        ],
      ),
    );
  }

  Widget buildTypes(String which,Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Card(
          color: which == 'INS'
              ? AppSingleton.instance.getPrimaryColor()
              : AppSingleton.instance.getSecondaryColor(),
          elevation: 5.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Image.asset(
                      which != 'INS'
                          ? 'assets/individual_white.png'
                          : 'assets/building_white.png',
                      scale: 2.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.15,
                maxWidth: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      which != 'INS'
                          ? 'Register as User'
                          : 'Register as Vendor',
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: AppTextStyle.bold(Colors.white, 18.0),
                    ),
                    // Text(
                    //   which == 'INS'
                    //       ? 'For making donations'
                    //       : 'For receiving donations',
                    //   textAlign: TextAlign.start,
                    //   maxLines: 3,
                    //   softWrap: false,
                    //   overflow: TextOverflow.fade,
                    //   style: AppTextStyle.light(Colors.white, 14.0),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onInstitute() {
    _launchURL();
  }

  _launchURL() async {
    const url = 'https://www.dana.foundation/signup';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showError('Could not launch $url');
    }
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }

  onUser() {
    if (scaffoldKey.currentContext != null) {
      Navigator.pushNamed(context, Constants.ROUTE_SIGN_UP);
    }
  }
  onVendor() {
    if (scaffoldKey.currentContext != null) {
      Navigator.pushNamed(context, Constants.ROUTE_SIGN_UP_VENDOR);
    }
  }
}
