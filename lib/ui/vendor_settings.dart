import 'package:flutter/cupertino.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
//import 'package:scrapgreen/bloc/settings/cp_bloc.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import '../repository/repository.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_bloc.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_event.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_state.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class VendorSettings extends StatefulWidget {
  @override
  _VendorSettingsState createState() => _VendorSettingsState();
}

class _VendorSettingsState extends State<VendorSettings> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String _id,
      _name,
      _email,
      _mobile;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VendorProfileBloc>(context).add(GetProfile());
  }

  onTap() {
      Navigator.pushNamed(context, Constants.ROUTE_VENDOR_REQUEST);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return AppSingleton.instance.goBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Settings'),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: BlocConsumer(
                    bloc: BlocProvider.of<VendorProfileBloc>(context),
                    listener: (context, state) {
//                      print(state);
                      if (state is VendorProfileLoaded) {
                        _setData(state.response);
                      }
//                      if (state is ProfileUpdated) {
//                        _showSuccessMessage(state.response.msg);
//                        BlocProvider.of<ProfilePageBloc>(context).add(GetProfile());
//                      }
                      if (state is VendorProfileError) {
                        _showError(state.msg);
                      }
                    },
                    builder: (context, state) {
                      if (state is VendorProfileLoaded) {
                        return profileScreen();
                      } else if (state is VendorProfileLoading) {
                        return Center(
                          child: AppSingleton.instance.buildCenterSizedProgressBar(),
                        );
                      } else if (state is VendorProfileError) {
                        return Center(
                          child: Text(
                            'Failed to get user data error',
                            style: AppTextStyle.bold(Colors.red, 30.0),
                          ),
                        );
                      } else if (state is VendorProfileEmpty) {
                        return Center(
                          child: Text(
                            'Failed to get user data profile empty',
                            style: AppTextStyle.bold(Colors.red, 30.0),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
//                profileScreen(),
              ],
            ),
          ),
//          body: profileScreen(),
        ),
      ),
    );
  }

  Widget profileScreen() {
    return ListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200.0,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 75,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20.0),
                height: 25.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14.0,
//                              fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
//                  'Hemant Bhabal',
                _name,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
//                  '+91 7738242013',
                '+91 ${_mobile}',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
//                  'hemant@apptroid.com',
                _email,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white
//                          fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, Constants.ROUTE_VENDOR_EDIT_PROFILE);
            },
            leading: Icon(
              Icons.edit,
              color: Colors.green,
              size: 25,
            ),
            title: Text(
                LocaleKeys.edit_profile,
              style: TextStyle(
                fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ).tr(),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ),
        ),
        Divider(),
        Container(
          child: ListTile(
            onTap: (){
              Navigator.pushNamed(context, Constants.ROUTE_VENDOR_CHANGE_PASSWORD);
            },
            leading: Icon(
              Icons.lock,
              color: Colors.green,
              size: 25,
            ),
            title: Text(
              LocaleKeys.change_password,
              style: TextStyle(
                fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ).tr(),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ),
        ),
        Divider(),
        Container(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, Constants.ROUTE_CONTACT_US);
            },
            leading: Icon(
              Icons.call,
              color: Colors.green,
              size: 25,
            ),
            title: Text(
              LocaleKeys.contact_us,

              style: TextStyle(
                fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ).tr(),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ),
        ),
        Divider(),
        Container(
          child: ListTile(
            leading: Icon(
              Icons.lock,
              color: Colors.green,
              size: 25,
            ),
            title: Text(
          LocaleKeys.logout,

              style: TextStyle(
                fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ).tr(),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
            onTap: () async {
              var response = await Repository.instance.clearAllShardPrefs();
              if (response) {
                Navigator.pushNamed(context, Constants.ROUTE_SIGN_IN_VENDOR);
              } else {
                _showError('Failed to log out');
              }
            },
          ),
        ),
        Divider(),
      ],
    );
  }
  void _setData(VendorProfileResponse response) {
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
