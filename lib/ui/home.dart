import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../repository/repository.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            // icon: new Image.asset('assets/img/scanner.png'),
            icon: Icon(Icons.menu),
            onPressed: drawer,
            color: Colors.lightGreen,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
            child: Image.asset(
              'assets/scrap_green_logo.png',
              height: 7.0,
              alignment: Alignment.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () async {
              var response = await Repository.instance.clearAllShardPrefs();
              if (response) {
                Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
                    Constants.ROUTE_SIGN_IN, (Route<dynamic> route) => false);
              } else {
                _showError('Failed to log out');
              }
            },
            color: Colors.lightGreen,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Constants.ROUTE_RATE_CARD);
                  },
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Check our latest rate card here',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Rate Card',
                        style: TextStyle(color: Colors.yellow),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52),
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
                          "SCHEDULE PICKUP",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Constants.ROUTE_HISTORY);
                            // print('object');
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
                          "CHECK HISTORY",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52),
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
                          "MY CONTRIBUTION",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Constants.ROUTE_VENDOR_REQUEST);
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
                          "ASK FOR HELP",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void drawer() {}

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
