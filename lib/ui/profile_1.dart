import 'package:flutter/cupertino.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/profile_page/profile_bloc.dart';
import 'package:scrapgreen/bloc/profile_page/profile_event.dart';
import 'package:scrapgreen/bloc/profile_page/profile_state.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.of(scaffoldKey.currentContext).pop(true);
    return false;
  }
  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return AppSingleton.instance.goBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Profile'),
          key: scaffoldKey,
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
        SingleChildScrollView(
          child: Column(
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

                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Constants.ROUTE_EDIT_PROFILE);
                      print('yes');
                      },
                      color: Colors.white,
//                      textColor: Colors.white,
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
//                  color: Colors.grey,
//                height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                  ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          'Street :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          '${_address_line1}',
                          style: TextStyle(
//                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
//                  color: Colors.grey,
//                height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
//                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          'Area :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          '${_address_line2}',
                          style: TextStyle(
//                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
//                  color: Colors.grey,
//                height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
//                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          'Country :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          '${_country}',
                          style: TextStyle(
//                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
//                  color: Colors.grey,
//                height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
//                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          'State :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          '${_state}',
                          style: TextStyle(
//                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
//                  color: Colors.grey,
//                height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
//                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          'City :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          '${_city}',
                          style: TextStyle(
//                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          'Pin Code :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          '${_pin_code}',
                          style: TextStyle(
//                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ),
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
