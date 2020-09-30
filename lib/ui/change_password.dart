import 'package:flutter/material.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:flutter/services.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/models/response/password_response.dart';
import 'package:scrapgreen/bloc/change_password/cp_bloc.dart';
import 'package:scrapgreen/bloc/change_password/cp_event.dart';
import 'package:scrapgreen/bloc/change_password/cp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/repository.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String _id;
  TextEditingController _old_password = TextEditingController();
  TextEditingController _new_password = TextEditingController();
  TextEditingController _confirm_password = TextEditingController();
  bool passwordVisible1;
  bool passwordVisible2;
  bool passwordVisible3;
  void initState() {
    super.initState();
    passwordVisible1 = false;
    passwordVisible2 = false;
    passwordVisible3 = false;
    BlocProvider.of<ChangePasswordBloc>(context).add(GetPassword());
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Change Password'),
//          body: buildChangePasswordScreen(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: BlocConsumer(
                    bloc: BlocProvider.of<ChangePasswordBloc>(context),
                    listener: (context, state) {
                      print(state.response);
                      if (state is ChangePasswordLoaded) {
                        _setData(state.response);
                      }
                      if (state is PasswordUpdated) {
                        _showSuccessMessage(state.response.msg);
                        BlocProvider.of<ChangePasswordBloc>(context).add(GetPassword());
                      }
                      if (state is ChangePasswordError) {
                        _showError(state.msg);
                      }
                    },
                    builder: (context, state) {
                      if (state is ChangePasswordLoaded) {
                        return buildChangePasswordScreen();
                      } else if (state is ChangePasswordUploading) {
                        return Center(
                          child: AppSingleton.instance.buildCenterSizedProgressBar(),
                        );
                      } else if (state is ChangePasswordError) {
                        return Center(
                          child: Text(
                            'Failed to get user data error',
                            style: AppTextStyle.bold(Colors.red, 30.0),
                          ),
                        );
                      } else if (state is ChangePasswordUploading) {
                        return AppSingleton.instance.buildCenterSizedProgressBar();
                      } else if (state is ChangePasswordEmpty) {
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

  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
  }

  Widget buildChangePasswordScreen () {
    return ListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: <Widget>[
              AppSingleton.instance.getSpacer(),
              TextFormField(
                controller: _old_password,
                obscureText: !passwordVisible1,
                maxLines: 1,
                maxLengthEnforced: true,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25),
                  counterText: '',
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible1
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible1 = !passwordVisible1;
                      });
                    },
                  ),
                  counterStyle: TextStyle(fontSize: 0),
                  fillColor: AppSingleton.instance.getLightGrayColor(),
                  border: AppSingleton.instance.getLightGrayOutLineBorder(),
                  focusedBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  disabledBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  enabledBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  errorBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  focusedErrorBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  filled: true,
                  hintText: 'Old Password',
                  hintStyle: AppTextStyle.regular(
                    Colors.grey,
                    AppSingleton.instance.getSp(14),
                  ),
                ),
              ),
              AppSingleton.instance.getSpacer(),
              TextFormField(
                controller: _new_password,
                obscureText: !passwordVisible2,
                maxLines: 1,
                maxLengthEnforced: true,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25),
                  counterText: '',
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible2 = !passwordVisible2;
                      });
                    },
                  ),
                  counterStyle: TextStyle(fontSize: 0),
                  fillColor: AppSingleton.instance.getLightGrayColor(),
                  border: AppSingleton.instance.getLightGrayOutLineBorder(),
                  focusedBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  disabledBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  enabledBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  errorBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  focusedErrorBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  filled: true,
                  hintText: 'New Password',
                  hintStyle: AppTextStyle.regular(
                    Colors.grey,
                    AppSingleton.instance.getSp(14),
                  ),
                ),
              ),
              AppSingleton.instance.getSpacer(),
              TextFormField(
                controller: _confirm_password,
                obscureText: !passwordVisible3,
                maxLines: 1,
                maxLengthEnforced: true,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25),
                  counterText: '',
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible3
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible3 = !passwordVisible3;
                      });
                    },
                  ),
                  counterStyle: TextStyle(fontSize: 0),
                  fillColor: AppSingleton.instance.getLightGrayColor(),
                  border: AppSingleton.instance.getLightGrayOutLineBorder(),
                  focusedBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  disabledBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  enabledBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  errorBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  focusedErrorBorder:
                  AppSingleton.instance.getLightGrayOutLineBorder(),
                  filled: true,
                  hintText: 'Confirm Password',
                  hintStyle: AppTextStyle.regular(
                    Colors.grey,
                    AppSingleton.instance.getSp(14),
                  ),
                ),
              ),
              AppSingleton.instance.getSpacer(),
              buildUpdateButton()
            ],
          ),
        )
      ],
    );
  }

  Widget buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSingleton.instance.getHeight(40),
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
              Constants.PARAM_OLD_PASS: _old_password.text,
              Constants.PARAM_NEW_PASS: _new_password.text,
            };
            print(body);
            BlocProvider.of<ChangePasswordBloc>(context)
                .add(UpdatePassword(body: body));
          }
        },
        // color: AppSingleton.instance.getPrimaryColor(),
        color: Colors.green,
        textColor: Colors.white,
        child: Text(
          "Change Password",
          style: AppTextStyle.regular(Colors.white, 14.0),
        ),
      ),
    );
  }

  bool validate() {
    if (_old_password.text.isEmpty) {
      _showError('Please enter your Old Password');
      return false;
    } else if (_new_password.text.isEmpty) {
      _showError('Please enter your New Password');
      return false;
    } else if (_confirm_password.text.isEmpty) {
      _showError('Please enter your Confirm Password');
      return false;
    } else if (_new_password.text != _confirm_password.text) {
      _showError('Password not matched!');
      return false;
    } else {
      return true;
    }
  }

  void _setData(PasswordResponse response) {
//    print('test ${response.data}');
    _id = response.data.id;
  }
  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
    var context = 'Please login again with new password.';
    showAlertDialog();
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }

  showAlertDialog() {  // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pushNamed(context, Constants.ROUTE_HOME);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Logout"),
      onPressed:  () async {
        var response = await Repository.instance.clearAllShardPrefs();
        if (response) {
                        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
                            Constants.ROUTE_SIGN_IN, (Route<dynamic> route) => false);
//          Navigator.pushNamed(context, Constants.ROUTE_SIGN_IN);
        } else {
          _showError('Failed to log out');
        }
      },
    );  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
//      title: Text("AlertDialog"),
      content: Text("Please login again with new password?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );  // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
