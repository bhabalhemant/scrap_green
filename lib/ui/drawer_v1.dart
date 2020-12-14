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

class DrawerV1 extends StatefulWidget {
  @override
  _DrawerV1State createState() => _DrawerV1State();
}

class _DrawerV1State extends State<DrawerV1> {
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
    Navigator.pushNamed(context, Constants.ROUTE_HOME);
  }

  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: BlocProvider.of<ProfilePageBloc>(context),
      listener: (context, state) {

        if (state is ProfileLoaded) {
          _setData(state.response);
          print('yes2');
        }
      },
      builder: (context, state) {
//        print(state);
        if (state is ProfileLoading) {
          return AppSingleton.instance
              .buildCenterSizedProgressBar();
        }
        if (state is ProfileError) {
          return Center(
            child: Text(state.msg),
          );
        }
        if (state is ProfileLoaded) {
//          return text();
          return Screen();
        }
//        return text();
        return Screen();
      },
    );
  }
  Widget text() {
    return Text('qwert');
  }
  Widget Screen() {
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
                      child: Text(
                        _name,
//                        'ABC',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 8),
                      child: Text(
                        _email,
//                        'ABC',
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
                leading: Image.asset('assets/pick.png',
                    width: 30, height: 30, fit: BoxFit.contain
                ),

                title: Text(
                  LocaleKeys.schedule_pick_up,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                onTap: () {
                  Navigator.pushNamed(
                      context, Constants.ROUTE_PROFILE);
                },
              ),
              ListTile(
                leading: Image.asset('assets/history.png',
                    width: 30, height: 30, fit: BoxFit.contain
                ),
                title: Text(
                  // "SCHEDULE PICKUP",
                  LocaleKeys.check_history,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                onTap: () {
                  Navigator.pushNamed(
                      context, Constants.ROUTE_HISTORY);
                },
              ),
              ListTile(
                leading: Image.asset('assets/contribution.png',
                    width: 30, height: 30, fit: BoxFit.contain
                ),
                title: Text(
                  // "SCHEDULE PICKUP",
                  LocaleKeys.my_contribution,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pushNamed(
                      context, Constants.ROUTE_MY_CONTRIBUTION);
                },
              ),
              ListTile(
                leading: Image.asset('assets/help.png',
                    width: 30, height: 30, fit: BoxFit.contain
                ),
                title: Text(
                  // "SCHEDULE PICKUP",
                  LocaleKeys.ask_help,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                onTap: () {
                  Navigator.pushNamed(
                      context, Constants.ROUTE_CONTACT_US);
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

                  Navigator.pushNamed(
                      context, Constants.ROUTE_SETTING);
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
                  // "SCHEDULE PICKUP",
//                LocaleKeys.ask_help,
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                onTap: () async {
//                  print('logout');
                  var response = await Repository.instance.clearAllShardPrefs();
                  if (response) {
                    Navigator.pushNamed(context, Constants.ROUTE_SIGN_IN);
//                    Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
//                        Constants.ROUTE_SIGN_IN, (Route<dynamic> route) => false);
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
