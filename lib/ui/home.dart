import 'package:scrapgreen/ui/drawer_v1.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/bloc/profile_page/profile_bloc.dart';
import 'package:scrapgreen/bloc/profile_page/profile_event.dart';
import 'package:scrapgreen/bloc/profile_page/profile_state.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/bloc/bank_details/bank_bloc.dart';
import 'package:scrapgreen/bloc/bank_details/bank_event.dart';
import 'package:scrapgreen/bloc/bank_details/bank_state.dart';
import 'package:scrapgreen/models/response/bank_details_response.dart';
import '../repository/repository.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/ui/addBankDetails.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(20);
  String _id;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfilePageBloc>(context).add(GetProfile());
    BlocProvider.of<BankBloc>(context).add(GetBank());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.green, //change your color here
        ),
        title: Image.asset(
            'assets/scrap_green_logo.png',
            height: 37.0,
//            alignment: Alignment.center,
          ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () async {
              Navigator.pushNamed(context, Constants.ROUTE_SETTING);
            },
            color: Colors.lightGreen,
          ),
        ],
        backgroundColor: Colors.white,
      ),
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
                  if (state is ProfileError) {
                    _showError(state.msg);
                  }
                },
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return buildHomeScreen();
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
//                profileScreen(),
          ],
        ),
      ),
//      body:
      drawer: DrawerV1(),
    );
  }

  Widget buildHomeScreen() {
    return SingleChildScrollView(
//        height: MediaQuery.of(context).size.height,
//        width: MediaQuery.of(context).size.width,
      child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Constants.ROUTE_RATE_CARD);
                },
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      // 'Check our latest rate card here',
                      LocaleKeys.check_rate_card,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.left,
                    ).tr(),
                    Text(
                      // 'Rate Card',
                      LocaleKeys.rate_card,
                      style: TextStyle(color: Colors.yellow, fontSize: 12 ),
                      textAlign: TextAlign.right,
                    ).tr(),
                  ],
                ),
              ),
            ),
          ),

//          Container(
//            width: MediaQuery.of(context).size.width,
//            child: Padding(
//              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(24),
//                ),
//                onPressed: () {
//                  Navigator.pushNamed(context, Constants.ROUTE_ADD_BANK_DETAILS, arguments: {"userId":_id});
//                },
//                color: Colors.orange,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    Text(
//                      // 'Check our latest rate card here',
//                      'Please add your payment method, ',
////                        LocaleKeys.check_rate_card,
//                      style: TextStyle(color: Colors.white, fontSize: 11.5),
//                      textAlign: TextAlign.left,
//                    ),
//                    Text(
//                      // 'Rate Card',
//                      'Click Here',
////                        LocaleKeys.rate_card,
//                      style: TextStyle(color: Colors.yellow, fontSize: 11),
//                      textAlign: TextAlign.right,
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//
//          Container(
//            width: MediaQuery.of(context).size.width,
//            child: Padding(
//              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(24),
//                ),
//                onPressed: () {
//                  Navigator.pushNamed(context, Constants.ROUTE_ADD_BANK_DETAILS, arguments: {"userId":_id});
//                },
//                color: Colors.orange,
//                child: Text(
//                      // 'Check our latest rate card here',
//                      'Your payment account is pending for approval',
////                        LocaleKeys.check_rate_card,
//                      style: TextStyle(color: Colors.white, fontSize: 11),
//                      textAlign: TextAlign.left,
//                    ),
//              ),
//            ),
//          ),
          BankDetailsError(),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Constants.ROUTE_PROFILE);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Image.asset('assets/pick.png',
                                  width: 82, height: 82, fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                          child: Text(
                            // "SCHEDULE PICKUP",
                            LocaleKeys.schedule_pick_up,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ).tr(),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Constants.ROUTE_HISTORY);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Image.asset('assets/history.png',
                                  width: 82, height: 82, fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                          child: Text(
                            // "SCHEDULE PICKUP",
                            LocaleKeys.check_history,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ).tr(),
                        ),
                      ],
                    ),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Constants.ROUTE_MY_CONTRIBUTION);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Image.asset('assets/contribution.png',
                                  width: 82, height: 82, fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                          child: Text(
                            // "SCHEDULE PICKUP",
                            LocaleKeys.my_contribution,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ).tr(),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Constants.ROUTE_CONTACT_US);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Image.asset('assets/help.png',
                                  width: 82, height: 82, fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                          child: Text(
                            // "SCHEDULE PICKUP",
                            LocaleKeys.ask_help,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ).tr(),
                        ),
                      ],
                    ),


                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BankDetailsError() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Constants.ROUTE_ADD_BANK_DETAILS, arguments: {"userId":_id});
          },
          color: Colors.orange,
          child: Text(
            // 'Check our latest rate card here',
            'Your payment account is pending for approval',
//                        LocaleKeys.check_rate_card,
            style: TextStyle(color: Colors.white, fontSize: 11),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }

  Widget BankDetailsLoaded(response) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: Column(
            children: <Widget>[
              response == '0'
              ? RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Constants.ROUTE_ADD_BANK_DETAILS, arguments: {"userId":_id});
                },
                color: Colors.orange,
                child: Text(
                  // 'Check our latest rate card here',
                  'Your payment account is pending for approval',
//                        LocaleKeys.check_rate_card,
                  style: TextStyle(color: Colors.white, fontSize: 11),
                  textAlign: TextAlign.left,
                ),
              ):
                  Container(),
            ],
          ),
      ),
    );
  }

  Widget CheckBankDetails() {
      return Container(
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

                },
                builder: (context, state) {
                  print(state);
                  if (state is BankLoaded) {
                    return BankDetailsLoaded(state.response);
                  } else if (state is BankLoading) {
                    return Center(
                      child: AppSingleton.instance.buildCenterSizedProgressBar(),
                    );
                  } else if (state is BankError) {
                    return BankDetailsError();
                  } else if (state is BankUploading) {
                    return AppSingleton.instance.buildCenterSizedProgressBar();
                  } else if (state is BankEmpty) {
                    return Center(
                      child: Text(
                        'Failed to get user data bank empty',
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
      );
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }

  void _setData(ProfileResponse response) {
    _id = response.data.id;
  }


}
