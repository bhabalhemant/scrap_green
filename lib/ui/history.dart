import 'package:dana/base_widgets/app_textstyle.dart';
import 'package:dana/bloc/profile/profile_bloc.dart';
import 'package:dana/bloc/profile/profile_event.dart';
import 'package:dana/bloc/profile/profile_state.dart';
import 'package:dana/models/response/profile_response.dart';
import 'package:dana/utils/constants.dart' as Constants;
import 'package:dana/utils/email_validator.dart';
import 'package:dana/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'History'),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    height: AppSingleton.instance.getHeight(50),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: AppTextStyle.regular(Colors.black38, 15.0),
                          hintText: "Search",
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:11.0),
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          // leading: Icon(Icons.album),
                          leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                          title: Text('Order No: REC007'),
                          subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                          isThreeLine: true,
                          trailing: Wrap(         
                            children: <Widget>[
                            // Icon(Icons.flight),
                            Text('Rs. 2500.00'),
                            FlatButton(
                              child: Text(
                                'scheduled',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 8
                                ),
                              ),
                              onPressed: null,
                            ),
                            // Icon(Icons.flight_land)
                          ]),
                        ),
                      ],
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:11.0),
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          // leading: Icon(Icons.album),
                          leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                          title: Text('Order No: REC007'),
                          subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                          isThreeLine: true,
                          trailing: Column(  
                            mainAxisSize: MainAxisSize.max,        
                            children: <Widget>[
                            // Icon(Icons.flight),
                            Text('Rs. 2500.00'),
                            FlatButton(
                              child: Text(
                                'scheduled',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 8
                                ),
                              ),
                              onPressed: null,
                            ),
                            // Icon(Icons.flight_land)
                          ]),
                        ),
                      ],
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:11.0),
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          // leading: Icon(Icons.album),
                          leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                          title: Text('Order No: REC007'),
                          subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                          isThreeLine: true,
                          trailing: Column(  
                            mainAxisSize: MainAxisSize.max,        
                            children: <Widget>[
                            // Icon(Icons.flight),
                            Text('Rs. 2500.00'),
                            FlatButton(
                              child: Text(
                                'scheduled',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 8
                                ),
                              ),
                              onPressed: null,
                            ),
                            // Icon(Icons.flight_land)
                          ]),
                        ),
                      ],
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:11.0),
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          // leading: Icon(Icons.album),
                          leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                          title: Text('Order No: REC007'),
                          subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                          isThreeLine: true,
                          trailing: Column(  
                            mainAxisSize: MainAxisSize.max,        
                            children: <Widget>[
                            // Icon(Icons.flight),
                            Text('Rs. 2500.00'),
                            FlatButton(
                              child: Text(
                                'scheduled',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 8
                                ),
                              ),
                              onPressed: null,
                            ),
                            // Icon(Icons.flight_land)
                          ]),
                        ),
                      ],
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:11.0),
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          // leading: Icon(Icons.album),
                          leading: Image.asset('assets/pick.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                          title: Text('Order No: REC007'),
                          subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                          isThreeLine: true,
                          trailing: Column(  
                            mainAxisSize: MainAxisSize.max,        
                            children: <Widget>[
                            // Icon(Icons.flight),
                            Text('Rs. 2500.00'),
                            FlatButton(
                              child: Text(
                                'scheduled',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 8
                                ),
                              ),
                              onPressed: null,
                            ),
                            // Icon(Icons.flight_land)
                          ]),
                        ),
                      ],
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