import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_bloc.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_state.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_event.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/email_validator.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class VendorEditProfile extends StatefulWidget {
  @override
  _VendorEditProfileState createState() => _VendorEditProfileState();
}

class _VendorEditProfileState extends State<VendorEditProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final format = DateFormat("yyyy-MM-dd");
  String _id;
  TextEditingController
      _name,
      _email,
      _mobile,
      _address_line1,
      _address_line2,
      _country,
      _state,
      _city,
      _pin_code;

  Timer _timer;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _mobile.dispose();
    _address_line1.dispose();
    _address_line2.dispose();
    _country.dispose();
    _state.dispose();
    _city.dispose();
    _pin_code.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _mobile = TextEditingController();
    _address_line1 = TextEditingController();
    _address_line2 = TextEditingController();
    _country = TextEditingController();
    _state = TextEditingController();
    _city = TextEditingController();
    _pin_code = TextEditingController();
    BlocProvider.of<VendorProfileBloc>(context).add(GetProfile());
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Edit Profile'),
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
                    bloc: BlocProvider.of<VendorProfileBloc>(context),
                    listener: (context, state) {
                      if (state is VendorProfileLoaded) {
                        _setData(state.response);
                      }
                      if (state is VendorProfileUpdated) {
                        _showSuccessMessage(state.response.msg);
                        BlocProvider.of<VendorProfileBloc>(context).add(GetProfile());
                      }
                      if (state is VendorProfileError) {
                        _showError(state.msg);
                      }
                    },
                    builder: (context, state) {
                      if (state is VendorProfileLoaded) {
                        return buildSignUpScreen();
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
                      } else if (state is VendorProfileLoading) {
                        return AppSingleton.instance.buildCenterSizedProgressBar();
                      } else if (state is VendorProfileEmpty) {
                        return Center(
                          child: Text(
                            'Failed to get user data',
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
//          body: buildSignUpScreen(),
        ),
      ),
    );
  }

  SizedBox getFormField(
      {@required String hint,
        @required TextEditingController ctr,
        TextInputType type,
        int maxLength,
        BlacklistingTextInputFormatter restrictFormat,
        TextCapitalization textCap,
        bool obscureText = false}) {
    return SizedBox(
      height: AppSingleton.instance.getHeight(45),
      child: TextFormField(
        controller: ctr,
        obscureText: obscureText,
        textCapitalization:
        textCap == null ? TextCapitalization.sentences : textCap,
        keyboardType: type == null ? TextInputType.text : type,
        maxLength: maxLength == null ? null : maxLength,
        inputFormatters: restrictFormat == null ? null : [restrictFormat],
        maxLines: 1,
        maxLengthEnforced: true,
        decoration: InputDecoration(
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
          hintText: hint,
          hintStyle: AppTextStyle.regular(
            Colors.grey,
            AppSingleton.instance.getSp(14),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpScreen() {
    return ListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),

              getFormField(
                ctr: _name,
                hint: 'Name',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _email,
                hint: 'Email',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Room No./Street',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _address_line1,
                hint: 'Room No./Street',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Area',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _address_line2,
                hint: 'Area',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Country',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _country,
                hint: 'Country',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'State',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _state,
                hint: 'State',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'City',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _city,
                hint: 'City',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Pin Code',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _pin_code,
                hint: 'Pin Code',
                type: TextInputType.number,
                maxLength: 6,
              ),
              AppSingleton.instance.getSizedSpacer(30),
              SizedBox(
                width: double.infinity,
                height: AppSingleton.instance.getHeight(45),
                child: BlocConsumer(
                  bloc: BlocProvider.of<VendorProfileBloc>(context),
                  listener: (context, state) {
                    if (state is VendorProfileError) {
                      _showError(state.msg);
                    }
                    if (state is VendorProfileLoaded) {
                      _showSuccessMessage(state.response.msg);
                    }
                  },
                  builder: (context, state) {
//                    print('stste $state');
                    if (state is VendorProfileLoading) {
                      return AppSingleton.instance
                          .buildCenterSizedProgressBar();
                    }
                    if (state is VendorProfileLoaded) {
                      return buildUpdateButton();
                    }
                    return buildUpdateButton();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }


  Widget buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSingleton.instance.getHeight(50),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            // color: AppSingleton.instance.getPrimaryColor(),
              color: Colors.green
          ),
        ),
        onPressed: () {
          if (validate()) {
            scaffoldKey.currentState.hideCurrentSnackBar();
            Map<String, String> body = {
              Constants.PARAM_ID: _id,
              Constants.PARAM_NAME: _name.text,
              Constants.PARAM_EMAIL: _email.text,
//              Constants.PARAM_MOBILE: _mobile.text,
              Constants.PARAM_ADDRESS1: _address_line1.text,
              Constants.PARAM_ADDRESS2: _address_line2.text,
              Constants.PARAM_COUNTRY: _country.text,
              Constants.PARAM_STATE: _state.text,
              Constants.PARAM_CITY: _city.text,
              Constants.PARAM_PINCODE: _pin_code.text,
            };
            BlocProvider.of<VendorProfileBloc>(context)
                .add(UpdateProfile(body: body));
          }
        },
        // color: AppSingleton.instance.getPrimaryColor(),
        color: Colors.green,
        textColor: Colors.white,
        child: Text(
          "Update Profile",
          style: AppTextStyle.regular(Colors.white, 14.0),
        ),
      ),
    );
  }

  bool validate() {
    if (_address_line2.text.isEmpty) {
      _showError('Please enter your Area');
      return false;
    } else if (_name.text.isEmpty) {
      _showError('Please enter your name');
      return false;
    } else if (!EmailValidator.validate(_email.text)) {
      _showError('Please enter valid email');
      return false;
//    } else if (_mobile.text.isEmpty) {
//      _showError('Please enter your mobile number');
//      return false;
//    } else if (_mobile.text.length < 10) {
//      _showError('Please enter valid mobile number');
//      return false;
    } else if (_address_line1.text.isEmpty) {
      _showError('Please enter valid Room No./Street');
      return false;
    } else if (_country.text.isEmpty) {
      _showError('Please enter country');
      return false;
    } else if (_state.text.isEmpty) {
      _showError('Please enter state');
      return false;
    } else if (_city.text.isEmpty) {
      _showError('Please enter city');
      return false;
    } else if (_pin_code.text.isEmpty) {
      _showError('Please enter pincode');
      return false;
    } else {
      return true;
    }
  }

  void _setData(VendorProfileResponse response) {
//    print(response.data);
    _id = response.data.id;
    _name.text = response.data.name;
    _email.text = response.data.email;
    _mobile.text = response.data.mobile;
    _address_line1.text = response.data.address_line1;
    _address_line2.text = response.data.address_line2;
    _country.text = response.data.country;
    _state.text = response.data.state;
    _city.text = response.data.city;
    _pin_code.text = response.data.pin_code;
  }

  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
    _timer = new Timer(const Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, Constants.ROUTE_VENDOR_SETTINGS);
    });

  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
