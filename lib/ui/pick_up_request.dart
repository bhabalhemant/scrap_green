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

class PickUpRequest extends StatefulWidget {
  @override
  _PickUpRequestState createState() => _PickUpRequestState();
}

class _PickUpRequestState extends State<PickUpRequest> {
  // Position _currentPosition;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final format = DateFormat("yyyy-MM-dd");
bool selected=true ;
  TextEditingController 
      _name,
      _email,
      _mobile,
      _address1,
      _address2,
      _country,
      _state,
      _city,
      _pinCode,
      _password,
      _retypePassword;
  String _aadhar_card;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _mobile = TextEditingController();
    _address1 = TextEditingController();
    _address2 = TextEditingController();
    _country = TextEditingController();
    _state = TextEditingController();
    _city = TextEditingController();
    _pinCode = TextEditingController();
    _password = TextEditingController();
    _retypePassword = TextEditingController();
    // _getCurrentLocation();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _mobile.dispose();
    _address1.dispose();
    _address2.dispose();
    _country.dispose();
    _state.dispose();
    _city.dispose();
    _pinCode.dispose();
    _password.dispose();
    _retypePassword.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.of(scaffoldKey.currentContext).pop(true);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Pick Up Request'),
          body: buildSignUpScreen(),
        ),
      ),
    );
  }

  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
  }

  SizedBox getFormField(
      {@required TextEditingController textController,
      @required String hint,
      TextInputType type,
      int maxLength,
      WhitelistingTextInputFormatter restrictFormat,
      TextCapitalization textCap,
      bool obscureText = false}) {
    return SizedBox(
      height: AppSingleton.instance.getHeight(45),
      child: TextFormField(
        controller: textController,
        obscureText: obscureText,
        textCapitalization:
            textCap == null ? TextCapitalization.sentences : textCap,
        keyboardType: type == null ? TextInputType.text : type,
        maxLength: maxLength == null ? null : maxLength,
        inputFormatters: restrictFormat == null ? null : [restrictFormat],
        maxLines: 1,
        maxLengthEnforced: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 25),
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Column(
              children: <Widget>[
                AppSingleton.instance.getSpacer(),
                getFormField(
                    textController: _name,
                    hint: 'Name',
                    type: TextInputType.text,
                    ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                    textController: _email,
                    hint: 'Email',
                    type: TextInputType.emailAddress,
                    textCap: TextCapitalization.none),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _mobile,
                  hint: 'Mobile Number',
                  type: TextInputType.number,
                  maxLength: 10,
                  restrictFormat: WhitelistingTextInputFormatter(
                    RegExp("[0-9]"),
                  ),
                ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                    textController: _address1,
                    hint: 'Room No./Street',
                    type: TextInputType.text,
                    ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                    textController: _address2,
                    hint: 'Area',
                    type: TextInputType.text,
                    ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                    textController: _country,
                    hint: 'Country',
                    type: TextInputType.text,
                    ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                    textController: _state,
                    hint: 'State',
                    type: TextInputType.text,
                    ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                    textController: _city,
                    hint: 'City',
                    type: TextInputType.text,
                    ),
                AppSingleton.instance.getSpacer(),
                getFormField(
                  textController: _pinCode,
                  hint: 'Pin Code',
                  type: TextInputType.number,
                  maxLength: 6,
                  restrictFormat: WhitelistingTextInputFormatter(
                    RegExp("[0-9]"),
                  ),
                ),
                AppSingleton.instance.getSpacer(),
                
                AppSingleton.instance.getSpacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                    child: DateTimeField(
                    format: format,
                    // controller: dOBCTRL,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    decoration: InputDecoration(
                      // counterStyle: TextStyle(fontSize: 11),
                      fillColor: AppSingleton.instance.getLightGrayColor(),
                      border: AppSingleton.instance.getLightGrayOutLineBorder(),
                      focusedBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
                      disabledBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
                      enabledBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
                      errorBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
                      focusedErrorBorder: AppSingleton.instance.getLightGrayOutLineBorder(),
                      filled: true,
                      hintText: 'Schedule Date',
                      // errorText: _autoValidate ? 'Value Can\'t Be Empty' : null,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
  //               // SizedBox(
  //               //   height: 10,
  //               // ),
  //               // Align(
  //               //   alignment: Alignment.centerRight,
  //               //   child: BlocConsumer(
  //               //     bloc: BlocProvider.of<SignUpBloc>(context),
  //               //     listener: (context, state) {},
  //               //     builder: (context, state) {
  //               //       if (state is FileSelected) {
  //               //         return Padding(
  //               //           padding:
  //               //               EdgeInsets.only(bottom: 5, right: 10, left: 10),
  //               //           child: Text(
  //               //             state.path.split('/').last,
  //               //             softWrap: false,
  //               //             maxLines: 1,
  //               //             textAlign: TextAlign.left,
  //               //             style: AppTextStyle.regular(Colors.black87,
  //               //                 AppSingleton.instance.getSp(9.0)),
  //               //           ),
  //               //         );
  //               //       }
  //               //       return AppSingleton.instance.getBlankContainer();
  //               //     },
  //               //   ),
  //               // ),
  //               // Align(
  //               //   alignment: Alignment.centerRight,
  //               //   child: SizedBox(
  //               //     height: 30,
  //               //     width: 150,
  //               //     child: buildAadharButton(),
  //               //   ),
  //               // ),
                // AppSingleton.instance.getSizedSpacer(40),
                // SizedBox(
                //   height: AppSingleton.instance.getHeight(45),
                //   width: double.infinity,
                  // child: BlocConsumer(
                  //   bloc: BlocProvider.of<SignUpBloc>(context),
                  //   listener: (context, state) {
                  //     if (state is SignUpError) {
                  //       _showError(state.msg);
                  //     }
                  //     if (state is SignUpLoaded) {
                  //       _showSuccessMessage(
                  //           state.response.data.msg, state.response);
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     if (state is SignUpLoading) {
                  //       return AppSingleton.instance
                  //           .buildCenterSizedProgressBar();
                  //     }
                  //     if (state is SignUpLoaded) {
                  //       return AppSingleton.instance
                  //           .buildCenterSizedProgressBar();
                  //     }
                  //     return buildSignUpButton();
                  //   },
                  // ),
                // ),
                // AppSingleton.instance.getSizedSpacer(30),
              ],
            ),
          )
        ],
      ),
  //   );
  // }

  // Widget buildSignUpButton() {
  //   return RaisedButton(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(30.0),
  //       side: BorderSide(
  //         color: AppSingleton.instance.getPrimaryColor(),
  //       ),
  //     ),
  //     onPressed: () async {
  //       if (validate()) {
  //         scaffoldKey.currentState.hideCurrentSnackBar();
  //         // _getCurrentLocation();
  //         final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  //   geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  // //         print(position);
  //     // setState(() {
  //           _currentPosition = position;
  //           String _position = _currentPosition.latitude.toString() +'-'+ _currentPosition.longitude.toString();
  //           print(_position);
  //         // });
        
  //         // String fileName = _aadhar_card.split('/').last;
  //         dio.FormData formData = dio.FormData.fromMap({
  //           Constants.PARAM_NAME: _name.text,
  //           Constants.PARAM_EMAIL: _email.text,
  //           Constants.PARAM_MOBILE: _mobile.text,
  //           Constants.PARAM_ADDRESS1: _address1.text,
  //           Constants.PARAM_ADDRESS2: _address2.text,
  //           Constants.PARAM_COUNTRY: _country.text,
  //           Constants.PARAM_STATE: _state.text,
  //           Constants.PARAM_CITY: _city.text,
  //           Constants.PARAM_PINCODE: _pinCode.text,
  //           Constants.PARAM_PASSWORD: _password.text,
  //           Constants.PARAM_LATITUDE_LONGITUDE: _position,
  //           // Constants.PARAM_AADHAR_CARD: await dio.MultipartFile.fromFile(
  //           //     _aadhar_card,
  //           //     filename: fileName)
  //         });
  //         BlocProvider.of<SignUpBloc>(context).add(SignUpEvent(body: formData));
  //         }).catchError((e) {
  //         print(e);
  //       });
  //       }
  //     },
  //     color: AppSingleton.instance.getPrimaryColor(),
  //     textColor: Colors.white,
  //     child: Text(
  //       "Sign Up",
  //       style: AppTextStyle.regular(Colors.white, 14.0),
  //     ),
    );
  }
}