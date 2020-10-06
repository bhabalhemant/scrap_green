import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_bloc.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_event.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_state.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
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
  String _id,
      _name,
      _email,
      _mobile,
      _address_line1,
      _address_line2,
      _country,
      _state,
      _city,
      _pin_code,
      _logo,
      _logo_original;
  String logo_path = 'https://apptroidtechnology.in/scrap_green/uploads/images/aaab7f8d09e7350e13201682ba2e4030.jpg';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VendorProfileBloc>(context).add(GetProfile());
  }

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
//                  Navigator.pushNamed(context, Constants.ROUTE_SETTING);
                },
                color: Colors.lightGreen,
              ),
            ],
            backgroundColor: Colors.white,
          ),
//          body: buildVendorScreen(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: BlocConsumer(
                    bloc: BlocProvider.of<VendorProfileBloc>(context),
                    listener: (context, state) {
//                      print('qwertyuiop${state}');
                      if (state is VendorProfileLoaded) {
                        _setData(state.response);
                      }
//                      if (state is VendorProfileUpdated) {
//                        _showSuccessMessage(state.response.msg);
//                        BlocProvider.of<ProfilePageBloc>(context).add(GetProfile());
//                      }
                      if (state is VendorProfileError) {
                        _showError(state.msg);
                      }
                    },
                    builder: (context, state) {
                      if (state is VendorProfileLoaded) {
                        return buildVendorScreen();
                      } else if (state is VendorProfileLoading) {
                        return Center(
                          child: AppSingleton.instance.buildCenterSizedProgressBar(),
                        );
                      } else if (state is VendorProfileError) {
                        return Center(
                          child: Text(
                            'Failed to get user data error',
                            style: AppTextStyle.bold(Colors.red, 30.0),
                          ),
                        );
                      } else if (state is VendorProfileUploading) {
                        return AppSingleton.instance.buildCenterSizedProgressBar();
                      } else if (state is VendorProfileEmpty) {
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

//                        child: Image.network(logo_path ,fit: BoxFit.cover,),
//                        child: CircleAvatar(
//                          radius: 50.0,
//                          backgroundImage:
//                          NetworkImage('https://apptroidtechnology.in/scrap_green/uploads/images/aaab7f8d09e7350e13201682ba2e4030.jpg'),
//                          backgroundColor: Colors.transparent,
//                        )
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                          '+91 7738242013',
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
                          'bhabalhemant@gmail.com',
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
//                    print(response);
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
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('19.05.2020 12:29PM',
                            style: TextStyle(
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

  void _setData(VendorProfileResponse response) {
    _id = response.data.id;
    _name = response.data.name;
    _email = response.data.email;
    _mobile = response.data.mobile;
    _address_line1 = response.data.address_line1;
    _address_line2 = response.data.address_line2;
    _country = response.data.country;
    _state = response.data.state;
    _city = response.data.city;
    _pin_code = response.data.pin_code;
    setState(() {
      _logo = response.data.logo;
    });

//    _logo_original = response.data.logo_original;
    logo_path = response.data.logo_original;
    print(Constants.BASE_URL+'uploads/images/'+_logo);
  }
}