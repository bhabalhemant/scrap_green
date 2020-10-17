import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/history_bloc.dart';
import 'package:scrapgreen/bloc/schedule_history_bloc.dart';
import 'package:scrapgreen/bloc/assigned_history_bloc.dart';
import 'package:scrapgreen/bloc/success_history_bloc.dart';
import 'package:scrapgreen/models/response/pickup_request_response.dart';
import 'package:scrapgreen/models/response/pickup_request_schedule_response.dart';
import 'package:scrapgreen/models/response/pickup_request_assigned_response.dart';
import 'package:scrapgreen/models/response/pickup_request_success_response.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin{
  TabController _tabController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
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
            leading: onTap(),
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
              Schedule(),
              Assigned(),
              Success(),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }

  Widget Schedule(){
    return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: BlocConsumer(
                    bloc: BlocProvider.of<ScheduleHistoryBloc>(context),
                    listener: (context, state) {
                      if (state is ScheduleHistoryLoaded) {
                        _isLoading = false;
                        if (state.response.data1.isEmpty) {
                          _hasMoreItems = false;
                        }
                        _data1.addAll(state.response.data1);
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
                        return buildListSchedule(state.response.msg);
                      }
                      return buildListSchedule('');
                    },
                  ),
                ),
              ],
            ),
//          ),
    );
  }

  Widget Assigned(){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Expanded(
            child: BlocConsumer(
              bloc: BlocProvider.of<AssignedHistoryBloc>(context),
              listener: (context, state) {
                      print(state);
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
                  return buildListAssigned(state.response.msg);
                }
                return buildListAssigned('');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget Success(){
    return Container(
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
                  return buildListSucces(state.response.msg);
                }
                return buildListSucces('');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListSchedule(String message) {
    return _data1.length > 0 ? ListView.builder(
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
    ):  Container(
        child: Text('No data to display!')
    );
  }

  Widget buildListAssigned(String message) {
//    print(_data2.length);
    return _data2.length > 0 ? ListView.builder(
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
    ):  Container(
      child: Text('No data to display!')
    );
  }

  Widget buildListSucces(String message) {
    return _data3.length > 0 ? ListView.builder(
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
    ):  Container(
        child: Text('No data to display!')
    );
  }
}
