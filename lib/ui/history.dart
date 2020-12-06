import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_bloc.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_event.dart';
import 'package:scrapgreen/bloc/vendor_profile/vendor_profile_state.dart';
import 'package:scrapgreen/bloc/schedule_history_bloc.dart';
import 'package:scrapgreen/bloc/assigned_history_bloc.dart';
import 'package:scrapgreen/bloc/success_history_bloc.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:scrapgreen/ui/drawer_v1.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrapgreen/models/response/vendor_profile_response.dart';
import 'package:scrapgreen/models/response/pickup_request_schedule_response.dart';
import 'package:scrapgreen/models/response/pickup_request_success_response.dart';
import 'package:scrapgreen/models/response/pickup_request_assigned_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin{
  TabController _tabController;
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

  int startFrom = 0;
  ScrollController _controller = ScrollController();
  List<Data1> _data1 = List();
  List<Data2> _data2 = List();
  List<Data3> _data3 = List();
  bool _isLoading = false;
  bool _hasMoreItems = true;

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    _tabController = new TabController(vsync: this, length: 3);
    _data1.clear();
    _data2.clear();
    _data3.clear();
//    BlocProvider.of<HistoryBloc>(context)
//        .add(HistoryEvent(startFrom: startFrom.toString()));
    BlocProvider.of<ScheduleHistoryBloc>(context)
        .add(ScheduleHistoryEvent(startFrom: startFrom.toString()));
    BlocProvider.of<AssignedHistoryBloc>(context)
        .add(AssignedHistoryEvent(startFrom: startFrom.toString()));
    BlocProvider.of<SuccessHistoryBloc>(context)
        .add(SuccessHistoryEvent(startFrom: startFrom.toString()));
  }

  _scrollListener() {
    if (!_isLoading) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          _hasMoreItems) {
        startFrom += 30;
        _isLoading = true;
//        BlocProvider.of<HistoryBloc>(context)
//            .add(HistoryEvent(startFrom: startFrom.toString()));
        BlocProvider.of<ScheduleHistoryBloc>(context)
            .add(ScheduleHistoryEvent(startFrom: startFrom.toString()));
        BlocProvider.of<AssignedHistoryBloc>(context)
            .add(AssignedHistoryEvent(startFrom: startFrom.toString()));
        BlocProvider.of<SuccessHistoryBloc>(context)
            .add(SuccessHistoryEvent(startFrom: startFrom.toString()));
      }
    }
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
          appBar: new AppBar(
            backgroundColor: Colors.green,
//            leading: onTap(),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pushNamed(context, Constants.ROUTE_HOME);
                    },
                );
              },
            ),
            title: new Text('HISTORY',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            bottom: new TabBar(
              tabs: <Tab>[
                new Tab(
                  text: "SCHEDULE",
//                  icon: new Icon(Icons.history),
                ),
                new Tab(
                  text: "ASSIGNED",
//                  icon: new Icon(Icons.history),
                ),
                new Tab(
                  text: "SUCCESS",
//                  icon: new Icon(Icons.history),
                ),
              ],
              controller: _tabController,
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
//              Schedule(),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: BlocConsumer(
                        bloc: BlocProvider.of<ScheduleHistoryBloc>(context),
                        listener: (context, state) {
                          if (state is SuccessHistoryLoaded) {
                            _isLoading = false;
//                            if (state.response.data1.isEmpty) {
//                              _hasMoreItems = false;
//                            }
//                            _data1.addAll(state.response.data1);
                          }
                        },
                        builder: (context, state) {
                          if (state is ScheduleHistoryLoading) {
                            return AppSingleton.instance
                                .buildCenterSizedProgressBar();
                          }
                          if (state is ScheduleHistoryError) {
                            return Center(
                              child: Text(state.msg),
                            );
                          }
                          if(state is ScheduleHistoryLoaded){
                            return buildListSchedule(state.response.data1);
                          }
                          return buildListSchedule(state.response.data1);
                        },
                      ),
                    ),
                  ],
                ),
              ),
//              Assigned(),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: BlocConsumer(
                        bloc: BlocProvider.of<AssignedHistoryBloc>(context),
                        listener: (context, state) {
//                          print(state);
                          if (state is AssignedHistoryLoaded) {
                            _isLoading = false;
                            if (state.response.data2.isEmpty) {
                              _hasMoreItems = false;
                            }
                            _data2.addAll(state.response.data2);
                          }
                        },
                        builder: (context, state) {
                          if (state is AssignedHistoryLoading) {
                            return AppSingleton.instance
                                .buildCenterSizedProgressBar();
                          }
                          if (state is AssignedHistoryError) {
                            return Center(
                              child: Text(state.msg),
                            );
                          }
                          if(state is AssignedHistoryLoaded){
                            return buildListAssigned(state.response.data2);
                          }
                          return buildListAssigned(state.response.data2);
                        },
                      ),
                    ),
                  ],
                ),
              ),
//              Icon(Icons.directions_bike),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: BlocConsumer(
                        bloc: BlocProvider.of<SuccessHistoryBloc>(context),
                        listener: (context, state) {
                          if (state is SuccessHistoryLoaded) {
                            _isLoading = false;
                            if (state.response.data3.isEmpty) {
                              _hasMoreItems = false;
                            }
                            _data3.addAll(state.response.data3);
                          }
                        },
                        builder: (context, state) {
                          if (state is SuccessHistoryLoading) {
                            return AppSingleton.instance
                                .buildCenterSizedProgressBar();
                          }
                          if (state is SuccessHistoryError) {
                            return Center(
                              child: Text(state.msg),
                            );
                          }
                          if(state is SuccessHistoryLoaded){
                            return buildListSuccess(state.response.data3);
                          }
                          return buildListSuccess(state.response.data3);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
            controller: _tabController,
          ),
          drawer: DrawerV1(),
        ),
      ),
    );
  }
  Widget buildListSchedule(List<Data1> _data1) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _data1.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Column(
            children: <Widget>[
              _data1[index].request_status == '0'
                  ? Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        onTap: (){
                          Map<String, String> body = {
                            Constants.PARAM_REQUEST_ID: _data1[index].id,
                          };
                        String request_id = _data1[index].id;
                          BlocProvider.of<ScheduleHistoryBloc>(context).add(ScheduleRequestIdEvent(body: body));
                          Navigator.pushNamed(context, Constants.ROUTE_HISTORY_DETAILS);
                        },
                        leading: Image.asset('assets/recycle.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text(
                          'Order No: ${_data1[index].id}',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_data1[index].created_on}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12.0,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              '${_data1[index].address_line1}, ${_data1[index].address_line2}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 11.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          children: <Widget>[
                            Text(
                              ' ',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.blue,
                              ),
                              child: Text(
                                'Scheduled',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0
                                ),
                              ),
                            )
//                          ),
//                        ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ):
              Container()
            ],
          ),

        );
      },
    );
  }

  Widget buildListAssigned(List<Data2> _data2) {
//    print(_data2.length);
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _data2.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Column(
            children: <Widget>[
              _data2[index].request_status == '1'
                  ? Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        onTap: (){
                          Map<String, String> body = {
                            Constants.PARAM_REQUEST_ID: _data2[index].id,
                          };
                          BlocProvider.of<AssignedHistoryBloc>(context).add(AssignedRequestIdEvent(body: body));
                          Navigator.pushNamed(context, Constants.ROUTE_HISTORY_DETAILS);
                        },
                        leading: Image.asset('assets/recycle.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text(
                          'Order No: ${_data2[index].id}',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_data2[index].created_on}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12.0,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              '${_data2[index].address_line1}, ${_data2[index].address_line2}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 11.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          children: <Widget>[

                            _data2[index].request_status == '4'
                                ? Text(
                              'Rs. ${_data2[index].total_amount}',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                                :Text(
                              ' ',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.orange,
                              ),
                              child: Text(
                                'Assigned',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ):
              Container()
            ],
          ),
        );
      },
    );
  }

  Widget buildListSuccess(List<Data3> _data3) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _data3.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Column(
            children: <Widget>[
              _data3[index].request_status == '2'
                  ? Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        onTap: (){
                          Map<String, String> body = {
                            Constants.PARAM_REQUEST_ID: _data3[index].id,
                          };
                          BlocProvider.of<SuccessHistoryBloc>(context).add(SuccessRequestIdEvent(body: body));
                          Navigator.pushNamed(context, Constants.ROUTE_HISTORY_DETAILS);
                        },
                        leading: Image.asset('assets/recycle.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text(
                          'Order No: ${_data3[index].id}',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_data3[index].created_on}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12.0,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              '${_data3[index].address_line1}, ${_data3[index].address_line2}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 11.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          children: <Widget>[
                            Text(
                              ' ',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.redAccent,
                              ),
                              child: Text(
                                'User Cancelled',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0
                                ),
                              ),
                            )
//                          ),
//                        ),
                          ],
                        ),
                      )
//                  SizedBox(height: AppSingleton.instance.getHeight(0)),
                    ],
                  ),
                ),
              ):
              _data3[index].request_status == '3'
                  ? Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        onTap: (){
                          Map<String, String> body = {
                            Constants.PARAM_REQUEST_ID: _data3[index].id,
                          };
                          BlocProvider.of<SuccessHistoryBloc>(context).add(SuccessRequestIdEvent(body: body));
                          Navigator.pushNamed(context, Constants.ROUTE_HISTORY_DETAILS);
                        },
                        leading: Image.asset('assets/recycle.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text(
                          'Order No: ${_data3[index].id}',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_data3[index].created_on}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12.0,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              '${_data3[index].address_line1}, ${_data3[index].address_line2}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 11.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          children: <Widget>[
                            Text(
                              ' ',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                              ),
                              child: Text(
                                'Admin Cancelled',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0
                                ),
                              ),
                            )
//                          ),
//                        ),
                          ],
                        ),
                      )
//                  SizedBox(height: AppSingleton.instance.getHeight(0)),
                    ],
                  ),
                ),
              ):
              _data3[index].request_status == '4'
                  ? Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        onTap: (){
                          Map<String, String> body = {
                            Constants.PARAM_REQUEST_ID: _data3[index].id,
                          };
                          BlocProvider.of<SuccessHistoryBloc>(context).add(SuccessRequestIdEvent(body: body));
                          Navigator.pushNamed(context, Constants.ROUTE_HISTORY_DETAILS);
                        },
                        leading: Image.asset('assets/recycle.png',
                            width: 62, height: 62, fit: BoxFit.contain),
                        title: Text(
                          'Order No: ${_data3[index].id}',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_data3[index].created_on}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12.0,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              '${_data3[index].address_line1}, ${_data3[index].address_line2}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 11.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          children: <Widget>[
                            Text(
                              'Rs. ${_data3[index].total_amount}',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
                              height: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.green,
                              ),
                              child: Text(
                                'Successfull',
//                                textScaleFactor: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0
                                ),
                              ),
                            ),
//                          ),
//                        ),
                          ],
                        ),
                      )
//                  SizedBox(height: AppSingleton.instance.getHeight(0)),
                    ],
                  ),
                ),
              ):
              Container()
            ],
          ),
        );
      },
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
  }
}
