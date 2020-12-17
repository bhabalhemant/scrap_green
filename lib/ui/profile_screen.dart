import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/profile/profile_bloc.dart';
import 'package:scrapgreen/bloc/profile/profile_event.dart';
import 'package:scrapgreen/bloc/profile/profile_state.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/email_validator.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Position _currentPosition;
  String _position;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final format = DateFormat("yyyy-MM-dd");
  String _id, schedule_date;
  String formattedDate;
  TextEditingController 
      _name,
      _email,
      _mobile,
      _address_line1,
      _address_line2,
      _country,
      _state,
      _city,
      _pin_code,
      _schedule_date,
      _password,
      _retypePassword;
  String _aadhar_card;
  String pickedDate;

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
    _schedule_date = TextEditingController();
    _password = TextEditingController();
    _retypePassword = TextEditingController();
//    pickedDate = DateTime.now();
     setLocation();
    BlocProvider.of<ProfileBloc>(context).add(GetProfile());
  }
var now = new DateTime.now();
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
    _schedule_date.dispose();
    _password.dispose();
    _retypePassword.dispose();
    super.dispose();
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Schedule Pickup'),
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
                    bloc: BlocProvider.of<ProfileBloc>(context),
                    listener: (context, state) {
                      if (state is ProfileLoaded) {
                        _setData(state.response);
                      }
                      if (state is ProfileUpdated) {
                        _showSuccessMessage(state.response.msg);
                        BlocProvider.of<ProfileBloc>(context).add(GetProfile());
                      }
                      if (state is ProfileError) {
                        _showError(state.msg);
                      }
                    },
                    builder: (context, state) {
                      if (state is ProfileLoaded) {
                        return buildSignUpScreen();
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
                // getFormField(
                //     ctr: _email,
                //     hint: 'Email',
                //     type: TextInputType.emailAddress,
                //     textCap: TextCapitalization.none),
                // AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Mobile No.',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                  ctr: _mobile,
                  hint: 'Mobile Number',
                  type: TextInputType.number,
                  maxLength: 10,
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
                    'Pincode',
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

              AppSingleton.instance.getSpacer(),
              // Container(
              //   // color: Colors.grey,
              //   width: MediaQuery.of(context).size.width,
              //   child: FlatButton(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //       side: BorderSide(
              //         color: Colors.grey,
              //       ),
              //     ),
              //     onPressed: () {
              //       DatePicker.showDateTimePicker(context, showTitleActions: true, 
              //       onChanged: (date) {
              //         // print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
              //       }, onConfirm: (date) {
              //         print('confirm $date');
              //         schedule_date = date.toString();
              //       }, currentTime: now);
              //     },
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(vertical:10.0),
              //       child: Text(
              //         'Schedule Date',
              //         textAlign: TextAlign.left,
              //         style: TextStyle(fontSize: 16.0),
              //       ),
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Schedule Date',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(width: 5, color: Colors.grey[200])
                ),
                child: ListTile(
                  title: Text(
                    formattedDate == null
                    ? "Schedule Date"
                    : "${formattedDate}",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.access_time,
                    color: Colors.black,
                  ),
                  onTap: _pickDate,
                ),
              ),

                AppSingleton.instance.getSizedSpacer(30),
              SizedBox(
                width: double.infinity,
                height: AppSingleton.instance.getHeight(45),
                child: BlocConsumer(
                  bloc: BlocProvider.of<ProfileBloc>(context),
                  listener: (context, state) {
                    if (state is ProfileError) {
                      _showError(state.msg);
                    }
                    if (state is ProfileLoaded) {
                      _showSuccessMessage(state.response.msg);
                    }
                  },
                  builder: (context, state) {
                    print('stste $state');
                    if (state is ProfileLoading) {
                      return AppSingleton.instance
                          .buildCenterSizedProgressBar();
                    }
                    if (state is ProfileLoaded) {
//                      return AppSingleton.instance
//                          .buildCenterSizedProgressBar();
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
              Constants.PARAM_SCHEDULE_DATE: pickedDate,
              Constants.PARAM_MOBILE: _mobile.text,
              Constants.PARAM_ADDRESS1: _address_line1.text,
              Constants.PARAM_ADDRESS2: _address_line2.text,
              Constants.PARAM_COUNTRY: _country.text,
              Constants.PARAM_STATE: _state.text,
              Constants.PARAM_CITY: _city.text,
              Constants.PARAM_PINCODE: _pin_code.text,
              Constants.PARAM_LATITUDE_LONGITUDE: _position,
            };
            BlocProvider.of<ProfileBloc>(context)
                .add(UpdateProfile(body: body));
                
          }
        },
        // color: AppSingleton.instance.getPrimaryColor(),
        color: Colors.green,
        textColor: Colors.white,
        child: Text(
          "Schedule Pick up",
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
    } else if (_mobile.text.isEmpty) {
      _showError('Please enter your mobile number');
      return false;
    } else if (_mobile.text.length < 10) {
      _showError('Please enter valid mobile number');
      return false;
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
    } else if (pickedDate == null) {
      _showError('Please enter Pickup date.');
      return false;
    } else {
      return true;
    }
  }

  setLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print(position);
      setState(() {
        _currentPosition = position;
        _position = _currentPosition.latitude.toString() +'/'+ _currentPosition.longitude.toString();
//        print(_position);
      });
    }).catchError((e) {
      print(e);
    });
  }

  _pickDate() {
    DatePicker.showDateTimePicker(context, showTitleActions: true, 
    onChanged: (date) {
      // print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
//      print('confirm $date');
      setState(() {
        formattedDate = DateFormat('dd-MM-yyyy – h:mm a').format(date);

        pickedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
              if(pickedDate == null)
                print('confirm');
              else
                print('confirm $pickedDate');
      });
      // schedule_date = date.toString();
    }, currentTime: now);
  }

  void _setData(ProfileResponse response) {
    print(response.data);
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
    Navigator.pushNamed(context, Constants.ROUTE_HISTORY);
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
