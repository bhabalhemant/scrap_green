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

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String _id,
      _name,
      _email,
      _mobile,
      _address_line1,
      _address_line2,
      _country,
      _state,
      _city,
      _pin_code;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfilePageBloc>(context).add(GetProfile());
  }

  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
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
                    bloc: BlocProvider.of<ProfilePageBloc>(context),
                    listener: (context, state) {
//                      print(state);
                      if (state is ProfileLoaded) {
                        _setData(state.response);
                      }
                      if (state is ProfileUpdated) {
                        _showSuccessMessage(state.response.msg);
                        BlocProvider.of<ProfilePageBloc>(context).add(GetProfile());
                      }
                      if (state is ProfileError) {
                        _showError(state.msg);
                      }
                    },
                    builder: (context, state) {
                      if (state is ProfileLoaded) {
                        return profileScreen();
                      } else if (state is ProfileLoading) {
                        return Center(
                          child: AppSingleton.instance.buildCenterSizedProgressBar(),
                        );
                      } else if (state is ProfileError) {
                        return Center(
                          child: Text(
                            'Failed to get user data error',
                            style: AppTextStyle.bold(Colors.red, 30.0),
                          ),
                        );
                      } else if (state is ProfileUploading) {
                        return AppSingleton.instance.buildCenterSizedProgressBar();
                      } else if (state is ProfileEmpty) {
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
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: AssetImage('assets/settings_background.jpg'),
//                      fit: BoxFit.cover,
//                    ),
//                  ),
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
                  '${_name}',
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
                  '+91 ${_mobile}',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white
//                          fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  '${_email}',
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
              Navigator.pushNamed(context, Constants.ROUTE_EDIT_PROFILE);
            },
            leading: Icon(
              Icons.edit,
              color: Colors.green,
              size: 25,
            ),
            title: Text('Edit Profile',

              style: TextStyle(
                fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
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
              Navigator.pushNamed(context, Constants.ROUTE_CHANGE_PASSWORD);
            },
            leading: Icon(
              Icons.lock,
              color: Colors.green,
              size: 25,
            ),
            title: Text('Change Password',
              style: TextStyle(
                fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
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
            title: Text('Contact Us',

              style: TextStyle(
                fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
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
            title: Text('Logout',

              style: TextStyle(
                fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
            onTap: () async {
              var response = await Repository.instance.clearAllShardPrefs();
              if (response) {
//                        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
//                            Constants.ROUTE_SIGN_IN, (Route<dynamic> route) => false);
                Navigator.pushNamed(context, Constants.ROUTE_SIGN_IN);
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
  void _setData(ProfileResponse response) {
    print('test ${response.data}');
    _id = response.data.id;
    _name = response.data.name;
    _email = response.data.email;
    _mobile = response.data.mobile;
    _address_line1 = response.data.address_line1;
    _address_line2 = response.data.address_line2;
    _country = response.data.country;
    _state = response.data.state;
    _city = response.data.city;
    _pin_code = response.data.pin_code;
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
