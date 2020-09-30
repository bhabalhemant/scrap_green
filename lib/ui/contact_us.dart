import 'package:flutter/material.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:flutter/services.dart';
import 'package:scrapgreen/bloc/contact_us_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'dart:async';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _subject = TextEditingController();
  TextEditingController _message = TextEditingController();
  Timer _timer;

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.of(scaffoldKey.currentContext).pop(true);
    return false;
  }

  @override
  void dispose() {
    _email.dispose();
    _subject.dispose();
    _message.dispose();
    super.dispose();
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Contact Us'),
          body: buildChangePasswordScreen(),
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
              firstBlock (),
              AppSingleton.instance.getSpacer(),
              getFormField(
                ctr: _email,
                hint: 'Email',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              getFormField(
                ctr: _subject,
                hint: 'Subject',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              getFormField(
                ctr: _message,
                hint: 'Message',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              SizedBox(
                width: double.infinity,
                height: AppSingleton.instance.getHeight(45),
                child: BlocConsumer(
                  bloc: BlocProvider.of<ContactUsBloc>(context),
                  listener: (context, state) {
                    if (state is ContactUsError) {
                      _showError(state.msg);
                    }
                    if (state is ContactUsLoaded) {
                      _showSuccessMessage(state.response.msg);
                    }
                  },
                  builder: (context, state) {
                    if (state is ContactUsLoading) {
                      return AppSingleton.instance
                          .buildCenterSizedProgressBar();
                    }
                    if (state is ContactUsLoaded) {
//                        return AppSingleton.instance
//                            .buildCenterSizedProgressBar();
                      return buildUpdateButton();
                    }
                    return buildUpdateButton();
                  },
                ),
              )
//              buildUpdateButton()
            ],
          ),
        )
      ],
    );
  }

  Widget firstBlock () {
    return Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
              child: Text(
                'GET IN TOUCH WITH US!',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),
          ),
        AnimatedContainer(
        // Use the properties stored in the State class.
        width: MediaQuery.of(context).size.width,
        height: 135.0,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15.0),
        ),
        // Define how long the animation should take.
        duration: Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Allahabad Bank, Chembur.'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.call),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('+91 7738242013'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.email),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('hemant@apptroid.com'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
//      Container(
//      color: Colors.grey,
//      decoration: Decoration(
//
//      ),
//
//    );
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
              Constants.PARAM_EMAIL: _email.text,
              Constants.PARAM_SUBJECT: _subject.text,
              Constants.PARAM_MESSAGE: _message.text
            };
            BlocProvider.of<ContactUsBloc>(context).add(ContactUsEvent(body: body));
          }
        },
        // color: AppSingleton.instance.getPrimaryColor(),
        color: Colors.green,
        textColor: Colors.white,
        child: Text(
          "Send",
          style: AppTextStyle.regular(Colors.white, 14.0),
        ),
      ),
    );
  }

  bool validate() {
    if (_email.text.isEmpty) {
      _showError('Please enter your email');
      return false;
    } else if (_subject.text.isEmpty) {
      _showError('Please enter your subject');
      return false;
    } else if (_message.text.isEmpty) {
      _showError('Please enter your message');
      return false;
    } else {
      return true;
    }
  }

  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
    _timer = new Timer(const Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, Constants.ROUTE_HOME);
    });

  }
  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }

}
