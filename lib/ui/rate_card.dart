import 'package:flutter/cupertino.dart';
import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/rate_card/rate_card_bloc.dart';
import 'package:scrapgreen/bloc/rate_card/rate_card_state.dart';
import 'package:scrapgreen/bloc/rate_card/rate_card_event.dart';
import 'package:scrapgreen/models/response/rate_card_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/email_validator.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RateCard extends StatefulWidget {
  @override
  _RateCardState createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> with SingleTickerProviderStateMixin {
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
  String logo_path = 'https://apptroidtechnology.in/scrap_green/uploads/images/aaab7f8d09e7350e13201682ba2e4030.jpg';

  int startFrom = 0;
  ScrollController _controller = ScrollController();
  List<Data> _data = List();
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
    _data.clear();
    BlocProvider.of<RateCardBloc>(context).add(GetRateCard());
  }

  _scrollListener() {
    if (!_isLoading) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          _hasMoreItems) {
        startFrom += 30;
        _isLoading = true;

        BlocProvider.of<RateCardBloc>(context).add(GetRateCard());
      }
    }
  }

  @override
  onTap() {
//    if (scaffoldKey.currentContext != null) {
//      Navigator.of(scaffoldKey.currentContext).pop(true);
//    }
    Navigator.pushNamed(context, Constants.ROUTE_HOME);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return AppSingleton.instance.goBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Rate Card'),
//          appBar: new AppBar(
//            automaticallyImplyLeading: true,
//            centerTitle: true,
//            iconTheme: IconThemeData(
//              color: Colors.green, //change your color here
//            ),
//            title: Image.asset(
//              'assets/scrap_green_logo.png',
//              height: 37.0,
////            alignment: Alignment.center,
//            ),
//            actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.account_circle),
//                onPressed: () async {
////                  Navigator.pushNamed(context, Constants.ROUTE_SETTING);
//                },
//                color: Colors.lightGreen,
//              ),
//            ],
//            backgroundColor: Colors.white,
//            bottom: new TabBar(
//              labelColor: Colors.green,
//              unselectedLabelColor: Colors.lightGreen,
//              indicatorColor: Colors.green,
//              tabs: <Tab>[
//                new Tab(
//                  text: "SCHEDULE",
////                  icon: new Icon(Icons.history),
//                ),
//                new Tab(
//                  text: "ASSIGNED",
////                  icon: new Icon(Icons.history),
//                ),
//                new Tab(
//                  text: "SUCCESS",
////                  icon: new Icon(Icons.history),
//                ),
//              ],
//              controller: _tabController,
//            ),
//          ),
//          body: test(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
//            child: Flex(
//              direction: Axis.vertical,
//              children: <Widget>[
                child: Expanded(
//                  flex: 1,
                  child: BlocConsumer(
                    bloc: BlocProvider.of<RateCardBloc>(context),
                    listener: (context, state) {
                      if (state is RateCardLoaded) {
                        _isLoading = false;
                        if (state.response.data.isEmpty) {
                          _hasMoreItems = false;
                        }
                        _data.addAll(state.response.data);
                      }
                    },
                    builder: (context, state) {
                      if (state is RateCardLoading) {
                        return AppSingleton.instance
                            .buildCenterSizedProgressBar();
                      }
                      if (state is RateCardError) {
                        return Center(
                          child: Text(state.msg),
                        );
                      }
                      if (state is RateCardLoaded) {
                        return buildRateScreen(state.response.msg);
                      }
                      return buildRateScreen('');
                    },
                  ),
                ),
                //                profileScreen(),
//              ],
//            ),
          ),
        ),
      ),
    );
  }

  Widget buildRateScreen(String message) {
    return _data.length > 0 ? GridView.count(
      crossAxisCount: 2,
//      crossAxisSpacing: 160,
//      childAspectRatio: 3,
      children: _data.map((value) {
        return Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 10, 2, 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Card(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
//                            child: Icon(
//                              Icons.email,
//                              color: Colors.white,
//                              size: 100.0,
//                            ),
                  child: Image.network(
                    Constants.BASE_URL + 'logo/' + value.icon_original,
                    width: 100.0,
                    height: 100.0,
                  ),
                          ),
                        ),
                        Text('${value.material}-${value.rate}/KG',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            );
      }).toList(),
    ):
    Container(
      child: Text('No data to display!')
    );
//    return _data.length > 0 ? ListView.builder(
//      physics: ClampingScrollPhysics(),
//      shrinkWrap: true,
//      itemCount: _data.length,
//      itemBuilder: (context, index) {
////        return Container(
////          child: Text('${_data[index].material}'),
////        );
//        return GridView.count(
//          crossAxisCount: 2,
//          children: List.generate(_data.length, (index) {
//            return Center(
//              child: Column(
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.fromLTRB(2, 10, 2, 2),
//                    child: Column(
//                      mainAxisSize: MainAxisSize.max,
//                      children: <Widget>[
//                        Card(
//                          color: Colors.green,
//                          child: Padding(
//                            padding: EdgeInsets.symmetric(
//                                vertical: 10, horizontal: 10),
//                            child: Icon(
//                              Icons.email,
//                              color: Colors.white,
//                              size: 100.0,
//                            ),
////                  child: Image.network(Constants.BASE_URL + _icon_original),
//                          ),
//                        ),
//                        Text('${_data[index].material}-${_data[index].rate}/KG',
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//
//                ],
//              ),
//            );
//          }),
//        );
//      },

  }

  Widget test(){
        return GridView.count(
          crossAxisCount: 2,
          children: List.generate(1, (index) {
            return Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 10, 2, 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Card(
                          color: Colors.green,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 100.0,
                            ),
//                  child: Image.network(Constants.BASE_URL + _icon_original),
                          ),
                        ),
                        Text('tets material-40/KG',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            );
          }),
        );
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }

}