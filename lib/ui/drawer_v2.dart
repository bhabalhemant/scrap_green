import 'package:flutter/cupertino.dart';
//import 'package:scrapgreen/bloc/settings/cp_bloc.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import '../repository/repository.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/bloc/profile_page/profile_bloc.dart';
import 'package:scrapgreen/bloc/profile_page/profile_event.dart';
import 'package:scrapgreen/bloc/profile_page/profile_state.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class DrawerV2 extends StatefulWidget {
  @override
  _DrawerV2State createState() => _DrawerV2State();
}

class _DrawerV2State extends State<DrawerV2> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String _id,
      _name,
      _email,
      _mobile;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfilePageBloc>(context).add(GetProfile());
  }

  onTap() {
    Navigator.pushNamed(context, Constants.ROUTE_VENDOR_REQUEST);
  }

  Widget build(BuildContext context) {
    return SizedBox(
      child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 75,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 30, 0, 8),
                      child: Text('Hemant Bhabal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
//              leading: Icon(Icons.lock),
                leading: Container(
                  width: 30,
                  height: 30,
//              color: Colors.green,
                  decoration:
                  BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:Icon(Icons.settings, color: Colors.green,),
                ),
                title: Text(
                  'SETTINGS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                onTap: () async {
                  Navigator.pushNamed(context, Constants.ROUTE_VENDOR_SETTINGS);
                },
              ),
              ListTile(
//              leading: Icon(Icons.lock),
                leading: Container(
                  width: 30,
                  height: 30,
//              color: Colors.green,
                  decoration:
                  BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:Icon(Icons.lock, color: Colors.green,),
                ),
                title: Text(
//                LocaleKeys.ask_help,
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                onTap: () async {
                  var response = await Repository.instance.clearAllShardPrefs();
//                    print(response);
                  if (response) {
                    Navigator.pushNamed(context, Constants.ROUTE_SIGN_IN_VENDOR);
//                      Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
//                          Constants.ROUTE_SIGN_IN_VENDOR, (Route<dynamic> route) => false);
                  } else {
                    _showError('Failed to log out');
                  }
                },
              ),
            ],
          ),
        ),
      ),

    );
  }

  void _setData(ProfileResponse response) {
    print('test ${response.data}');
    _id = response.data.id;
    _name = response.data.name;
    _email = response.data.email;
    _mobile = response.data.mobile;
  }

  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
  }
  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
