import 'package:scrap_green/base_widgets/app_textstyle.dart';
import 'package:scrap_green/bloc/profile/profile_bloc.dart';
import 'package:scrap_green/bloc/profile/profile_event.dart';
import 'package:scrap_green/bloc/profile/profile_state.dart';
import 'package:scrap_green/models/response/profile_response.dart';
import 'package:scrap_green/utils/constants.dart' as Constants;
import 'package:scrap_green/utils/email_validator.dart';
import 'package:scrap_green/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class RateCard extends StatefulWidget {
  @override
  _RateCardState createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Rate Card'),
          body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          // children: List.generate(4, (index) {
            // return Center(
              // child:Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 25, 2, 2),
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical:10, horizontal:10),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 120.0,
                            ),
                          ),
                        ),
                        Text('Copper-800/KG',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 25, 2, 2),
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical:10, horizontal:10),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 120.0,
                            ),
                          ),
                        ),
                        Text('Iron-800/KG',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical:2, horizontal:2),
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical:10, horizontal:10),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 120.0,
                            ),
                          ),
                        ),
                        Text('Plastic-80/KG',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical:2, horizontal:2),
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical:10, horizontal:10),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 120.0,
                            ),
                          ),
                        ),
                        Text('Paper-80/KG',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              // ),
            // );
          // }),
        ),
        ),
      ), 
    );
  }
}