import 'package:flutter/cupertino.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import '../repository/repository.dart';
import 'package:flutter/rendering.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

  }

  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return AppSingleton.instance.goBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Settings'),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200.0,
              color: Colors.green,
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: AssetImage('assets/settings_background.jpg'),
//                      fit: BoxFit.cover,
//                    ),
//                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 75,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20.0),
                        height: 25.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                        ),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.0,
//                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'Hemant Bhabal',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          '+91 77382 42013',
                          style: TextStyle(
                            fontSize: 14.0,
                              color: Colors.white
//                          fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'hemant@apptroid.com',
                          style: TextStyle(
                            fontSize: 14.0,
                              color: Colors.white
//                          fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: Colors.green,
                      size: 25,
                    ),
                    title: Text('Edit Profile',

                      style: TextStyle(
                        fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Colors.green,
                      size: 25,
                    ),
                    title: Text('Change Password',

                      style: TextStyle(
                        fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.call,
                      color: Colors.green,
                      size: 25,
                    ),
                    title: Text('Contact Us',

                      style: TextStyle(
                        fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Colors.green,
                      size: 25,
                    ),
                    title: Text('Logout',

                      style: TextStyle(
                        fontSize: 16.0,
//                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                    onTap: () async {
                      var response = await Repository.instance.clearAllShardPrefs();
                      if (response) {
//                        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
//                            Constants.ROUTE_SIGN_IN, (Route<dynamic> route) => false);
                        Navigator.pushNamed(context, Constants.ROUTE_SIGN_IN);
                      } else {
                        _showError('Failed to log out');
                      }
                    },
                  ),
                ),
                Divider(),
              ],
            ),

          ),
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
