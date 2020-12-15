import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/request_details/request_details_bloc.dart';
import 'package:scrapgreen/bloc/request_details/request_details_event.dart';
import 'package:scrapgreen/bloc/request_details/request_details_state.dart';
import 'package:scrapgreen/models/addItem.dart';
import 'package:scrapgreen/models/response/request_details_response.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/dialogBox.dart';
import 'package:scrapgreen/utils/singleton.dart';

class RequestDetails extends StatefulWidget {
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  String _v_id;
  String _id;
  String _vendorId;
  String _user_id;
  String _name;
  String _mobile;
  String _address_line1;
  String _address_line2;
  String _country;
  String _state;
  String _city;
  String _pin_code;
  String _latitude_longitude;
  String _schedule_date_time;
  String _request_status;
  String _vendor_id;
  String _pickup_date_time;
  String _admin_status;
  String _warehouse_id;
  String _payment_status;
  String _payment_mode;
  String _payment_txn_id;
  String _total_amount;
  String _created_on;
  String _created_by;
  String _last_modified_by;
  String _last_modified_on;
  String amount;
  List<Data1> _data1 = List();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _loadingKey = GlobalKey<State>();
  final List<AddItem> itemList = [];
  Timer _timer;

  @override
  void initState() {
    super.initState();
    amountCalculation();
    BlocProvider.of<RequestDetailsBloc>(context).add(GetVendorProfile());
    BlocProvider.of<RequestDetailsBloc>(context).add(GetRequestDetailsEvent());
  }

  @override
  onTap() {
    Navigator.pushNamed(context, Constants.ROUTE_VENDOR_REQUEST);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return AppSingleton.instance.goBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Request Details'),
//          body: buildRequestScreen(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: BlocConsumer(
                    bloc: BlocProvider.of<RequestDetailsBloc>(context),
                    listener: (context, state) {
                      if (state is RequestDetailsLoaded) {
                        _setData(state.response);
                        _data1.addAll(state.response.data1);
                      }
                      if (state is RequestDetailsUpdated) {
                        _showSuccessMessage(state.response.msg);
                        BlocProvider.of<RequestDetailsBloc>(context)
                            .add(GetRequestDetailsEvent());
                      }
                      if (state is RequestDetailsError) {
                        _showError(state.msg);
                      }
                      if (state is RequestDetailsComplete) {
//                        print(state.response.msg);
                        _showCompleteMessage(state.response.msg);
//
                      }
                      if (state is RequestDetailsItemRemoved) {
                        _showSuccessMessage(state.response.msg);
                        Navigator.pushNamed(
                            context, Constants.ROUTE_REQUEST_DETAILS);
//                        _showSuccessMessage(state.response.msg);
                      }
                      if (state is VendorProfileeLoaded) {
                        _setData1(state.response);
//                        _data1.addAll(state.response.data);
                      }
                    },
                    builder: (context, state) {
                      if (state is RequestDetailsLoaded) {
                        return buildRequestScreen();
                      } else if (state is RequestDetailsLoading) {
                        return Center(
                          child: AppSingleton.instance
                              .buildCenterSizedProgressBar(),
                        );
                      } else if (state is RequestDetailsError) {
                        return Center(
                          child: Text(
                            'Failed to get user data error',
                            style: AppTextStyle.bold(Colors.red, 30.0),
                          ),
                        );
                      } else if (state is RequestDetailsEmpty) {
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

  Widget buildRequestScreen() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                          child: Text(
                            'Order No.: ${_id}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                          child: Text(
                            '${_schedule_date_time}',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                          child: Text(
                            '${_address_line1} ${_address_line2}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                          child: Text(
                            '${_city} ${_pin_code}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        amount != null
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                child: Text(
                                  'Total: Rs. ${amount}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                child: Text(
                                  'Total: Rs. 0.00',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Payment : ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black
                              ),
                            ),
                            _payment_status == 'pending'
                            ?
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                              ),
                              child: Text(
                                'Pending',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            _payment_status == 'processing '
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.orange,
                              ),
                              child: Text(
                                'Processing',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            _payment_status == 'processed'
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.green,
                              ),
                              child: Text(
                                'Processed',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            _payment_status == 'cancelled'
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                              ),
                              child: Text(
                                'Cancelled',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            _payment_status == 'rejected'
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                              ),
                              child: Text(
                                'Rejected',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            _payment_status == 'processing'
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.orange,
                              ),
                              child: Text(
                                'Processing',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            _payment_status == 'processed'
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.green,
                              ),
                              child: Text(
                                'Processed',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            _payment_status == 'cancelled'
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                              ),
                              child: Text(
                                'Cancelled',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            _payment_status == 'rejected'
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                              ),
                              child: Text(
                                'Rejected',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ):
                            Container(),
                          ],
                        ),
//                        Container(),

                      ],
                    ),
                    isThreeLine: true,
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _request_status == '0'
                            ?
                        InkWell(
                          onTap: () {
//                                print('yes');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogBox(
                                    requestDetailsId: _id,
                                    vendorId: _vendorId,
                                  );
                                });
                          },
                          child: Image.asset('assets/add-button.png',
                              width: 25, height: 25, fit: BoxFit.contain),
                        )
                            : SizedBox(
                              height: AppSingleton.instance.getHeight(10),
                            ),
                        SizedBox(
                          height: AppSingleton.instance.getHeight(10),
                        ),
                        _request_status == '0'
                            ?
                         Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                          height: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.blue,
                          ),
                          child: Text(
                            'In Progress',
//                                textScaleFactor: 2,
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.0),
                          ),
                        ):
                        _request_status == '1'
                            ? Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                          height: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.orange,
                          ),
                          child: Text(
                            'Assigned',
//                                textScaleFactor: 2,
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.0),
                          ),
                        ):
                        _request_status == '2'
                            ? Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                          height: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.redAccent,
                          ),
                          child: Text(
                            'User Cancelled',
//                                textScaleFactor: 2,
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.0),
                          ),
                        ):
                        _request_status == '3'
                            ? Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                          height: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.red,
                          ),
                          child: Text(
                            'Admin Cancelled',
//                                textScaleFactor: 2,
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.0),
                          ),
                        ):
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                          height: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.green,
                          ),
                          child: Text(
                            'Complete',
//                                textScaleFactor: 2,
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.0),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
//                Text('-------------------------------------------',
//                  style: TextStyle(
//                    fontSize: 28.0,
//                    color: Colors.grey
//                  ),
//                ),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              'ITEMS FOR PICKUP',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(),
          buildItemsList(),
          _request_status == '0'
          ?
          _data1.length > 0
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // onPressed: loginCheck,
                    onPressed: () {
                      Widget cancelButton = FlatButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      );
                      Widget continueButton = FlatButton(
                        child: Text("Save"),
                        onPressed: () async {
                          Map<String, String> body = {
                            Constants.PARAM_REQUEST_ID: _id,
//                  Constants.PARAM_VENDOR_ID: _v_id,
                            Constants.PARAM_AMOUNT: amount,
                          };
                          BlocProvider.of<RequestDetailsBloc>(context)
                              .add(CompleteRequestDetails(body: body));
                        },
                      ); // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        content: Text("Do you want to save request?"),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      ); // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.green,
                    child: Text(
                      'Complete',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container()
          : SizedBox(
              height: AppSingleton.instance.getHeight(10),
            ),
        ],
      ),
    );
  }

  void amountCalculation() {
    _data1.map((item) {
//      setState(() {
        print(item.id);
//      });
    }).toList();
  }

  Widget buildItemsList() {
    return _data1.length > 0
        ? ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _data1.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Card(
                  color: Colors.blueGrey[50],
                  elevation: 2,
                  child: ListTile(
                    leading: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('assets/recycle.png',
                            width: 28, height: 28),
                        SizedBox(
                          width: AppSingleton.instance.getHeight(10.0),
                        ),
                        Text(
                          _data1[index].unit_qty + _data1[index].unit,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    title: Text(
                      _data1[index].material_id,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    subtitle: Text(
                      'Rs. ' + _data1[index].rate + '/' + _data1[index].unit,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Rs. ' + _data1[index].amount + '.00',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                         SizedBox(
                          width: AppSingleton.instance.getWidth(10),
                        ),
                    _request_status == '0'
                        ? InkWell(
                          onTap: () {
                            String id = _data1[index].id;
                            showAlertDialog(id);
                          },
                          child: Image.asset('assets/criss-cross.png',
                              width: 25, height: 25, fit: BoxFit.contain),
                        ):
                        Container(),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            child: Text(
            'no items picked up.',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ));
  }

  showAlertDialog(id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = FlatButton(
      child: Text("Remove"),
      onPressed: () async {
        Map<String, String> body = {
          Constants.PARAM_ITEM_ID: id,
        };
        BlocProvider.of<RequestDetailsBloc>(context)
            .add(RemoveItemRequestDetails(body: body));
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Do you want to remove item from list?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  successAlert() {
    // DialogBox.showLoadingDialog(context, _loadingKey);
    // return DialogBox();
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          requestDetailsId: _id,
          vendorId: _vendorId,
        );
      },
    );
  }

  void _setData(RequestDetailsResponse response) {
    _id = response.data.id;
    _user_id = response.data.user_id;
    _name = response.data.name;
    _mobile = response.data.mobile;
    _address_line1 = response.data.address_line1;
    _address_line2 = response.data.address_line2;
    _country = response.data.country;
    _state = response.data.state;
    _city = response.data.city;
    _pin_code = response.data.pin_code;
    _latitude_longitude = response.data.latitude_longitude;
    _schedule_date_time = response.data.schedule_date_time;
    _request_status = response.data.request_status;
    _vendor_id = response.data.vendor_id;
    _pickup_date_time = response.data.pickup_date_time;
    _admin_status = response.data.admin_status;
    _warehouse_id = response.data.warehouse_id;
    _payment_status = response.data.payment_status;
    _payment_mode = response.data.payment_mode;
    _payment_txn_id = response.data.payment_txn_id;
    _total_amount = response.data.total_amount;
    _created_on = response.data.created_on;
    _last_modified_by = response.data.last_modified_by;
    _last_modified_on = response.data.last_modified_on;
    amount = response.data.amount;
  }

  void _setData1(VendorProfileResponse response) {
    _v_id = response.data.id;
    _vendorId = response.data.id;
  }

  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
  }

  void _showCompleteMessage(String message) {
    print(message);
//    scaffoldKey.currentState.hideCurrentSnackBar();
//    scaffoldKey.currentState
//        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
//    _timer = new Timer(const Duration(milliseconds: 1000), () {
//      Navigator.pushNamed(context, Constants.ROUTE_VENDOR_REQUEST);
//    });
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
