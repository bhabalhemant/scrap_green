import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/profile/profile_bloc.dart';
import 'package:scrapgreen/bloc/profile/profile_event.dart';
import 'package:scrapgreen/bloc/profile/profile_state.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/email_validator.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class MyContribution extends StatefulWidget {
  @override
  _MyContributionState createState() => _MyContributionState();
}

class _MyContributionState extends State<MyContribution> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'My Contribution'),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child:Card(
                    child: ListTile(
                      // leading: Icon(Icons.album),
                      title: Text('Congrats! You helped in saving our Environment',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child:Card(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        // leading: Icon(Icons.album),
                        leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text('Congrats!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: Text('00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child:Card(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        // leading: Icon(Icons.album),
                        leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text('Congrats!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: Text('00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child:Card(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        // leading: Icon(Icons.album),
                        leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text('Congrats!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: Text('00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child:Card(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        // leading: Icon(Icons.album),
                        leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text('Congrats!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: Text('00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child:Card(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        // leading: Icon(Icons.album),
                        leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text('Congrats!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: Text('00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child:Card(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        // leading: Icon(Icons.album),
                        leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text('Congrats!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: Text('00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child:Card(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        // leading: Icon(Icons.album),
                        leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text('Congrats!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        trailing: Text('00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child:Card(
                    child: ListTile(
                      // leading: Icon(Icons.album),
                      title: Text('Thanks! for supporting.. Go Green',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}