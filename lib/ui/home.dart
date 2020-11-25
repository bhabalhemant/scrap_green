import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../repository/repository.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(20);
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
//          IconButton(
//            // icon: new Image.asset('assets/img/scanner.png'),
//            icon: Icon(Icons.menu),
//            onPressed: drawer,
//            color: Colors.lightGreen,
//          ),

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
      body: Center(
        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                        style: TextStyle(color: Colors.white, fontSize: 13),
                        textAlign: TextAlign.left,
                      ).tr(),
                      Text(
                        // 'Rate Card',
                        LocaleKeys.rate_card,
                        style: TextStyle(color: Colors.yellow, fontSize: 13),
                        textAlign: TextAlign.right,
                      ).tr(),
                    ],
                  ),
                ),
              ),
            ),
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
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 75,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 0, 8),
                    child: Text('Hemant Bhabal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Image.asset('assets/pick.png',
                  width: 30, height: 30, fit: BoxFit.contain
              ),

              title: Text(
                LocaleKeys.schedule_pick_up,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              onTap: () {
                Navigator.pushNamed(
                    context, Constants.ROUTE_PROFILE);
              },
            ),
            ListTile(
              leading: Image.asset('assets/history.png',
                  width: 30, height: 30, fit: BoxFit.contain
              ),
              title: Text(
                // "SCHEDULE PICKUP",
                LocaleKeys.check_history,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              onTap: () {
                Navigator.pushNamed(
                    context, Constants.ROUTE_HISTORY);
              },
            ),
            ListTile(
              leading: Image.asset('assets/contribution.png',
                  width: 30, height: 30, fit: BoxFit.contain
              ),
              title: Text(
                // "SCHEDULE PICKUP",
                LocaleKeys.my_contribution,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(
                    context, Constants.ROUTE_MY_CONTRIBUTION);
              },
            ),
            ListTile(
              leading: Image.asset('assets/help.png',
                  width: 30, height: 30, fit: BoxFit.contain
              ),
              title: Text(
                // "SCHEDULE PICKUP",
                LocaleKeys.ask_help,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              onTap: () {
//                Navigator.pushNamed(
//                    context, Constants.ROUTE_);
              },
            ),
            ListTile(
//              leading: Icon(Icons.lock),
            leading: Container(
              width: 30,
              height: 30,
//              color: Colors.green,
              decoration:
              BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(20),
              ),
              child:Icon(Icons.settings, color: Colors.green,),
            ),
              title: Text(
              'SETTINGS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              onTap: () async {

                  Navigator.pushNamed(
                      context, Constants.ROUTE_SETTING);
              },
            ),
            ListTile(
//              leading: Icon(Icons.lock),
              leading: Container(
                width: 30,
                height: 30,
//              color: Colors.green,
                decoration:
                BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(20),
                ),
                child:Icon(Icons.lock, color: Colors.green,),
              ),
              title: Text(
                // "SCHEDULE PICKUP",
//                LocaleKeys.ask_help,
                'LOGOUT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              onTap: () async {
                var response = await Repository.instance.clearAllShardPrefs();
                if (response) {
                  Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
                      Constants.ROUTE_SIGN_IN, (Route<dynamic> route) => false);
                } else {
                  _showError('Failed to log out');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
