import 'package:dana/base_widgets/app_textstyle.dart';
import 'package:dana/bloc/profile/profile_bloc.dart';
import 'package:dana/bloc/profile/profile_event.dart';
import 'package:dana/bloc/profile/profile_state.dart';
import 'package:dana/models/response/profile_response.dart';
import 'package:dana/utils/constants.dart' as Constants;
import 'package:dana/utils/email_validator.dart';
import 'package:dana/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:dana/utils/dialogBox.dart';
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
  String bLOODGRPselected;
  final List<String> _bloodValues = [
    "",
    "A+",
    "B+",
    "AB+",
    "O+",
    "A-",
    "B-",
    "AB-",
    "O-",
  ];
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                  child: Text('Order No.:REC007.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                  child:Text('19.05.2020 12:29PM',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                  child:Text('Ghatkopar-West,400084.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.add_circle,
                                          size: 38.0,
                                          color: Colors.green,
                                          ),
                                          tooltip: 'Add items',
                                          // onPressed: () {
                                            
                                          // },
                                          onPressed: successAlert,
                                        ),
                                        Expanded(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              side: BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            onPressed: errorMsg,
                                            color: Colors.blue,
                                            textColor: Colors.white,
                                            child: Text(
                                              "In Progress",
                                              style: AppTextStyle.regular(
                                                  Colors.white, 10.0,
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
                Text('-------------------------------------------',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.grey
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text('ITEMS FOR PICKUP',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text('-------------------------------------------',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.grey
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset('assets/recycle.png',
                              width: 28, height: 28),
                                SizedBox(
                                  width: AppSingleton.instance.getHeight(10.0),
                                ),
                                Text('7 KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            title: Text('IRON',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            ),
                            subtitle: 
                                Text('Rs. 100/KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Rs. 700.00',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0
                                  ),
                                ),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(10),
                                ),
                                Image.asset('assets/criss-cross.png',
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset('assets/recycle.png',
                              width: 28, height: 28),
                                SizedBox(
                                  width: AppSingleton.instance.getHeight(10.0),
                                ),
                                Text('7 KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            title: Text('IRON',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            ),
                            subtitle: 
                                Text('Rs. 100/KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Rs. 700.00',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0
                                  ),
                                ),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(10),
                                ),
                                Image.asset('assets/criss-cross.png',
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset('assets/recycle.png',
                              width: 28, height: 28),
                                SizedBox(
                                  width: AppSingleton.instance.getHeight(10.0),
                                ),
                                Text('7 KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            title: Text('IRON',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            ),
                            subtitle: 
                                Text('Rs. 100/KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Rs. 700.00',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0
                                  ),
                                ),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(10),
                                ),
                                Image.asset('assets/criss-cross.png',
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset('assets/recycle.png',
                              width: 28, height: 28),
                                SizedBox(
                                  width: AppSingleton.instance.getHeight(10.0),
                                ),
                                Text('7 KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            title: Text('IRON',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            ),
                            subtitle: 
                                Text('Rs. 100/KG.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Rs. 700.00',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0
                                  ),
                                ),
                                SizedBox(
                                  width: AppSingleton.instance.getWidth(10),
                                ),
                                Image.asset('assets/criss-cross.png',
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
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // onPressed: loginCheck,
                          onPressed: (){},
                          padding: EdgeInsets.symmetric(vertical:10.0),
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
                        padding: EdgeInsets.symmetric(horizontal:10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // onPressed: loginCheck,
                          onPressed: (){},
                          padding: EdgeInsets.symmetric(vertical:10.0),
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
  Widget successAlert() {
    Dialogs.showLoadingDialog(context, _loadingKey);
  }
    Widget errorMsg(){
       Alert(
        context: context,
        title: "LOGIN",
        content: Column(
          children: <Widget>[
            DropdownButtonFormField<String> (
                value: bLOODGRPselected,
                hint: Text("Select material", maxLines: 1),
                validator: (String arg){
                  if(arg == null){
                    return 'Please select your choice.';
                  }
                },
                items: _bloodValues.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: new Text(item,
                    //value ?? "",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => bLOODGRPselected = value);
                },
            ),
            DropdownButtonFormField<String> (
                value: bLOODGRPselected,
                hint: Text("Select unit", maxLines: 1),
                validator: (String arg){
                  if(arg == null){
                    return 'Please select your choice.';
                  }
                },
                decoration: InputDecoration(
                  fillColor: AppSingleton.instance.getLightGrayColor(),
                  hintText: 'Enter quantity',
                  // errorText: _autoValidate ? 'Value Can\'t Be Empty' : null,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                ),
                items: _bloodValues.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: new Text(item,
                    //value ?? "",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => bLOODGRPselected = value);
                },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              // // controller: nAMEFCTRL, 
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter First Name';
                }
                return null;
              },
              decoration: InputDecoration(
                fillColor: AppSingleton.instance.getLightGrayColor(),
                hintText: 'Enter quantity',
                // errorText: _autoValidate ? 'Value Can\'t Be Empty' : null,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.blue,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "ADD",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  } 
}