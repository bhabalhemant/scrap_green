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
  void initState() {
    super.initState();
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
              getFormField(
                ctr: _old_password,
                hint: 'Old password',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              getFormField(
                ctr: _new_password,
                hint: 'New password',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              getFormField(
                ctr: _confirm_password,
                hint: 'Confirm new password',
                type: TextInputType.text,
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
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }

}
