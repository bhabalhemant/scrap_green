import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/bank_details/bank_bloc.dart';
import 'package:scrapgreen/bloc/bank_details/bank_event.dart';
import 'package:scrapgreen/bloc/bank_details/bank_state.dart';
import 'package:scrapgreen/models/response/bank_details_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/email_validator.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:async';


class AddBankDetails extends StatefulWidget {
  @override
  _AddBankDetailsState createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String _id;
  TextEditingController
      _bank_name,
      _ac_no,
      _ifsc_code,
      _acc_type;
  Timer _timer;

  void dispose() {
    _bank_name.dispose();
    _ac_no.dispose();
    _ifsc_code.dispose();
    _acc_type.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bank_name = TextEditingController();
    _ac_no = TextEditingController();
    _ifsc_code = TextEditingController();
    _acc_type = TextEditingController();
    BlocProvider.of<BankBloc>(context).add(GetBank());
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
    final Map<String, Object> passedData = ModalRoute.of(context).settings.arguments;
    _id = passedData['userId'];
    return WillPopScope(
      onWillPop: () {
        return AppSingleton.instance.goBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Add Bank details'),
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
                    bloc: BlocProvider.of<BankBloc>(context),
                    listener: (context, state) {
//                      print(state);
                      if (state is BankLoaded) {
                        _setData(state.response);
                      }
                      if (state is BankUpdated) {
//                        _showSuccessMessage(state.response.msg);
//                        BlocProvider.of<BankBloc>(context).add(GetBank());
                        _showUpdatedMessage(state.response.msg);
                      }
                      if (state is BankError) {
                        _showError(state.msg);
                      }
                    },
                    builder: (context, state) {
                      print(state);
                      if (state is BankLoaded) {
                        return buildBankDetailsUpdateScreen();
                      } else if (state is BankLoading) {
                        return Center(
                          child: AppSingleton.instance.buildCenterSizedProgressBar(),
                        );
                      } else if (state is BankError) {
                          return buildBankDetailsAddScreen();
                      }  else if (state is BankEmpty) {
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
//        body: buildBankDetailsScreen(),
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

  Widget buildBankDetailsAddScreen() {
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
                    'Bank Name',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),

              getFormField(
                ctr: _bank_name,
                hint: 'Bank Name',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Account Number',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _ac_no,
                hint: 'Account Number',
                type: TextInputType.number,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'IFSC Code',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _ifsc_code,
                hint: 'IFSC Code',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Account Type',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _acc_type,
                hint: 'Account Type',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              buildAddButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget buildBankDetailsUpdateScreen() {
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
                    'Bank Name',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),

              getFormField(
                ctr: _bank_name,
                hint: 'Bank Name',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Account Number',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _ac_no,
                hint: 'Account Number',
                type: TextInputType.number,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'IFSC Code',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _ifsc_code,
                hint: 'IFSC Code',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                  child: Text(
                    'Account Type',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600]
                    ),
                  ),
                ),
              ),
              getFormField(
                ctr: _acc_type,
                hint: 'Account Type',
                type: TextInputType.text,
              ),
              AppSingleton.instance.getSpacer(),
              buildUpdateButton(),
            ],
          ),
        )
      ],
    );
  }


  Widget buildAddButton() {
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
              Constants.PARAM_USER_ID: _id,
              Constants.PARAM_BANK: _bank_name.text,
              Constants.PARAM_ACC_NO: _ac_no.text,
              Constants.PARAM_IFSC_CODE: _ifsc_code.text,
              Constants.PARAM_ACC_TYPE: _acc_type.text,
            };
            BlocProvider.of<BankBloc>(context)
                .add(AddBank(body: body));
          }
        },
        // color: AppSingleton.instance.getPrimaryColor(),
        color: Colors.green,
        textColor: Colors.white,
        child: Text(
          "Add Bank Details",
          style: AppTextStyle.regular(Colors.white, 14.0),
        ),
      ),
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
              color: Colors.green
          ),
        ),
        onPressed: () {
          if (validate()) {
          scaffoldKey.currentState.hideCurrentSnackBar();
          Map<String, String> body = {
            Constants.PARAM_USER_ID: _id,
            Constants.PARAM_BANK: _bank_name.text,
            Constants.PARAM_ACC_NO: _ac_no.text,
            Constants.PARAM_IFSC_CODE: _ifsc_code.text,
            Constants.PARAM_ACC_TYPE: _acc_type.text,
          };
//          print(body);
            BlocProvider.of<BankBloc>(context)
                .add(UpdateBank(body: body));
          }
        },
        // color: AppSingleton.instance.getPrimaryColor(),
        color: Colors.green,
        textColor: Colors.white,
        child: Text(
          "Update Bank Details",
          style: AppTextStyle.regular(Colors.white, 14.0),
        ),
      ),
    );
  }

  bool validate() {
    if (_bank_name.text.isEmpty) {
      _showError('Please enter your Bank Name');
      return false;
    } else if (_ac_no.text.isEmpty) {
      _showError('Please enter your Account Number');
      return false;
    } else if (_ifsc_code.text.isEmpty) {
      _showError('Please enter Bank IFSC Code');
      return false;
    } else if (_acc_type.text.isEmpty) {
      _showError('Please enter your Account type');
      return false;
    } else {
      return true;
    }
  }

  void _setData(BankDetailsResponse response) {
    _bank_name.text = response.data.bank;
    _ac_no.text = response.data.acc_no;
    _ifsc_code.text = response.data.ifsc;
    _acc_type.text = response.data.acc_type;
  }

  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
    _timer = new Timer(const Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, Constants.ROUTE_PROFILE_PAGE);
    });

  }

  void _showUpdatedMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
    _timer = new Timer(const Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, Constants.ROUTE_SETTING);
    });

  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
