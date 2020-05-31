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

class VendorRequest extends StatefulWidget {
  @override
  _VendorRequestState createState() => _VendorRequestState();
}

class _VendorRequestState extends State<VendorRequest> {
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'VendorRequest'),
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
                      padding: EdgeInsets.symmetric(vertical:5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            // leading: Icon(Icons.album),
                            leading: Image.asset('assets/recycle.png',
                              width: 62, height: 62, fit: BoxFit.contain),
                            title: Text('Order No: REC007'),
                            // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('19.05.2020 12:29PM',
                                  textAlign: TextAlign.left,
                                  // style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Ghatkopar-West,400084.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/criss-cross.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(2),
                                ),
                                Image.asset('assets/check.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                              ],
                            ),
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
                      padding: EdgeInsets.symmetric(vertical:5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            // leading: Icon(Icons.album),
                            leading: Image.asset('assets/recycle.png',
                              width: 62, height: 62, fit: BoxFit.contain),
                            title: Text('Order No: REC007'),
                            // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('19.05.2020 12:29PM',
                                  textAlign: TextAlign.left,
                                  // style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Ghatkopar-West,400084.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/criss-cross.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(2),
                                ),
                                Image.asset('assets/check.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                              ],
                            ),
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
                      padding: EdgeInsets.symmetric(vertical:5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            // leading: Icon(Icons.album),
                            leading: Image.asset('assets/recycle.png',
                              width: 62, height: 62, fit: BoxFit.contain),
                            title: Text('Order No: REC007'),
                            // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('19.05.2020 12:29PM',
                                  textAlign: TextAlign.left,
                                  // style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Ghatkopar-West,400084.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/criss-cross.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(2),
                                ),
                                Image.asset('assets/check.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                              ],
                            ),
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
                      padding: EdgeInsets.symmetric(vertical:5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            // leading: Icon(Icons.album),
                            leading: Image.asset('assets/recycle.png',
                              width: 62, height: 62, fit: BoxFit.contain),
                            title: Text('Order No: REC007'),
                            // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('19.05.2020 12:29PM',
                                  textAlign: TextAlign.left,
                                  // style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Ghatkopar-West,400084.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/criss-cross.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(2),
                                ),
                                Image.asset('assets/check.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                              ],
                            ),
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
                      padding: EdgeInsets.symmetric(vertical:5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            // leading: Icon(Icons.album),
                            leading: Image.asset('assets/recycle.png',
                              width: 62, height: 62, fit: BoxFit.contain),
                            title: Text('Order No: REC007'),
                            // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('19.05.2020 12:29PM',
                                  textAlign: TextAlign.left,
                                  // style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Ghatkopar-West,400084.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/criss-cross.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(2),
                                ),
                                Image.asset('assets/check.png',
                                width: 32, height: 32, fit: BoxFit.contain),
                              ],
                            ),
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