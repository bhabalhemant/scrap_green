import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/singleton.dart';
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
          body: buildVendorScreen(),
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
//                LocaleKeys.ask_help,
                    'LOGOUT',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                  onTap: () async {
                    var response = await Repository.instance.clearAllShardPrefs();
                    print(response);
                    if (response) {
                      Navigator.pushNamed(context, Constants.ROUTE_SIGN_IN_VENDOR);
//                      Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext,
//                          Constants.ROUTE_SIGN_IN_VENDOR, (Route<dynamic> route) => false);
                    } else {
                      _showError('Failed to log out');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }
  Widget buildVendorScreen() {
    return SingleChildScrollView(
//      height: MediaQuery.of(context).size.height,
//      width: MediaQuery.of(context).size.width,
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.album),
                      leading: Image.asset('assets/recycle.png',
                          width: 62, height: 62, fit: BoxFit.contain),
                      title: Text('Order No: REC007',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('19.05.2020 12:29PM',
//                            textAlign: TextAlign.left,
                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
                               fontSize: 10.0
                             ),
                          ),
                          Text('Ghatkopar-West,400084.',
//                            textAlign: TextAlign.le,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0
                            ),
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
                              width: 30, height: 30, fit: BoxFit.contain),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.album),
                      leading: Image.asset('assets/recycle.png',
                          width: 62, height: 62, fit: BoxFit.contain),
                      title: Text('Order No: REC007',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('19.05.2020 12:29PM',
//                            textAlign: TextAlign.left,
                            style: TextStyle(
//                                 fontWeight: FontWeight.bold,
                                fontSize: 10.0
                            ),
                          ),
                          Text('Ghatkopar-West,400084.',
//                            textAlign: TextAlign.le,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0
                            ),
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
                              width: 30, height: 30, fit: BoxFit.contain),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.album),
                      leading: Image.asset('assets/recycle.png',
                          width: 62, height: 62, fit: BoxFit.contain),
                      title: Text('Order No: REC007',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('19.05.2020 12:29PM',
//                            textAlign: TextAlign.left,
                            style: TextStyle(
//                                 fontWeight: FontWeight.bold,
                                fontSize: 10.0
                            ),
                          ),
                          Text('Ghatkopar-West,400084.',
//                            textAlign: TextAlign.le,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0
                            ),
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
                              width: 30, height: 30, fit: BoxFit.contain),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.album),
                      leading: Image.asset('assets/recycle.png',
                          width: 62, height: 62, fit: BoxFit.contain),
                      title: Text('Order No: REC007',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('19.05.2020 12:29PM',
//                            textAlign: TextAlign.left,
                            style: TextStyle(
//                                 fontWeight: FontWeight.bold,
                                fontSize: 10.0
                            ),
                          ),
                          Text('Ghatkopar-West,400084.',
//                            textAlign: TextAlign.le,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0
                            ),
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
                              width: 30, height: 30, fit: BoxFit.contain),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.album),
                      leading: Image.asset('assets/recycle.png',
                          width: 62, height: 62, fit: BoxFit.contain),
                      title: Text('Order No: REC007',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('19.05.2020 12:29PM',
//                            textAlign: TextAlign.left,
                            style: TextStyle(
//                                 fontWeight: FontWeight.bold,
                                fontSize: 10.0
                            ),
                          ),
                          Text('Ghatkopar-West,400084.',
//                            textAlign: TextAlign.le,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0
                            ),
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
                              width: 30, height: 30, fit: BoxFit.contain),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.album),
                      leading: Image.asset('assets/recycle.png',
                          width: 62, height: 62, fit: BoxFit.contain),
                      title: Text('Order No: REC007',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('19.05.2020 12:29PM',
//                            textAlign: TextAlign.left,
                            style: TextStyle(
//                                 fontWeight: FontWeight.bold,
                                fontSize: 10.0
                            ),
                          ),
                          Text('Ghatkopar-West,400084.',
//                            textAlign: TextAlign.le,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0
                            ),
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
                              width: 30, height: 30, fit: BoxFit.contain),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.album),
                      leading: Image.asset('assets/recycle.png',
                          width: 62, height: 62, fit: BoxFit.contain),
                      title: Text('Order No: REC007',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: Text('19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('19.05.2020 12:29PM',
//                            textAlign: TextAlign.left,
                            style: TextStyle(
//                                 fontWeight: FontWeight.bold,
                                fontSize: 10.0
                            ),
                          ),
                          Text('Ghatkopar-West,400084.',
//                            textAlign: TextAlign.le,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0
                            ),
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
                              width: 30, height: 30, fit: BoxFit.contain),
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
    );
  }
  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}