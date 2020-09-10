import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/profile/profile_bloc.dart';
import 'package:scrapgreen/bloc/profile/profile_event.dart';
import 'package:scrapgreen/bloc/profile/profile_state.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/email_validator.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:scrapgreen/utils/dialogBox.dart';
import 'package:scrapgreen/models/addItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class RequestDetails extends StatefulWidget {
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
//  List uploadDocList = [
//    {"courseName": "Bachelor of Education (B.Ed)"},
//    {"courseName": "Master of Education (M.Ed)"}
//  ];
  final List<AddItem> itemList = [
    AddItem('Iron', '7', 'KG', '700'),
    AddItem('Iron', '8', 'KG', '800'),
    AddItem('Iron', '9', 'KG', '900'),
    AddItem('Iron', '10', 'KG', '1000'),
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _loadingKey = GlobalKey<State>();

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
          appBar: AppSingleton.instance.buildAppBar(onTap, 'Request Details'),
          body: SingleChildScrollView(
//            height: MediaQuery.of(context).size.height,
//            width: MediaQuery.of(context).size.width,
            child: Column(
//              direction: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                child: Text('Order No.:REC007.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                child: Text('19.05.2020 12:29PM',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                child: Text('Ghatkopar-West,400084.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                child: Text('Total: Rs. 0.00',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.add_circle,
                                  size: 28.0,
                                  color: Colors.green,
                                ),
                                tooltip: 'Add items',
                                // onPressed: () {
                                //   return DialogBox();
                                // },
                                onPressed: successAlert,
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(30.0),
                                  side: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () {},
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Text(
                                  "In Progress",
                                  style: AppTextStyle.regular(
                                    Colors.white, 10.0,
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
//                Text('-------------------------------------------',
//                  style: TextStyle(
//                    fontSize: 28.0,
//                    color: Colors.grey
//                  ),
//                ),
                Divider(),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text('ITEMS FOR PICKUP',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
//                Text('-------------------------------------------',
//                  style: TextStyle(
//                    fontSize: 28.0,
//                    color: Colors.grey
//                  ),
//                ),
                Divider(),
                Container(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return
                        //Card(child:Column(children: <Widget>[new ListTile(title:new Text(applicationList[index]['customerName'])), new ListTile(title:new Text(applicationList[index]['tokenNumber']))]), elevation: 6,)

                        Padding(
                          padding:
                          EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: Card(
                            elevation: 8,
                            child: ListTile(
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset('assets/recycle.png',
                                      width: 28, height: 28),
                                  SizedBox(
                                    width: AppSingleton.instance.getHeight(
                                        10.0),
                                  ),
                                  Text(itemList[index].quantity + ' KG.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              title: Text(itemList[index].material,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0
                                ),
                              ),
                              subtitle:
                              Text('Rs. 100/KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Rs. ' + itemList[index].rupees + '.00',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppSingleton.instance.getWidth(10),
                                  ),
                                  Image.asset('assets/criss-cross.png',
                                      width: 25, height: 25, fit: BoxFit.contain
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                    },
                  ),
                ),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // onPressed: loginCheck,
                          onPressed: () {},
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          color: Colors.green,
                          child: Text('SAVE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // onPressed: loginCheck,
                          onPressed: () {},
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          color: Colors.red,
                          child: Text('CANCEL',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
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
      ),
    );
  }

  successAlert() {
    // DialogBox.showLoadingDialog(context, _loadingKey);
    // return DialogBox();
    showDialog(context: context, builder: (context) {
      return DialogBox();
    },
    );
  }
}