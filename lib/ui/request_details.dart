import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/bloc/profile/profile_bloc.dart';
import 'package:scrapgreen/bloc/profile/profile_event.dart';
import 'package:scrapgreen/bloc/profile/profile_state.dart';
import 'package:scrapgreen/models/addItem.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/email_validator.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:scrapgreen/utils/dialogBox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class RequestDetails extends StatefulWidget {
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _loadingKey = GlobalKey<State>();
  final List<AddItem> itemList = [
    AddItem('Iron', '7', '700'),
    AddItem('Copper', '8', '800'),
    AddItem('Platinum', '9', '900'),
  ];
  List<Widget> itemsList;
//  var items = [{"quantity": 7, "material": "Iron", "rupees": 700}, {"quantity": 7, "material": "Copper", "rupees": 1400}];
//  var items = [{"quantity": "7", "material": "Iron", "rupees": "700"}, {"quantity": "7", "material": "Copper", "rupees": "1400"}];
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
          body: listing(),
        ),
      ),
    );
  }
  listing(){
//    return Flex(
//        direction: Axis.vertical,
//        children: <Widget>[
//          Padding(
//          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//              child: Padding(
//              padding: EdgeInsets.symmetric(vertical:5.0),
//              child: Column(
//              mainAxisSize: MainAxisSize.max,
//                children: <Widget>[
//                  ListTile(
//                    title: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
//                            child: Text('Order No.:REC007.',
//                            textAlign: TextAlign.left,
//                            style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
//                          child:Text('19.05.2020 12:29PM',
//                            textAlign: TextAlign.left,
//                          ),
//                          ),
//                        ],
//                      ),
//                        subtitle: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
//                            child:Text('Ghatkopar-West,400084.',
//                              textAlign: TextAlign.left,
//                              style: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                color: Colors.black
//                              ),
//                            ),
//                          ),
//                            Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
//                              child: Text('Total: Rs. 0.00',
//                                textAlign: TextAlign.left,
//                                style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 20.0
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      isThreeLine: true,
//                      trailing: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        IconButton(
//                          icon: Icon(Icons.add_circle,
//                          size: 28.0,
//                          color: Colors.green,
//                        ),
//                        tooltip: 'Add items',
//                        // onPressed: () {
//                        //   return DialogBox();
//                        // },
//                        onPressed: (){
//
//                        },
//                        ),
//                        RaisedButton(
//                          shape: RoundedRectangleBorder(
//                          borderRadius:
//                          BorderRadius.circular(30.0),
//                            side: BorderSide(
//                              color: Colors.blue,
//                            ),
//                          ),
//                          onPressed: (){
//
//                          },
//                          color: Colors.blue,
//                          textColor: Colors.white,
//                          child: Text(
//                            "In Progress",
//                            style: AppTextStyle.regular(
//                              Colors.white, 10.0,
//                            ),
//                          ),
//                        ),
//
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//          Divider(),
//          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//            child: Text('ITEMS FOR PICKUP',
//              style: TextStyle(
//                  fontSize: 22.0,
//                  fontWeight: FontWeight.w600
//              ),
//            ),
//          ),
//          Divider(),
//        ],
//    );

    ListView.builder
      (
        itemCount: itemList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(itemList[index].material);
        }
    );
//    itemList.map((AddItem item) {
//      print(item.material+' '+item.quantity+' '+item.rupees);
//      return Text(
//        '${item.material}'
//      );
//      return SingleChildScrollView(
//        child: Padding(
//        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//        child: Card(
//          color: Colors.grey[200],
//          child: Padding(
//            padding: EdgeInsets.symmetric(vertical:0),
//            child: Column(
//              mainAxisSize: MainAxisSize.max,
//              children: <Widget>[
//                ListTile(
//                  leading: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Image.asset('assets/recycle.png',
//                          width: 28, height: 28),
//                      SizedBox(
//                        width: AppSingleton.instance.getHeight(10.0),
//                      ),
//                      Text(item.quantity+' KG.',
//                        style: TextStyle(fontWeight: FontWeight.bold),
//                      ),
//                    ],
//                  ),
//                  title: Text(item.material,
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        fontSize: 16.0
//                    ),
//                  ),
//                  subtitle:
//                  Text('Rs. 100/KG.',
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                  trailing: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Text('Rs. '+ item.rupees +'.00',
//                        style: TextStyle(
//                            color: Colors.blue,
//                            fontWeight: FontWeight.bold,
//                            fontSize: 14.0
//                        ),
//                      ),
//                      SizedBox(
//                        width: AppSingleton.instance.getWidth(10),
//                      ),
//                      Image.asset('assets/criss-cross.png',
//                          width: 25, height: 25, fit: BoxFit.contain
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//        ),
//      );
//    }).toList();
//    itemList.map((AddItem item) {
//      print(item.material+' '+item.quantity+' '+item.rupees);
//      return SingleChildScrollView(
//        child: Padding(
//          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//          child: Card(
//            color: Colors.grey[200],
//            child: Padding(
//              padding: EdgeInsets.symmetric(vertical:0),
//              child: Column(
//                mainAxisSize: MainAxisSize.max,
//                children: <Widget>[
//                  ListTile(
//                    leading: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Image.asset('assets/recycle.png',
//                            width: 28, height: 28),
//                        SizedBox(
//                          width: AppSingleton.instance.getHeight(10.0),
//                        ),
//                        Text(' KG.',
//                          style: TextStyle(fontWeight: FontWeight.bold),
//                        ),
//                      ],
//                    ),
//                    title: Text('Iron',
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 16.0
//                      ),
//                    ),
//                    subtitle:
//                    Text('Rs. 100/KG.',
//                      style: TextStyle(fontWeight: FontWeight.bold),
//                    ),
//                    trailing: Row(
//                      mainAxisSize: MainAxisSize.min,
//                      children: <Widget>[
//                        Text('Rs. 700.00',
//                          style: TextStyle(
//                              color: Colors.blue,
//                              fontWeight: FontWeight.bold,
//                              fontSize: 14.0
//                          ),
//                        ),
//                        SizedBox(
//                          width: AppSingleton.instance.getWidth(10),
//                        ),
//                        Image.asset('assets/criss-cross.png',
//                            width: 25, height: 25, fit: BoxFit.contain
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      );
//    }).toList();
  }
//  successAlert() {
//    // DialogBox.showLoadingDialog(context, _loadingKey);
//    // return DialogBox();
//    showDialog(context: context, builder: (context) {
//       return DialogBox();
//       },
//      );
//  }

}