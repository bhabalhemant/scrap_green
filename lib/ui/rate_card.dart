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

class _RateCardState extends State<RateCard> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String _id;
  String _icon;
  String _icon_original;
  String _material;
  String _unit;
  String _unit_qty;
  String _rate;
  String _status;
  String _created_on;
  String _created_by;
  String _last_modified_on;
  String _last_modified_by;
  @override
  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
  }
  void initState() {
    super.initState();
    BlocProvider.of<RateCardBloc>(context).add(GetRateCard());
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return AppSingleton.instance.goBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Rate Card'),
//          body: buildRateScreen(),
            body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: BlocConsumer(
                    bloc: BlocProvider.of<RateCardBloc>(context),
                    listener: (context, state) {
//                      print(state);
                      if (state is RateCardLoaded) {
                        _setData(state.response);
                      }
                      if (state is RateCardUpdated) {
                        _showSuccessMessage(state.response.msg);
                        BlocProvider.of<RateCardBloc>(context).add(GetRateCard());
                      }
                      if (state is RateCardError) {
                        _showError(state.msg);
                      }
                    },
                    builder: (context, state) {
                      if (state is RateCardLoaded) {
                        return buildRateScreen();
                      } else if (state is RateCardLoading) {
                        return Center(
                          child: AppSingleton.instance.buildCenterSizedProgressBar(),
                        );
                      } else if (state is RateCardError) {
                        return Center(
                          child: Text(
                            'Failed to get rate card error',
                            style: AppTextStyle.bold(Colors.red, 30.0),
                          ),
                        );
                      } else if (state is RateCardUploading) {
                        return AppSingleton.instance.buildCenterSizedProgressBar();
                      } else if (state is RateCardEmpty) {
                        return Center(
                          child: Text(
                            'Failed to get rate card data profile empty',
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
        ),
      ), 
    );
  }

  Widget buildRateScreen() {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
       children: List.generate(4, (index) {
       return Center(
       child:Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(2, 10, 2, 2),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Card(
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical:10, horizontal:10),
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 100.0,
                  ),
//                  child: Image.network(Constants.BASE_URL + _icon_original),
                ),
              ),
              Text('${_material}-810/KG',
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

  void _setData(RateCardResponse response) {
    print('no0${response.data}');
    _id = response.data.id;
    _icon = response.data.icon;
    _icon_original = response.data.icon_original;
    _material = response.data.material;
    _unit = response.data.unit;
    _unit_qty = response.data.unit_qty;
    _rate = response.data.rate;
    _status = response.data.status;
    _created_on = response.data.created_on;
    _created_by = response.data.created_by;
    _last_modified_on = response.data.last_modified_on;
    _last_modified_by = response.data.last_modified_by;
  }

  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
  }
  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}