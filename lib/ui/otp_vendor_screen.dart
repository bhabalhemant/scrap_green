import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/vendor_otp/otp_vendor_bloc.dart';
import 'package:scrapgreen/models/response/sign_up_vendor_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/count_down_timer.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVendorScreen extends StatefulWidget {
  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpVendorScreen> {
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController currController = new TextEditingController();
  SignUpVendorResponse _data;

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    currController.dispose();
  }

  @override
  void initState() {
    super.initState();
    currController = controller1;
    BlocProvider.of<OtpVendorBloc>(context).add(TimerStopEvent(flag: false));
  }

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;
    List<Widget> widgetList = [
      Padding(
        padding: EdgeInsets.only(left: 0.0, right: 2.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                border: new Border.all(
                    width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
                borderRadius: new BorderRadius.circular(4.0)),
            child: new TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              enabled: false,
              controller: controller1,
              autofocus: false,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: controller2,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            controller: controller3,
            textAlign: TextAlign.center,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            controller: controller4,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            controller: controller5,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            controller: controller6,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.0, right: 0.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),
    ];

    return new Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Enter OTP"),
        backgroundColor: AppSingleton.instance.getPrimaryColor(),
      ),
      backgroundColor: Color(0xFFeaeaea),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Verifying your number!",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 4.0, right: 16.0),
                    child: Text(
                      "Please type the verification code sent to",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 2.0, right: 30.0),
                    child: Text(
                      _data.data.mobile != null ? _data.data.mobile : '',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: AppSingleton.instance.getPrimaryColor()),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image(
                      image: AssetImage('assets/otp_icon.png'),
                      height: AppSingleton.instance.getHeight(100),
                      width: AppSingleton.instance.getWidth(100),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 30,
                    width: AppSingleton.instance.getWidth(140),
                    child: BlocConsumer(
                      bloc: BlocProvider.of<OtpVendorBloc>(context),
                      listener: (context, state) {
                        if (state is ResendOtpVendorError) {
                          _showError(state.msg);
                        }
                        if (state is ResendOtpVendorLoaded) {
                          _showSuccessMessage(state.response.msg);
                        }
                      },
                      builder: (context, state) {
                        if (state is TimerStopState) {
                          if (!state.flag) {
                            return CountDownTimer(
                              secondsRemaining: 10,
                              whenTimeExpires: () {
                                BlocProvider.of<OtpVendorBloc>(context)
                                    .add(TimerStopEvent(flag: true));
                              },
                              countDownTimerStyl: TextStyle(
                                  color:
                                      AppSingleton.instance.getPrimaryColor(),
                                  fontSize: AppSingleton.instance.getSp(14.0),
                                  height: 1.2),
                            );
                          }
                        }
                        if (state is ResendOtpVendorError) {
                          return buildResendButton();
                        }
                        if (state is ResendOtpVendorLoading) {
                          return AppSingleton.instance.buildCenterSizedProgressBar();
                        }
                        if (state is ResendOtpVendorLoaded) {
                          BlocProvider.of<OtpVendorBloc>(context)
                              .add(TimerStopEvent(flag: false));
                          return buildResendButton();
                        }
                        return buildResendButton();
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    child: BlocConsumer(
                      bloc: BlocProvider.of<OtpVendorBloc>(context),
                      listener: (context, state) {
                        if (state is OtpVendorVerificationError) {
                          _showError(state.msg);
                        }
                        if (state is OtpVendorVerificationLoaded) {
                          matchOtp();
                        }
                      },
                      builder: (context, state) {
                        if (state is OtpVendorVerificationError) {
                          return AppSingleton.instance.getBlankContainer();
                        }
                        if (state is OtpVendorVerificationLoaded) {
                          return AppSingleton.instance.getBlankContainer();
                        }
                        if (state is OtpVendorVerificationLoading) {
                          return AppSingleton.instance.buildCenterSizedProgressBar();
                        }
                        return AppSingleton.instance.getBlankContainer();
                      },
                    ),
                  ),
                ],
              ),
              flex: 90,
            ),
            Flexible(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GridView.count(
                        crossAxisCount: 8,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        children: List<Container>.generate(
                            8,
                            (int index) =>
                                Container(child: widgetList[index]))),
                  ]),
              flex: 20,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 16.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("1");
                            },
                            child: Text("1",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("2");
                            },
                            child: Text("2",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("3");
                            },
                            child: Text("3",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("4");
                            },
                            child: Text("4",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("5");
                            },
                            child: Text("5",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("6");
                            },
                            child: Text("6",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("7");
                            },
                            child: Text("7",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("8");
                            },
                            child: Text("8",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("9");
                            },
                            child: Text("9",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                              onPressed: () {
                                deleteText();
                              },
                              child: Image.asset('assets/delete.png',
                                  width: 25.0, height: 25.0)),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("0");
                            },
                            child: Text("0",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              scaffoldKey.currentState.hideCurrentSnackBar();
                              var otp = controller1.text +
                                  controller2.text +
                                  controller3.text +
                                  controller4.text +
                                  controller5.text +
                                  controller6.text;
                              Map<String, String> body = {
                                Constants.PARAM_OTP: otp,
                                Constants.PARAM_EMAIL_KEY: _data.data.emailKey,
                              };
                              BlocProvider.of<OtpVendorBloc>(context)
                                  .add(OtpVendorVerificationEvent(body: body));
                            },
                            child: Image.asset('assets/success.png',
                                width: 25.0, height: 25.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              flex: 90,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResendButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: AppSingleton.instance.getPrimaryColor(),
        ),
      ),
      onPressed: () {
        Map<String, String> body = {Constants.PARAM_MOBILE: _data.data.mobile};
        BlocProvider.of<OtpVendorBloc>(context).add(ResendOtpVendorEvent(body: body));
      },
      color: AppSingleton.instance.getPrimaryColor(),
      textColor: AppSingleton.instance.getDarkBlueColor(),
      child: Text(
        "RESEND OTP",
        style: AppTextStyle.regular(Colors.white, 12.0),
      ),
    );
  }
  
  void matchOtp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content:
                Text("Otp matched successfully. Please sign in to continue!"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        scaffoldKey.currentContext,
                        Constants.ROUTE_SIGN_IN_VENDOR,
                        (Route<dynamic> route) => false);
                  })
            ],
          );
        });

  }

  void inputTextToField(String str) {
    //Edit first textField
    if (currController == controller1) {
      controller1.text = str;
      currController = controller2;
    }

    //Edit second textField
    else if (currController == controller2) {
      controller2.text = str;
      currController = controller3;
    }

    //Edit third textField
    else if (currController == controller3) {
      controller3.text = str;
      currController = controller4;
    }

    //Edit fourth textField
    else if (currController == controller4) {
      controller4.text = str;
      currController = controller5;
    }

    //Edit fifth textField
    else if (currController == controller5) {
      controller5.text = str;
      currController = controller6;
    }

    //Edit sixth textField
    else if (currController == controller6) {
      controller6.text = str;
      currController = controller6;
    }
  }

  void deleteText() {
    if (currController.text.length == 0) {
    } else {
      currController.text = "";
      currController = controller5;
      return;
    }
    if (currController == controller1) {
      controller1.text = "";
    } else if (currController == controller2) {
      controller1.text = "";
      currController = controller1;
    } else if (currController == controller3) {
      controller2.text = "";
      currController = controller2;
    } else if (currController == controller4) {
      controller3.text = "";
      currController = controller3;
    } else if (currController == controller5) {
      controller4.text = "";
      currController = controller4;
    } else if (currController == controller6) {
      controller5.text = "";
      currController = controller5;
    }
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
