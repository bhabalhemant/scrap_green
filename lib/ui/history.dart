import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/history_bloc.dart';
import 'package:scrapgreen/models/response/pickup_request_response.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
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
    _data.clear();
    BlocProvider.of<HistoryBloc>(context)
        .add(HistoryEvent(startFrom: startFrom.toString()));
  }

  _scrollListener() {
    if (!_isLoading) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          _hasMoreItems) {
        startFrom += 30;
        _isLoading = true;
        BlocProvider.of<HistoryBloc>(context)
            .add(HistoryEvent(startFrom: startFrom.toString()));
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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'History'),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
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
                Expanded(
                  child: BlocConsumer(
                    bloc: BlocProvider.of<HistoryBloc>(context),
                    listener: (context, state) {
                      if (state is HistoryLoaded) {
                        _isLoading = false;
                        if (state.response.data.isEmpty) {
                          _hasMoreItems = false;
                        }
                        _data.addAll(state.response.data);
                      }
                    },
                    builder: (context, state) {
                      if (state is HistoryLoading) {
                        return AppSingleton.instance
                            .buildCenterSizedProgressBar();
                      }
                      if (state is HistoryError) {
                        return Center(
                          child: Text(state.msg),
                        );
                      }
                      if(state is HistoryLoaded){
                        return buildList(state.response.msg);
                      }
                      return buildList('');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildList(String message) {
    return _data.length > 0 ? ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Card(
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
                      'Order No: ${_data[index].id}',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${_data[index].created_on}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${_data[index].address_line1}, ${_data[index].address_line2}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Column(
                      children: <Widget>[
                        Text(
                          'Rs. ${_data[index].total_amount}',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {},
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text(
                              "Scheduled",
                              style: AppTextStyle.regular(
                                Colors.white,
                                10.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ):  Center(
      child: Text(message),
    );
  }
}
